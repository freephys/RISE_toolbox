function act=check_property(obj,propname,propval)

action=check_property@generic_switch(obj,propname,propval);

%%% action=check_property@generic(obj,propname,propval);

if nargout
    
    act=action;
    
end

if any(action=='r')
    
    obj.warrant_resolving=true;
    
end

if any(action=='s')
    
    obj.warrant_setup_change=true;
    
end

end
