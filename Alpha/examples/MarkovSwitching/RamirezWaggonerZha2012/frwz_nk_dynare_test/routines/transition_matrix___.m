%% Code automagically generated by rise on 14-Aug-2013 12:04:43

function [Q,retcode]=transition_matrix___(y,x,ss,param,def,s0,s1)

retcode=0;
Q=zeros(1,1);
Q(1,1)=1;
if any(isnan(Q(:))) || any(Q(:)<0) || any(Q(:)>1);
Q=[];
retcode=3;
end;
