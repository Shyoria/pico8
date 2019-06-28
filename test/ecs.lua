entities = {}
last_id = 0

function entity(components)
  last_id += 1
  local e = {
    id = last_id
  }
  add(entities,e)

  for cname, component in pairs(components) do
    e[cname] = component
  end

  return e
end
