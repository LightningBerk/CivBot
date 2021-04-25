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
local makeProfile = false --Tracking weather or not the user wants to save multiple config files for different farms
local askProfile = nil --Tracks weather or not we need to get profile data from the player
local profileName = "config" --Default profile name if the player does not want to make multiple profiles
local profileChoice = nil --For storing what profile the player chose to load
local ran = false --Weather or not this is the first time the player has run the script
local lines = 0 --Number of lines in our profile storage profile
local newProfile = false --Tracks weather or not the player wants to make a new profile assuming they have run the script before
local wheat = "minecraft:wheat"
local wheatSeeds = "minecraft:wheat_seeds"
local carrots = "minecraft:carrot"
local potatoes = "minecraft:potato"
local beets = "minecraft:beetroot"
local beetSeeds = "minecraft:beetroot_seeds"
local wart = "minecraft:nether_wart"
local crop = nil --For storing what crop was selected
local seeds = nil --For storing what "seeds" are used for replanting based on crop selection
--Defining functions
function getLines() --Grabs the number of lines in our profile storage file 
	lines = 0
	for _ in io.lines'profiles.txt' do
  	lines = lines + 1
end
end
function chooseProfile(file) --Gives the player the ability to choose an existing profile they have made or to make a new one
	local file = io.open(file, "r")
	if lines ==  1 then --getLines is used here to make the menu conform to the amount of profiles we have, otherwise we will get an error from trying to read a nil value
		profileChoice = prompt("Please choose a profile to load", "choice", file:read("*line"), "Create new profile")
	elseif lines == 2 then
		profileChoice = prompt("Please choose a profile to load", "choice", file:read("*line"), file:read("*line"), "Create new profile")
	elseif lines == 3 then
		profileChoice = prompt("Please choose a profile to load", "choice", file:read("*line"), file:read("*line"), file:read("*line"), "Create new profile")
	elseif lines == 4 then
		profileChoice = prompt("Please choose a profile to load", "choice", file:read("*line"), file:read("*line"), file:read("*line"), file:read("*line"), "Create new profile")
	elseif lines == 5 then
		profileChoice = prompt("Please choose a profile to load", "choice", file:read("*line"), file:read("*line"), file:read("*line"), file:read("*line"), file:read("*line"), "Create new profile")
	elseif lines == 6 then
		profileChoice = prompt("Please choose a profile to load", "choice", file:read("*line"), file:read("*line"), file:read("*line"), file:read("*line"), file:read("*line"), file:read("*line"), "Create new profile")
	end
	if profileChoice == "Create new profile" then
		newProfile = true
	end
	file:close()
end
function saveProfileNames(name) --Saves the names of the profile we made to the profiles.txt file for use later
	local file = io.open("profiles.txt", "a")
	file:write(name, "\n")
	file:close()
end
function askProfile() --Asks our player if they want to have multiple profiles saved. If not profileName defaults to config.txt
	askProfile = prompt("Would you like to save this config as a profile so that you can have different configs for different farms?", "choice", "Yes", "No")
	if askProfile == "Yes" then
		makeProfile = true
	elseif askProfile == "No" then
		makeProfile = false
	end
	if makeProfile == true then
		profileName = prompt("Please enter a name for the profile")
	end
end
function chooseCrop() --Asks the player what crop they are harvesting so that the replanting and chest depositing will work correctly
	local cropChoice = nil
	while true do
		cropChoice = prompt("What are you harvesting?", "choice", "Wheat", "Carrots", "Potatoes", "Beetroot", "Nether Wart")
		if cropChoice == "Wheat" then
			crop = wheat
			seeds = wheatSeeds
			break
		elseif cropChoice == "Carrots" then
			crop = carrots
			seeds = carrots
			break
		elseif cropChoice == "Potatoes" then
			crop = potatoes
			seeds = potatoes
			break
		elseif cropChoice == "Beetroot" then
			crop = beets
			seeds = beetSeeds
			break
		elseif cropChoice == "Nether Wart" then
			crop = wart
			seeds = wart
			break
		else
			log("&4Invalid selection, please choose a letter from the list")
			sleep(500)
		end
	end	
end
function file_exists(file) --Checks to see if a file we specify exists
	local f = io.open(file, "rb")
  	if f then
  		hasConfig = true 
  		f:close() 
 	else
  		log("&4File does not exist")
  	end
end
function firstRun(file) --Checks to see if we have run the script before by checking to see if the file created on first run exists
	local f = io.open(file, "rb")
  	if f then
  		ran = true 
  		f:close() 
 	else
  		log("&4This is your first time running the script")
  	end
end
function createConfig(file) --Makes a config file assuming we dont have one
	if hasConfig == false then
		local file = io.open(file .. ".txt", "w")
		file:write(endX, "\n")
		file:write(endZ, "\n")
		file:write(chestX, "\n")
		file:write(chestZ, "\n")
		file:write(chestSizeRaw, "\n")
		file:close()
		sleep(2000)
		log("Config file with name " .. profileName .. ".txt" .. " created")
		sleep(1000)
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
		chestSize = prompt("What size chest did you place?", "choice", "Single Chest", "Double Chest")
		if chestSize == "Single Chest" then
			chestSizeRaw = 27
			break
		elseif chestSize == "Double Chest" then
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
firstRun("DO NOT DELETE.txt")
if ran == true then
	chooseCrop()
	getLines()
	io.close("profiles.txt")
	chooseProfile("profiles.txt")
	if newProfile == true then
		giveDirections()
		getChestInfo()
		getFarmInfo()
		askProfile()
		createConfig(profileName)
		if makeProfile == true then
			saveProfileNames(profileName)
		end
		readConfig(profileName .. ".txt")
		harvestCrops()	
	elseif newProfile == false then
		file_exists(profileChoice .. ".txt")
		if hasConfig == true then --If we have a config, we grab the data and start the script
			log("&2Config loaded! Beginning Script!")
			readConfig(profileChoice .. ".txt")
			harvestCrops()
		else
			log("&4File not found")
		end
	end
elseif ran == false then --If not we go through the process of making a config and getting data from the player
	local file = io.open("DO NOT DELETE.txt", "w")
	file:write("run")
	file:close()
	giveDirections()
	getChestInfo()
	getFarmInfo()
	askProfile()
	createConfig(profileName)
	if makeProfile == true then
		saveProfileNames(profileName)
	end
	harvestCrops()
end
