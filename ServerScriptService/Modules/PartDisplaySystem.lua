local partDisplay = {
	makeLine = function(parent, pointA, pointB, height, width)
		local part = Instance.new("Part", parent)
		part.Anchored = true
		
		local cyl = Instance.new("Part", parent)
		cyl.Shape = Enum.PartType.Cylinder
		cyl.Anchored = true
		
		local x = (pointA.X + pointB.X)/2
		local z = (pointA.Z + pointB.Z)/2
		local position = Vector3.new(x, height/2, z)
		
		local distance = math.sqrt(math.pow(pointB.X-pointA.X, 2) + math.pow(pointB.Z-pointA.Z, 2))
		
		local slope = (pointB.Z-pointA.Z)/(pointB.X-pointA.X)
		local angle = -math.atan(slope)
		
		part.Size = Vector3.new(distance, height, width)
		part.CFrame = CFrame.Angles(0, angle, 0) + position
		
		cyl.Size = Vector3.new(height, width, width)
		cyl.CFrame = CFrame.Angles(0, 0, math.rad(90)) + Vector3.new(pointB.X, height/2, pointB.Z)

		local union
		local status = pcall(function()
			union = part:UnionAsync({cyl})
			union.Parent = game.Workspace
			union.UsePartColor = true
		end)
		
		cyl:Destroy()
		
		if status then
			part:Destroy()
			return union
		else
			return part
		end
	end
	}

return partDisplay
