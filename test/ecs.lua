entities = {}

function entity(components)
 local e = {}
 add(entities,e)

 for cname, component in pairs(components) do
  e[cname] = component
 end

 return e
end
