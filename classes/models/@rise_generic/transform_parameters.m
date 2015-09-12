function [obj,x0,lb,ub,vcov]=transform_parameters(obj,x0,lb,ub,vcov)
% TRANSFORM_PARAMETERS -- transforms the parameters under linear
% restrictions and or dirichlet priors
%
% Syntax
% -------
% ::
%
%   [obj,x0,lb,ub,vcov]=transform_parameters(obj,x0,lb,ub)
%
%   [obj,x0,lb,ub,vcov]=transform_parameters(obj,x0,lb,ub,vcov)
%
% Inputs
% -------
%
% - **obj** [rise|dsge|rfvar|svar]: model object
%
% - **x0** [empty|n x 1 vector]: initial conditions of estimation in a space that
% the user understands
%
% - **lb** [n x 1 vector]: lower bound of the search space
%
% - **ub** [n x 1 vector]: upper bound of the search space
%
% - **vcov** [empty|n x n matrix]: variance covariance of the parameters
%
% Outputs
% --------
%
% - **obj** [rise|dsge|rfvar|svar]: model object with all restrictions set
% up
%
% - **x0** [empty|m x 1 vector]: transform initial conditions with m<=n
%
% - **lb** [m x 1 vector]: transformed lower bound of the search space with
% m<=n
%
% - **ub** [m x 1 vector]: transformed upper bound of the search space with
% m<=n 
%
% - **vcov** [empty|m x m matrix]: transformed variance covariance of the
% parameters with m<=n 
%
% More About
% ------------
%
% - Some checks have to be made after transformation in order to insure
% that no element in the transformed lower bound exceeds its upper bound
% counterpart. 
%
% Examples
% ---------
%
% See also: UNTRANSFORM_PARAMETERS

if isempty(obj)
    if nargout>1
        error([mfilename,':: when the object is emtpy, nargout must be at most 1'])
    end
    x0=struct();
    return
end
if nargin<5
    vcov=[];
end
% set up restrictions
%---------------------
obj=setup_linear_restrictions(obj);
obj=setup_general_restrictions(obj);

linear_restricts=obj.linear_restrictions_data;

% Initial conditions
%--------------------
do_initial_conditions()

% bounds
%--------
do_bounds()

% covariance matrix
%-------------------
do_covariance()

    function do_covariance()
        if ~isempty(vcov)
            if size(vcov,1)~=size(vcov,2)
                error('expected a covariance matrix... sizes do not match')
            end
            % the covariance matrix has a special call to the function
            vcov=linear_restricts.a2tilde_func(vcov,true);
        end
    end

    function do_bounds()
        lb=linear_restricts.a2tilde_func(lb);
        ub=linear_restricts.a2tilde_func(ub);
        bad=ub<lb;
        if any(bad)
            tmp=lb;
            lb(bad)=ub(bad);
            ub(bad)=tmp(bad);
        end
    end

    function do_initial_conditions()
        % zero restrictions on dirichlet should work as well as nonlinear
        % restrictions. Other linear restrictions may not work. For
        % instance xdirich+xj=b ==>ad/sum(ad)+xj=b. In this case the
        % restriction that will be enforced (because of the prior dirichlet
        % transformation is ad+xj=b; But then having estimated ad, the
        % recomputed xdirich will not satisfy the restriction. For things
        % to work, the restrictions should be transformed into
        % ad+sum(ad)*xj=sum(ad)*b. The problem is that at the moment
        % sum(ad) is not known in advance... perhaps it should. If that
        % were the case, then the rule is to multiply every atom in the
        % equation by sum(ad), except for the current element being
        % transformed.
        if ~isempty(x0)
            % transform the dirichlet
            %------------------------
            for id=1:numel(obj.estim_dirichlet)
                di=obj.estim_dirichlet(id);
                pos=di.location;
                x0(pos)=utils.distrib.dirichlet_transform(x0(pos),...
                    di.ax_diag);
            end
            % Apply possible linear restrictions
            %-----------------------------------
            x0=linear_restricts.a2tilde_func(x0);
        end
    end
end