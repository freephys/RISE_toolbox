function obj=and(a,b)
if ~isa(a,'planar')
    a=planar(a);
elseif ~isa(b,'planar')
    b=planar(b); 
end
    obj=planar.multinary_operation('and',a,b);
end
