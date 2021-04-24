--Grabbing modules
require ("centre")
require ("depositItems")
require ("walkToward")
require ("harvestLineB")
require ("plantLine")
require ("getInvSpace")
require ("getInvStacks")
require ("takeItems")
--Defining variables
local invSpace = 36
local chestSize = "s" --Size of chest for depositing harvested crops. Doublechest is 54; Single is 27
local chestX = 0 --X coordinate of chest
local chestZ = 0 --Z coordinate of chest
local x, y, z = getPlayerBlockPos() -- Getting player coordinates
local startX = x --Grabs the players starting x position (Should be the leftmost row of the farm if the player followed directions)
local breakX = 0 --For saving x position of player when leaving to deopt in a chest
local breakZ = 0 --For saving z position of player when leaving to deopt in a chest
local chestSizeRaw = 0 --Numerical value for chest size
local hasConfig = false --For tracking weather or not the user has a config file
local wheat = "minecraft:wheat"
local wheatSeeds = "minecraft:wheat_seeds"
local carrots = "minecraft:carrot"
local potatoes = "minecraft:potato"
local beets = "minecraft:beetroot"
local beetSeeds = "minecraft:beetroot_seeds"
local wart = "minecraft:nether_wart"
local crop = nil
local seeds = nil
--Defining functions
function chooseCrop()
	local cropChoice = nil
	while true do
		cropChoice = prompt("What are you harvesting? (w for wheat, c for carrots, p for potatoes, b for beets, and n for, nether wart)")
		if cropChoice == "w" then
			crop = wheat
			seeds = wheatSeeds
			break
		elseif cropChoice == "c" then
			crop = carrots
			seeds = carrots
			break
		elseif cropChoice == "p" then
			crop = potatoes
			seeds = potatoes
			break
		elseif cropChoice == "b" then
			crop = beets
			seeds = beetSeeds
			break
		elseif cropChoice == "n" then
			crop = wart
			seeds = wart
			break
		else
			log("&4Invalid selection, please choose a letter from the list")
			sleep(500)
		end
	end	
end
function file_exists(file) --Checks to see if we have a config file 
	local f = io.open(file, "rb")
  	if f then
  		hasConfig = true 
  		f:close() 
 	else
  		log("No config file found. One will be created after data has been entered")
  	end
end
function createConfig() --Makes a config file assuming we dont have one
	if hasConfig == false then
		local file = io.open("config.txt", "w")
		file:write(endX, "\n")
		file:write(endZ, "\n")
		file:write(chestX, "\n")
		file:write(chestZ, "\n")
		file:write(chestSizeRaw, "\n")
		file:close()
		sleep(2000)
		log("Config file created")
	end
end
function readConfig(file) --Reads the config file and plugs the data into their respective variables
	local file = io.open(file, "r")
	endX = file:read("*line")
	endZ = file:read("*line")
	chestX = file:read("*line")
	chestZ = file:read("*line")
	chestSizeRaw = file:read("*line")
	endX = tonumber(endX)
	endZ = tonumber(endZ)
	chestX = tonumber(chestX)
	chestZ = tonumber(chestZ)
	chestSizeRaw = tonumber(chestSizeRaw)
	file:close()
end
function chestDepot(cx, cz, cs) --Goes to pre-determined chest location and deposits crops
	walkToward(cx - 1, cz, false)
	look(-90, 50)
	sleep(500)
	depositItems(crop, cs) --Deposits all crops into the chest
end
function checkInv()
	invSpace = getInvSpace() --Gets players inventory space
	invSpace = tonumber(invSpace) --Converting string value to interger
	if invSpace <= 1 then
		x, y, z = getPlayerBlockPos()
		breakX = x --Grabs our position before going to deposit at chest
		breakZ = z
		chestDepot(chestX, chestZ, chestSizeRaw) --Deposits to chest when inventory gets full
		sleep(250)
		walkToward(breakX, breakZ, false) --Walks back to where we left off
		look(-90, 90)
	end
end 
function harvest(whatSeeds)
	x, y, z = getPlayerBlockPos()
	harvestLineB(endX, z, -90, 90, "forward", 1) --Walks forward while breaking crops
	x, y, z = getPlayerBlockPos() --Updating player position
	plantLine(90, startX, z, whatSeeds, 1) --Walks back along the row and replants
	x, y, z = getPlayerBlockPos()
	walkToward(x, z + 1, false) --Moves us one block to the right
	sleep(500)
	centre() --Centeres the player
	sleep(500)
	x, y, z = getPlayerBlockPos()
end
function waitUntil(key)
	while true do --This loop waits until the player presses the tab key before continuing 
		sleep(1)
		if isKeyDown(key) then
			break
		end
	end
end
function giveDirections()
	--Giving player directions 
	log("&2Hello! This script was made by LightningBerk with modules from TheOrangeWizard")
	sleep(1000)
	log("&2There are a few directions you need to follow for this script to work correctly, so please pay attention")
	sleep(1000)
	log("&2If you farm is big enough to fill an inventory, you will need a dump chest. Lucky for you, this script supports automatic crop depositing!")
	sleep(1000)
	log("&4Please stand at the bottom left corner of your farm facing positive x (East). Press TAB once you are there")
	waitUntil("TAB")
	log("&2Now that you are orintated correctly, the rest of this will be very simple")
	sleep(1000) 
	log("&4Please place a single or double chest in the top left corner of your farm (Not including farmland). Once you have placed the chest, hit tab")
	waitUntil("TAB")
end
function getChestInfo()
	--Getting chest size from player
	while true do 
		chestSize = prompt("What size chest did you place? (s for single, d for double)")
		if chestSize == "s" then
			chestSizeRaw = 27
			break
		elseif chestSize == "d" then
			chestSizeRaw = 54
			break
		else --Failsafe in case player types an invalid selection
			log("Invalid size, please type either s or d")
		end
	end
	chestX = prompt("Please enter the X coordinate of the chest. (For a double chest, this will be the rightmost half)") --Getting chest's X coordinate from player
	chestZ = prompt("Please enter the Z coordinate of the chest") --Getting chest's Z coordinate from player
	--Converting both values to intergers
	chestX = tonumber(chestX)
	chestZ = tonumber(chestZ)
end
function getFarmInfo()
	--Gathering information of farm from player
	endX = prompt("Please enter the X coordinate of the top left corner of the farm (Including farmland)")
	log("Target x value is " .. endX)
	endX = tonumber(endX) --Converts the players input to an interger
	endZ = prompt("Please enter the Z coordinate of the bottom right corner of your farm (Not including farmland)")
	log("Target z value is " .. endZ)
	endZ = tonumber(endZ) --Converts the players input to an interger
end
function harvestCrops()
	sleep(500)
	centre() --Centers the player on the block they are standing on 
	sleep(500)
	while z < endZ do --Repeats until the player reaches the end of the farm 
		harvest()
		checkInv()
		if z == endZ then
			chestDepot(chestX, chestZ, chestSizeRaw) --Deposits all remaining wheat
			log("&2Done!")
			break --Gets us out of the loop once we have reached the end of the farm 
		end
	end
end
--Main
chooseCrop()
file_exists("config.txt")
if hasConfig == true then --If we have a config, we grab the data and start the script
	log("&2You have a config! Beginning Script!")
	readConfig("config.txt")
	harvestCrops()
else --If not we go through the process of making a config and getting data from the player
	giveDirections()
	getChestInfo()
	getFarmInfo()
	createConfig()
	harvestCrops()
end
