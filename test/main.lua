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
  render_debug()
end