--Game services
local httpService = game:GetService("HttpService")
local sss = game:GetService("ServerScriptService")

--Modules
local opapi = require(sss.Modules.OverpassAPI)
local partDisplay = require(sss.Modules.PartDisplaySystem)
local stylesheet = require(sss.Modules.Stylesheet)
local hex2rgb = require(sss.Modules.HexColorSupport)

--Render settings
local loadRange = .01 --How far to load
local lon = -73.988397 --Longitude to load
local lat = 40.754024 --Latitude to load

local mpd = 111034 --Meters/Degree - Real world number that describes ~ how many meters in a degree
local spm = 2.5 --Studs/Meter - How many studs fit in a meter (2.5 for ~ real world scaling)

local delayCount = 10 --How many nodes/ways to complete before a wait()

--Quick math...
local minLat = lat - (loadRange/2)
local minLon = lon - (loadRange/2)
local maxLat = lat + (loadRange/2)
local maxLon = lon + (loadRange/2)

--Get map's node data
local query = opapi.query("node("..minLat..","..minLon..","..maxLat..","..maxLon.."); out;")
local data = httpService:JSONDecode(query)
local mapNodes = data["elements"]

for a, node in pairs(mapNodes) do --Loop through all nodes
	if a%delayCount then wait() end --Wait every delayCount nodes

	local nodeDisplay = Instance.new("Part") --Create node display part
	nodeDisplay.Anchored = true
	nodeDisplay.Name = node.id
	nodeDisplay.Parent = game.Workspace.Nodes
	nodeDisplay.Material = Enum.Material.Glass
	nodeDisplay.Size = Vector3.new(.1, .1, .1)
	
	local localLat = node.lat-lat
	local localLon = node.lon-lon
	
	part.CFrame = CFrame.new(localLat*mpd*spm, .05, localLon*mpd*spm)
end

--Get map's ways data
local query = opapi.query("way("..minLat..","..minLon..","..maxLat..","..maxLon.."); out;")
local data = httpService:JSONDecode(query)
local mapWays = data["elements"]

for a, way in pairs(mapWays) do --Loop through all nodes
	wait()
	
	local nodes = way.nodes --Get the current way's nodes
	local tags = way.tags or {empty = "Nothing"} --Get the current way's tags, or nothing
	
	local style = stylesheet.getStyle(tags)

	for b, node in pairs(wayNodes) do
		if b%delayCount then wait() end --Wait every delayCount nodes
		
		local partA = game.Workspace.Nodes:FindFirstChild(node) --PartA is always the current node
		local partB
		
		--Find out what PartB is
		if b ~= #wayNodes+1 then --If B is still in the array
			partB = game.Workspace.Nodes:FindFirstChild(wayNodes[b+1]) --Get the next node
		else --If B is the last node
			if style.loops then --If B is not in the array
				partB = game.Workspace.Nodes:FindFirstChild(wayNodes[1]) --Get the first node
			else
				partB = game.Workspace.Nodes:FindFirstChild(wayNodes[a]) --Get PartA as PartB
			end
		end
		
		--Find out what height should be used
		local height = 0
		if tags["building:levels"] or tags["height"] then --If a tag exists that defins a height
			if tags["height"] then --Tag "height" trumps tag "building:levels"
				height = tags["height"]*spm
			elseif tags["building:levels"] then
				height = tags["building:levels"]*(spm*3)
			end
		end
		if height == 0 then --If there still is not a height, use the default style one
			height = style.height
		end
		
		--Display the line
		local line
		if partA and partB then --Make sure that partA and partB exist
			line = partDisplay.makeLine(game.Workspace, partA.Position, partB.Position, height, style.width) --Draw the line
			
			--Set the styles
			line.Material = style.material
			line.Transparency = style.transparency
			if tags["building:colour"] then --If the building:colour tag exists, use that color
				line.BrickColor = BrickColor.new(hex2rgb(string.gsub(tags["building:colour"], "#", "")))
			else --Or not...
				line.BrickColor = style.color
			end
		end
	end
end

--Remove all the nodes, they are just a waste of parts now
local oldNodes = game.Workspace.Nodes:GetChildren()
for a, node in pairs(oldNodes) do
	node:Destroy()
end

print("Done!")
