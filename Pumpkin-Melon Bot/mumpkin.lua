--Grabs the players x, y, and, z into their own variables
local x, y, z = getPlayerBlockPos()
log("Made by LightningBerk")
log("Running script")
sleep(500)
log("X: ", x, " ", "Z: ", z, " ", "Y: ", y)
--Moves the camera to -90 yaw, 15.4 pitch
for i = 5, 1, -1 do
	look(90, 37.5)
	while(x > -2105)
	do
		--Moves forwars while holding left click
		forward(-1)
		attack(2)
		--Updates player pos
		x, y, z = getPlayerBlockPos()
		if(x == -2105) --checks to see if we have reached our target x value
		then
			forward(0) --Cancels out forward movement
			attack(0)
		end
	end
	local startX, startY, startZ = getPlayerBlockPos() --Grabs out current pos into a seperate varible for usage later
	look(-90, 37.5) --Turns the camera around 180 degrees while maintaing the same pitch
	back(500)
	while(startZ > startZ - 1) --This whole loop gets us to move 1 block to the left
	do
		x, y, z = getPlayerBlockPos()
		if(z == startZ - 1)
		then
		    left(0)
		    break --will stop looping when you have reached the destination
		end
		left(-1)
		sleep(1)
	end
	sleep(500)
	while(x < -2037)
	do
		--Moves forward while holding left click
		forward(-1)
		attack(2)
		--Updates player pos
		x, y, z = getPlayerBlockPos()
		if(x == -2037) --checks to see if we have reached our target x value
		then
			forward(0) --Cancels out forward movement
			attack(0)
		end
	end
	local startX, startY, startZ = getPlayerBlockPos()
	look(90, 37.5)
	back(500)
	while(startZ > startZ - 3) --This whole loop gets us to move 3 blocks to the right
	do
		x, y, z = getPlayerBlockPos()
		if(z == startZ - 3)
		then
		    right(0)
		    break --will stop looping when you have reached the destination
		end
		right(-1)
		sleep(1)
	end
	while(x > -2105)
	do
		--Moves forwars while holding left click
		forward(-1)
		attack(2)
		--Updates player pos
		x, y, z = getPlayerBlockPos()
		if(x == -2105) --checks to see if we have reached our target x value
		then
			forward(0) --Cancels out forward movement
			attack(0)
		end
	end
	local startX, startY, startZ = getPlayerBlockPos() --Grabs out current pos into a seperate varible for usage later
	look(-90, 37.5) --Turns the camera around 180 degrees while maintaing the same pitch
	back(500)
	while(startZ > startZ - 1) --This whole loop gets us to move 1 block to the left
	do
		x, y, z = getPlayerBlockPos()
		if(z == startZ - 1)
		then
		    left(0)
		    break --will stop looping when you have reached the destination
		end
		left(-1)
		sleep(1)
	end
	sleep(500)
	while(x < -2037)
	do
		--Moves forward while holding left click
		forward(-1)
		attack(2)
		--Updates player pos
		x, y, z = getPlayerBlockPos()
		if(x == -2037) --checks to see if we have reached our target x value
		then
			forward(0) --Cancels out forward movement
			attack(0)
		end
	end
	local startX, startY, startZ = getPlayerBlockPos()
	look(90, 37.5)
	back(500)
	while(startZ > startZ - 4) --This whole loop gets us to move 4 blocks to the right
	do
		x, y, z = getPlayerBlockPos()
		if(z == startZ - 4)
		then
		    right(0)
		    break --will stop looping when you have reached the destination
		end
		right(-1)
		sleep(1)
	end
end
log("Done")
