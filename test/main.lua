debug=true


function _init()
  game_states = enum({"menu","game"})
  player_states = enum({""})
  actions = enum( {"talk","take","hoe","water","plant"})

  game_state = game_states.game


  player = entity({
    position = position(32,32),
    control = control(),
    sprite = sprite(1,-4,-6),
    intention = intention(),
    movement = movement(),
    collision = collision(
      "circle",
      {r=2}
    ),
    direction = direction(0,0),
    render_direction = render_direction(),
    equipment = equipment()
  })
  hoe = entity({
    hoe = hoe()
  })
  player.equipment.tool = hoe.id
 end

 function _update()
  if game_state==game_states.game then
    inputsystem()
    movementsystem()
    collisionsystem()
    hoesystem()
  end
 end

function _draw()
  cls()
  map()

  rendersystem()

  --debug
  if debug then
    for e in all(entities) do
      if e.position and e.direction then
        pset(
          e.position.x + e.direction.x*8,
          e.position.y + e.direction.y*8,
          8
        )
      end
    end
    for i,str in pairs(debug_str) do
      rectfill(1,i*6,127,(i+1)*6,0)
      print(str,2,1+i*6,11)
    end
    debug_str = {}
  end
end