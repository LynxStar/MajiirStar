require 'stdlib/log/logger'
require 'stdlib/entity/entity'

LOGGER = Logger.new('example-mod-name')

script.on_event(defines.events.on_tick, function(event)
    if event.tick % 600 == 0 then
        LOGGER.log("An example log message!")
		--LOGGER.log(serpent.block(game.entity_prototypes["roboport"]))
		LOGGER.log(game.entity_prototypes["roboport"].type)
    end
end)

script.on_event(defines.events.on_built_entity, function(event)
	
	if event.created_entity.name == "roboport" then	
		
		local roboport = event.created_entity
		local surface = roboport.surface
		local X = roboport.position.x  - 1
		local Y = roboport.position.y + 1
		local lid =	surface.create_entity{name = "storage-tank-test", position = {X,Y}, force=game.forces.neutral}
		Entity.set_data(roboport, lid)
	end
	
end)