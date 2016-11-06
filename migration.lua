if not global then
	global = {}
end

local migrations = {}
local currentVersion = "0.1.0"

function tablelength(T)
  local count = 0
  for x,y in pairs(T) do
		game.players[1].print("x:" .. x)
		count = count + 1
	end
  return count
end

migrations["0.1.0"] = function()

	global.roboports = {}

	local s = game.surfaces[1]
	for chunk in s.get_chunks() do

		entities = s.find_entities_filtered{area={{chunk.x*32, chunk.y*32}, {chunk.x*32+32, chunk.y*32+32}}, name="roboport"}

		game.players[1].print("CHUNK");

		for _, roboport in pairs(entities) do

			game.players[1].print("Roboport");d
			game.players[1].print("Buffersize" .. roboport.electric_buffer_size);

			local surface = roboport.surface
			local X = roboport.position.x  - 1
			local Y = roboport.position.y + 1
			local lid =	surface.create_entity{name = "storage-tank", position = {X,Y}, force=game.forces.neutral}

			Entity.set_data(roboport, lid)
			Entity.set_data(lid, { charging_enabled = true })

			table.insert(global.roboports, roboport)

		end

	end

end

global.migrate = function()

	table.sort(migrations)

	if global.appliedVersion == nil or global.appliedVersion < currentVersion then

		if global.appliedVersion == nil then
			global.appliedVersion = "Vanilla"
		end

	  LOGGER.log("Applied version is " .. global.appliedVersion)
	  LOGGER.log("Migrating to version " .. currentVersion)

	  for k,v in pairs(migrations) do
			LOGGER.log("Applying migration" .. k)
			v()
	  end

    end

end
