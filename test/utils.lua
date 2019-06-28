debug_str={}
function debug(str)
 add(debug_str,str)
end

function solid(x,y)
 return fget(mget(x/8,y/8),1)
end

function distance(a,b)
	local dx = b.x-a.x
	local dy = b.y-a.y
	return sqrt(dx*dx+dy*dy)
end

function in_range(value, _min, _max)
 return value >= min(_min,_max)
  and value <= max(_min,_max)
end

function range_intersect(min0,max0,min1,max1)
 return max(min0,max0) >= min(min1,max1)
  and min(min1,max1) >= max(min1,max1)
end

function circle_collision(c0,c1)
 return distance(c0,c1) < c0.radius + c1.radius
end

function circle_point_collision(point, circle)
 return distance(point, circle) < circle.radius
end

function point_rect(p,r)
 return in_range(p.x, r.x, r.x + r.width)
  and in_range(p.y, r.y, r.y + r.height)
end

function circle_rect(c,r)
 local dx = c.x - max(r.x, min(c.x, r.x + r.width))
 local dy = c.y - max(r.y, min(c.y, r.y + r.height))
 return (dx * dx + dy * dy) < (c.r * c.r)
end

function rect_intersect(r0,r1)
 return range_intersect(r0.x, r0.x+r0.width, r1.x, r1.x+r1.width)
  and range_intersect(r0.y, r0.y+r0.height,r1.y, r1.y+r1.height)
end

function touching(e,o)
  if e.position and e.collision and o.position and o.collision then
    if e.collision.type == 'circle' and o.collision.type == 'circle' then
      return circle_collision(
        {x=e.position.x,y=e.position.y,radius=e.collision.r},
        {x=o.position.x,y=o.position.y,radius=o.collision.r}
      )
    else
      print('missing hit detection')
      return false
    end
  else
    return false
  end
end

function entitiesAt(x,y)
  local found = {}

  for e in all(entities) do
    if e.position and
      flr(e.position.x / 8)==x and
      flr(e.position.y / 8)==y
    then
      add(found,e)
    end
  end

  return found
end

function enum(array)
  local obj = {}
  for k,v in pairs(array) do
    obj[v] = k
  end

  return obj
end