global.control.roboport = {}

global.control.roboport.update = function(event)

	if event.tick % 15 == 0 then--Run 4 times per second

		if not global.roboports then
			LOGGER.log("WTF MATE")
			return
		end

		for _, roboport in pairs(global.roboports) do

			local chargingRobots = roboport.logistic_cell.charging_robot_count

			--recharge_minimum

			local deduct = 0.0625 * chargingRobots

			local lid = Entity.get_data(roboport)
			local lidData = Entity.get_data(lid)

			if lid.fluidbox[1] == nil then
				lidData.charging_enabled = false
			else

				local fluidBox = lid.fluidbox[1]

				if fluidBox.type == "water" and fluidBox.amount >= deduct then

					if not lidData.charging_enabled then
						lidData.charging_enabled = true
					else--Only consume when already on
						fluidBox.amount = fluidBox.amount - deduct
						lid.fluidbox[1] = fluidBox
					end

				else
					lidData.charging_enabled = false
				end
			end

			if lidData.charging_enabled then
				roboport.active = true
			else
				roboport.active = false
			end

			Entity.set_data(lid, lidData)

		end

	end

end
