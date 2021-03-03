
--Grabs the players x, y, and, z into their own variables
local x, y, z = getPlayerBlockPos()
log("Made by LightningBerk")
log("Running script")
sleep(500)
log("X: ", x, " ", "Z: ", z, " ", "Y: ", y)
--Moves the camera to -90 yaw, 15.4 pitch
look(-90, 15.4)
--Repeats 54 times, change 54 to the number of rows in tour farm divided by 2
for i = 54, 1, -1 do
	while(x < -662)
	do
		--Moves forward while spamming left click
		forward(-1)
		sprint(true)
		attack(nil)
		--Updates player pos
		x, y, z = getPlayerBlockPos()
		if(x == -662) --checks to see if we have reached our target x value
		then
			forward(0) --Cancels out forward movement
		end
	end
	local startX, startY, startZ = getPlayerBlockPos() --Grabs our current pos into a seperate varible for usage later
	look(90, 15.4) --Turns the camera around 180 degrees while maintaing the same pitch
	while(startZ < startZ + 1) --This whole loop gets us to move 1 block to the left
	do
	    x, y, z = getPlayerBlockPos()
	    if(z == startZ + 1)
	    then
	        left(0)
	        break --will stop looping when you have reached the destination
	    end
	    left(-1)
	    sleep(1)
	end

	back(1000) --These three commands get us to sneak walk to the back of the walkway
	sneak(1500)
	sleep(2500)
	while(x > -746) -- This is the same thing as the first loop, just in the other direction
	do
		forward(-1)
		sprint(true)
		attack(nil)
		x, y, z = getPlayerBlockPos()
		if(x == -746)
		then
			forward(0)
		end
	end
	local startX, startY, startZ = getPlayerBlockPos()
	look(-90, 15.4)
	while(startZ < startZ + 1) --This is the same turn around but the movement loop goes to the right instead of left
	do
	    x, y, z = getPlayerBlockPos()
	    if(z == startZ + 1)
	    then
	        right(0)
	        break --will stop looping when you have reached the destination
	    end
	    right(-1)
	    sleep(1)
	end
	back(1000) --Same thing for resetting position
	sneak(1500)
	sleep(2500)
end
log("Done")
