require 'stdlib/log/logger'

LOGGER = Logger.new('MajiirStar')

require 'stdlib/entity/entity'
require 'migration'--Existing system is too limited


global.control = {}
require 'controls/roboport'


local loadOnce = false

script.on_load(function()

	LOGGER.log("LAODING")

	if loadOnce then

		LOGGER.log("LAODING MIXATRAXTIONS")
		global.migrate()

		loadOnce = true

	end

end)

script.on_init(function()
	LOGGER.log("LAODING MIXATRAXTIONS")
 	global.migrate()
 end)

script.on_event(defines.events.on_tick, function(event)
    -- if event.tick % 600 == 0 then
        -- LOGGER.log("An example log message!")
		-- LOGGER.log(game.entity_prototypes["roboport"].type)
    -- end

		global.control.roboport.update(event)

end)

script.on_event(defines.events.on_built_entity, function(event)

	if event.created_entity.name == "roboport" then

		local roboport = event.created_entity
		local surface = roboport.surface
		local X = roboport.position.x  - 1
		local Y = roboport.position.y + 1
		local lid =	surface.create_entity{name = "storage-tank-test", position = {X,Y}, force=game.forces.neutral}
		Entity.set_data(roboport, lid)
		table.insert(global.roboports, roboport)
	end

end)
