function c=chebyshev_distance(y)
% chebyshev_distance - computes chebyshev distances
%
% Syntax
% -------
% ::
%
%   c=chebyshev_distance(y)
%
% Inputs
% -------
%
% - **y** [numeric] : N x T x G array, with
%   - **N** [numeric] : number of simulations/replications
%   - **T** [numeric] : sample length (time series dimension)
%   - **G** [numeric] : number of variables
%
% Outputs
% --------
%
% - **c** [N x 1 vector] : chebyshev distances
%
% More About
% ------------
%
% Examples
% ---------
%
% See also: standardized_distance, multivariate_chebyshev_box

% References:
% Dag Kolsrud (2015): "A time-simultaneous prediction box for a
% multivariate time series", Journal of Forecasting

z=utils.forecast.kolsrud.standardized_distance(y);
% max over T
c=max(z,[],2);
% max over G
[N,~,G]=size(y);
c=reshape(c,N,G);
c=max(c,[],2);
end