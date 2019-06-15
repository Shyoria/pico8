function inputsystem()
  for e in all(entities) do
    if e.intention and e.control
    then
      e.intention.left = btn(0)
      e.intention.right = btn(1)
      e.intention.up = btn(2)
      e.intention.down = btn(3)
      e.intention.action = btn(4)
      e.intention.cancel = btn(5)
    end
  end
end

function movementsystem()
  for e in all(entities) do
    if e.movement and e.intention and e.direction
    then
      if e.intention.left then
        e.movement.x = -1
        e.direction.x = -1
      elseif e.intention.right then
        e.movement.x = 1
        e.direction.x = 1
      elseif e.intention.up or e.intention.down then
        e.direction.x = 0
      end

      if e.intention.up then
        e.movement.y = -1
        e.direction.y = -1
      elseif e.intention.down then
        e.movement.y = 1
        e.direction.y = 1
      elseif e.intention.left or e.intention.right then
        e.direction.y = 0
      end
    end
  end
end

function rendersystem()
  for e in all(entities) do
    if e.position and e.sprite
    then
      spr(
        e.sprite.id,
        e.position.x+e.sprite.xoffset,
        e.position.y+e.sprite.yoffset
      )
    end

    if e.position and e.direction and e.render_direction then
      local x = flr((e.position.x + e.direction.x * 8) / 8) * 8
      local y = flr((e.position.y + e.direction.y * 8) / 8) * 8

      line(x,y,x+8,y, 10)
      line(x,y,x,y+8, 10)
      line(x,y+8,x+8,y+8, 10)
      line(x+8,y,x+8,y+8, 10)
    end
  end
end

function collisionsystem()
  for e in all(entities) do
    if e.position and e.movement
      and (e.movement.x ~= 0 or e.movement.y ~= 0)
      and e.collision and e.collision.type == "circle"
    then
      local newx = e.position.x + e.movement.x
      local newy = e.position.y + e.movement.y
      local canmovex = true
      local canmovey = true

      e.movement.x = 0
      e.movement.y = 0

      -- entity x entity


      -- entity x map
      -- get 9 closest solid tiles
      for xx=-1,1 do
        for yy=-1,1 do
          local tx = flr(newx/8)+xx
          local ty = flr(e.position.y/8)+yy
          local tilex = fget(mget(tx,ty),0)

          if tilex then
            if circle_rect(
              {
                x=newx,
                y=e.position.y,
                r=e.collision.r
              },
              {x=tx*8,y=ty*8,width=8,height=8}
            ) then
              canmovex=false
            end
          end

          tx = flr(e.position.x/8)+xx
          ty = flr(newy/8)+yy
          local tiley = fget(mget(tx,ty),0)
          if tiley then
            if circle_rect(
              {x=e.position.x,y=newy,r=e.collision.r},
              {x=tx*8,y=ty*8,width=8,height=8}
            ) then
              canmovey=false
            end
          end
        end
      end

      if canmovex then e.position.x = newx end
      if canmovey then e.position.y = newy end
    end
  end
end

function hoesystem()
  for e in all(entities) do
    if e.equipment and e.intention and e.position and e.direction
      and e.equipment.tool
      and entities[e.equipment.tool]
      and entities[e.equipment.tool].hoe
      and e.intention.action
    then
      local x = flr((e.position.x + e.direction.x * 8) / 8)
      local y = flr((e.position.y + e.direction.y * 8) / 8)

      local exists = entitiesAt(x,y)



      for o in all(entities) do
        if o.position then
          if flr(o.position.x / 8)==tile.x and flr(o.position.y / 8)==tile.y then
            -- something already exists here
            exists = true
          end
        end
      end

      if !exists then
        entity({
          position = position(x*8,y*8),
          sprite = sprite(23),
        })
      end
    end
  end
end

function triggersystem()
  for e in all(entities) do
    if e.trigger and e.position then
      local triggered = false
      for o in all(entities) do
        if e ~= o and o.position and o.collision then
          triggered = true
          if touching(e,o) then
            e.trigger.active = true
          end
        end
      end
      if triggered == false then
        e.trigger.active = false
      end
    end
  end
end