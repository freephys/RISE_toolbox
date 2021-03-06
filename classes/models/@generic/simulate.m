function [db,states,retcode] = simulate(obj,varargin)
% simulate - simulates a RISE model
%
% Syntax
% -------
% ::
%
%   [db,states,retcode] = simulate(obj,varargin)
%
% Inputs
% -------
%
% - **obj** [rfvar|dsge|rise|svar]: model object
%
% - **varargin** : additional arguments including but not restricted to
%
%   - **simul_periods** [integer|{100}]: number of simulation periods
%
%   - **simul_burn** [integer|{100}]: number of burn-in periods. This
%   should not be confused with forecast_conditional_sampling_burnin, which
%   is used in the sampling from the truncated multivariate normal
%   distribution.
%
%   - **simul_historical_data** [ts|struct|{''}]: historical data from
%       which the simulations are based. If empty, the simulations start at
%       the steady state.
%
%   - **simul_history_end_date** [char|integer|serial date]: last date of
%       history
%
%   - **simul_regime** [integer|vector|function handle|{[]}]: regimes for
%       which the model is simulated. When it is a function handle, then it
%       should accept as inputs y (new proposal), rt(current regime),
%       regimes_1_t_1(regimes from 1 to t-1), sims_1_t_1(the simulated
%       series up to t-1),varargin (possibly further arguments to the
%       function handle). The output is a logical that is true if the
%       simulation (vector y) is feasible/accepted and false otherwise.
%
%   - **simul_update_shocks_handle** [function handle]: we may want to
%       update the shocks if some condition on the state of the economy is
%       satisfied. For instance, shock monetary policy to keep the interest
%       rate at the floor for an extented period of time if we already are
%       at the ZLB/ZIF. simul_update_shocks_handle takes as inputs the
%       current shocks and the state vector (all the endogenous variables)
%       and returns the updated shocks. But for all this to be put into
%       motion, the user also has to turn on **simul_do_update_shocks** by
%       setting it to true.
%
%   - **simul_do_update_shocks** [true|{false}]: update the shocks based on
%       **simul_update_shocks_handle** or not. 
%
%   - **simul_to_time_series** [{true}|false]: if true, the output is a
%       time series, else a cell array with a matrix and information on
%       elements that help reconstruct the time series.
%
%   - **simul_honor_constraints** [true|{false}]: honor restrictions during
%       simulations. If true, agents have to be able anticipate the future.
%
%   - **simul_frwrd_back_shoot** [true|{false}]: uses an algorithm that
%   checks the constraints are satisfied at all horizons instead of just
%   one at a time.
%
%   - **simul_shock_uncertainty** [{true}|false]: draw shocks over the
%   simulation horizon.
%
%   - **simul_honor_constraints_through_switch** [true|{false}]: if true,
%   constraints are honored through the switching mechanism. In that case
%   the number of regimes should be greater than 1. If false, constraints
%   are honored through an anticipatory behavior. In this case, there
%   should be shocks that are foreseen.
%
%   - **simul_anticipate_zero** [true|{false}]: When shocks are drawn, this
%   option allows to impose that agents continue to see only the
%   contemporaneous shocks.
%
%   - **simul_bgp_deviation** [true|{false}]: When the model is
%   nonstationary, a growth component appears in the solution. This option
%   enables or disables that component.
%
% Outputs
% --------
%
% - **db** [struct|cell array]: if **simul_to_time_series** is true, the
%   output is a time series, else a cell array with a matrix and
%   information on elements that help reconstruct the time series.
%
% - **states** [vector]: history of the regimes over the forecast horizon
%
% - **retcode** [integer]: if 0, the simulation went fine. Else something
%   got wrong. In that case one can understand the problem by running
%   decipher(retcode)
%
% More About
% ------------
%
% - **simul_historical_data** contains the historical data as well as
%   conditional information over the forecast horizon. It may also include
%   as an alternative to **simul_regime**, a time series with name
%   **regime**, which indicates the regimes over the forecast horizon.
%
% Examples
% ---------
%
% See also: 

if isempty(obj)
    
    mydefaults=the_defaults();
    
    if nargout
        
        db=mydefaults;
        
    else
        
        disp_defaults(mydefaults);
        
    end
    
    return
    
end

nobj=numel(obj);

if nobj>1
    
    retcode=nan(1,nobj);
    
    states=cell(1,nobj);
    
    db=cell(1,nobj);
    
    for iobj=1:nobj
        
        [db{iobj},states{iobj},retcode(iobj)] = simulate(obj(iobj),varargin{:});
        
    end
    
    db=format_simulated_data_output(db);
    
    return
    
end

[obj,retcode]=solve(obj,varargin{:});
% note that the solving of the model may change the perturbation
% order. More explicitly optimal policy irfs will be computed for a
% perturbation of order 1 no matter what order the user chooses.
% This is because we have not solved the optimal policy problem
% beyond the first order.
if retcode
    
    error('model cannot be solved')
    
end

% initial conditions
%-------------------
Initcond=set_simulation_initial_conditions(obj);

y0=Initcond.y;

if numel(y0)>1
    
    error('more than one initial conditions')
    
end

% use the steady state with possibly loglinear variables

[y,states,retcode,~,myshocks]=utils.forecast.multi_step(y0(1),...
    Initcond.log_var_steady_state,Initcond.T,...
    Initcond.state_vars_location,Initcond);

if retcode
    
    error(decipher(retcode))
    
end

% add initial conditions: (only the actual data on the first page)
% ONLY IF THERE WAS NO BURN-IN
%---------------------------------------------------------------
[nr,nc,npy]=size(y);

if Initcond.burn==0
    % we include history
    y=cat(2,y0(1).y(:,:,ones(npy,1)),y);
    
    y0cols=size(y0(1).y,2);
    
else
    % then we start after the end of history
    y0cols=0;
    
end

% recompose the output if we have a dsge-var
%-------------------------------------------
smply=size(y,2);

if Initcond.do_dsge_var
    
    endo_nbr=obj.endogenous.number;
    
    max_rows=obj.observables.number(1);
    
    relevant=obj.inv_order_var(obj.observables.state_id);
    
    yold=y;
    
    y=zeros(endo_nbr,smply)+1i;
    
    y(relevant,:)=yold(1:max_rows,:);
    
end

% exponentiate before doing anything: is_log_var is in the order_var order
%-------------------------------------------------------------------------
if isfield(Initcond,'is_log_var') && ~isempty(Initcond.is_log_var)
    
    y(Initcond.is_log_var,:,:)=exp(y(Initcond.is_log_var,:,:));
    
end

% put y in the correct order before storing
%------------------------------------------
y=re_order_output_rows(obj,y);

y=do_hp_filter(y,obj.options.simul_hpfilter_lambda);

start_date=date2serial(Initcond.simul_history_end_date)-y0cols+1;

nrs=size(states,1);

states=reshape(states,[nrs,1,npy]);

smpl_states=size(states,1);

[states_,markov_chains]=regimes2states(states);

[exo_nbr,smplx,npx]=size(myshocks);

myshocks=cat(2,zeros(exo_nbr,y0cols,npx),myshocks);

smplx=smplx+y0cols;

vnames=[obj.endogenous.name,obj.exogenous.name,'regime',markov_chains];

endo_nbr=obj.endogenous.number;

smpl=max(smplx,smply);

yy=nan(smpl,endo_nbr+exo_nbr+1+numel(markov_chains),max(npx,npy));

yy(1:smply,1:endo_nbr,1:npy)=permute(y(1:endo_nbr,:,:),[2,1,3]);

yy(1:smplx,endo_nbr+(1:exo_nbr),1:npx)=permute(myshocks,[2,1,3]);

yy(y0cols+1:smply,endo_nbr+exo_nbr+1:end,1:npy)=cat(2,states,states_);

if obj.options.simul_to_time_series
    % store the simulations in a database: use the date for last observation in
    % history and not first date of forecast
    %--------------------------------------------------------------------------
    % store only the relevant rows in case we are dealing with a VAR with many
    % lags
    db=ts(start_date,yy,vnames);
    
    db=pages2struct(db);
    
else
    
    db={yy,...
        {
        '1=time, start_date=',start_date
        '2= endogenous names',vnames
        }
        };
end

    function [states,markov_chains]=regimes2states(regimes_history)
        
        regimes_tables=obj.markov_chains.regimes;
        
        markov_chains=regimes_tables(1,2:end);
        
        nchains=numel(markov_chains);
        
        reg_table=cell2mat(regimes_tables(2:end,2:end));
        
        states=nan(smpl_states,nchains,npy);
        
        for ip=1:npy
            % there is only one column and so the following should also
            % work max_reg=max(regimes_history(:,ip));
            max_reg=max(regimes_history(:,1,ip));
            
            for ireg=1:max_reg
                
                pos=regimes_history(:,ip)==ireg;
                
                n=sum(pos);
                
                states(pos,:,ip)=reg_table(ireg*ones(n,1),:);
                
            end
            
        end
        
    end

end

function y=do_hp_filter(y,lambda)

if isempty(lambda)
    
    return
    
end

y=permute(y,[2,1,3]);

for ii=1:size(y,3)
    
    y(:,:,ii)=utils.filtering.hpfilter(y(:,:,ii),lambda);
    
end

y=permute(y,[2,1,3]);

end

function sim_data=format_simulated_data_output(sim_data)

nobj=numel(sim_data);

if nobj==1
    
    sim_data=sim_data{1};
    
else
    
    if isempty(sim_data{1})||iscell(sim_data{1})
        
        return
        
    end
    
    sim_data=utils.time_series.concatenate_series_from_different_models(sim_data);
    
end

end

function d=the_defaults()

num_fin=@(x)isnumeric(x) && isscalar(x) && isfinite(x);

num_fin_int=@(x)num_fin(x) && floor(x)==ceil(x) && x>=0;

d={
    'simul_periods',100,@(x)num_fin_int(x),...
    'simul_periods must be a finite and positive integer'
    
    'simul_burn',100,@(x)num_fin_int(x),...
    'simul_burn must be a finite and positive integer'
    
    'simul_historical_data',ts.empty(0),@(x)isa(x,'ts')||isstruct(x),...
    'simul_historical_data must be a time series or a structure'
    
    'simul_history_end_date','',@(x)is_date(x)||is_serial(x),...
    'simul_history_end_date must be a valid date'
    
    'simul_regime',[],@(x)num_fin_int(x) && x>=1,...
    'simul_regime must be a finite and positive integer'
    
    'simul_bgp_deviation',false,@(x)islogical(x),...
    'simul_bgp_deviation must be a logical'
    
    'simul_anticipate_zero',false,@(x)islogical(x),...
    'simul_anticipate_zero must be a logical'

    'simul_honor_constraints_through_switch',false,@(x)islogical(x),...
    'simul_honor_constraints_through_switch must be a logical'
    
    'simul_shock_uncertainty',true,@(x)islogical(x),...
    'simul_shock_uncertainty must be a logical'
    
    'simul_to_time_series',true,@(x)islogical(x),...
    'simul_to_time_series must be a logical'
    
    'simul_frwrd_back_shoot',false,@(x)islogical(x),...
    'simul_frwrd_back_shoot must be a logical'
    
    'simul_honor_constraints',false,@(x)islogical(x),...
    'simul_honor_constraints must be a logical'
    
    'simul_do_update_shocks',false,@(x)islogical(x),...
    'simul_do_update_shocks must be a logical'
    
    'simul_update_shocks_handle',[],@(x)isa(x,'function_handle'),...
    'simul_update_shocks_handle must be a function handle'

    'simul_hpfilter_lambda',[],@(x)num_fin(x) && x>0,...
    ' simul_hpfilter_lambda must be >0'
    };

%     %         'simul_start_date','',... does not seem to be in use
end