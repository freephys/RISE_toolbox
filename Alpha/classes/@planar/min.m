function obj=min(a,b)

if ~isa(a,'planar')
    a=planar(a);
elseif ~isa(b,'planar')
    b=planar(b);
end

obj=planar.multinary_operation('min',a,b);

end