%% Code automagically generated by rise on 06-Sep-2013 13:04:56

function [G1]=Parameters___(y,x,ss,param,def,s0,s1)

if nargout>0;
G1=sparse(6,14);
G1(1,11)=-y(11);
G1(2,2)=-(G1(1,11)+y(2));
G1(3,5)=-(y(9)-((param(6)*y(5))+(param(7)*y(8))));
G1(3,6)=-((1-param(5))*y(5));
G1(3,7)=-((1-param(5))*y(8));
G1(1,9)=-(param(10)*y(1));
G1(1,10)=-((param(9)*y(1))-y(10));
G1(3,12)=-x(1);
G1(1,13)=-x(2);
G1(2,14)=-x(3);
G1(2,1)=(y(4)-y(1));
G1(4,3)=-1;
G1(6,4)=-1;
G1(5,8)=-1;
end;
