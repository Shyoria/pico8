function position(x,y)
 local p={}
 p.x=x
 p.y=y

 return p
end

function direction(x,y)
  local d = {}
  d.x = x
  d.y = y
  return d
end

function movement()
 local m={}
 m.x=0
 m.y=0

 return m
end

function control(left,right,up,down,a,b)
 local c={}
 c.left=left
 c.right=right
 c.up=up
 c.down=down
 c.a=a
 c.b=b

 return c
end

function intention()
 local i={}
 i.left=false
 i.right=false
 i.up=false
 i.down=false
 i.action=false
 i.cancel=false

 return i
end

function sprite(id,xoffset,yoffset)
 local s={}
 s.id=id
 s.xoffset=xoffset
 s.yoffset=yoffset

 return s
end

function collision(type,data)
 local c={}
 c.type=type

 for i,d in pairs(data) do
  c[i] = d
 end

 return c
end

function trigger(type, action)
 local t={}

 --type = 'once', 'always', 'wait'
 t.type = type
 t.action = action

 return t
end

function door(open)
  local d = {}
  d.open = open

  return d
end

function render_direction()
  return {}
end

function hoe()
  return {}
end

function inventory()
  local i = {}
  i.items = []
  return i
end

function equipment()
  local e = {}
  e.tool = nil
  return e
end