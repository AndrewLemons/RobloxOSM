local defaultStyle = {
	width = 1,
	height = 1,
	material = Enum.Material.SmoothPlastic,
	color = BrickColor.new("Lily white"),
	transparency = 0,
	loops = false
	}

local keys = {
	amenity = {
		parking = {
			width = .1,
			height = .1,
			material = Enum.Material.Glass,
			color = BrickColor.new("Lily white"),
			loops = true
		}
	},
	building = {
		yes = {
			width = 1,
			height = 7.5,
			material = Enum.Material.Brick,
			color = BrickColor.new("Maroon"),
			loops = true
		},
		house = {
			width = 1,
			height = 7.5,
			material = Enum.Material.Brick,
			color = BrickColor.new("Maroon"),
			loops = true
		},
		residential = {
			width = 1,
			height = 7.5,
			material = Enum.Material.Brick,
			color = BrickColor.new("Maroon"),
			loops = true
		}
	},
	leisure = {
		swimming_pool = {
			width = 2,
			height = .1,
			material = Enum.Material.Ice,
			color = BrickColor.new("Cyan"),
			loops = true
		}
	},
	highway = {
		cycleway = {
			width = 8,
			height = .5,
			material = Enum.Material.Concrete,
			color = BrickColor.new("Medium stone grey"),
			loops = false
		},
		path = {
			width = 5,
			height = .6,
			material = Enum.Material.Pebble,
			color = BrickColor.new("Medium stone grey"),
			loops = false
		},
		steps = {
			width = 5,
			height = .75,
			material = Enum.Material.WoodPlanks,
			color = BrickColor.new("CGA brown"),
			loops = false
		},
		bridleway = {
			width = 5,
			height = .1,
			material = Enum.Material.Slate,
			color = BrickColor.new("CGA brown"),
			loops = false
		},
		footway = {
			width = 5,
			height = .6,
			material = Enum.Material.Pebble,
			color = BrickColor.new("Medium stone grey"),
			loops = false
		},
		road = {
			width = 10,
			height = .5,
			material = Enum.Material.Concrete,
			color = BrickColor.new("Dark stone grey"),
			loops = false
		},
		raceway = {
			width = 18,
			height = .5,
			material = Enum.Material.Concrete,
			color = BrickColor.new("Dark stone grey"),
			loops = false
		},
		escape = {
			width = 12,
			height = .5,
			material = Enum.Material.Sand,
			color = BrickColor.new("Pastel yellow"),
			loops = false
		},
		bus_guideway = {
			width = 9,
			height = 2,
			material = Enum.Material.Metal,
			color = BrickColor.new("Dark stone grey"),
			loops = false
		},
		track = {
			width = 8,
			height = .1,
			material = Enum.Material.Slate,
			color = BrickColor.new("CGA brown"),
			loops = false
		},
		pedestrian = {
			width = 10,
			height = .5,
			material = Enum.Material.Cobblestone,
			color = BrickColor.new("Dark stone grey"),
			loops = false
		},
		living_street = {
			width = 8,
			height = .5,
			material = Enum.Material.Concrete,
			color = BrickColor.new("Dark stone grey"),
			loops = false
		},
		service = {
			width = 10,
			height = .5,
			material = Enum.Material.Concrete,
			color = BrickColor.new("Dark stone grey"),
			loops = false
		},
		residential = {
			width = 16,
			height = .5,
			material = Enum.Material.Concrete,
			color = BrickColor.new("Dark stone grey"),
			loops = false
		},
		unclassified = {
			width = 18,
			height = .5,
			material = Enum.Material.Concrete,
			color = BrickColor.new("Dark stone grey"),
			loops = false
		},
		tertiary_link = {
			width = 14,
			height = .5,
			material = Enum.Material.Concrete,
			color = BrickColor.new("Dark stone grey"),
			loops = false
		},
		tertiary = {
			width = 24,
			height = .5,
			material = Enum.Material.Concrete,
			color = BrickColor.new("Dark stone grey"),
			loops = false
		},
		secondary_link = {
			width = 22,
			height = .5,
			material = Enum.Material.Concrete,
			color = BrickColor.new("Dark stone grey"),
			loops = false
		},
		secondary = {
			width = 32,
			height = .5,
			material = Enum.Material.Concrete,
			color = BrickColor.new("Dark stone grey"),
			loops = false
		},
		primary_link = {
			width = 28,
			height = .5,
			material = Enum.Material.Concrete,
			color = BrickColor.new("Dark stone grey"),
			loops = false
		},
		primary = {
			width = 38,
			height = .5,
			material = Enum.Material.Concrete,
			color = BrickColor.new("Dark stone grey"),
			loops = false
		},
		trunk_link = {
			width = 30,
			height = 1,
			material = Enum.Material.Concrete,
			color = BrickColor.new("Dark stone grey"),
			loops = false
		},
		trunk = {
			width = 40,
			height = 1,
			material = Enum.Material.Concrete,
			color = BrickColor.new("Dark stone grey"),
			loops = false
		},
		motorway_link = {
			width = 36,
			height = 1,
			material = Enum.Material.Concrete,
			color = BrickColor.new("Dark stone grey"),
			loops = false
		},
		motorway = {
			width = 46,
			height = 1,
			material = Enum.Material.Concrete,
			color = BrickColor.new("Dark stone grey"),
			loops = false
		},
	},
	barrier = {
		fence = {
			width = .1,
			height = 8,
			material = Enum.Material.DiamondPlate,
			color = BrickColor.new("Medium stone grey"),
			transparency = .5,
			loops = false
		}
	}
}

function copyTable(original)
    local copy = {}
    for k, v in pairs(original) do
        -- as before, but if we find a table, make sure we copy that too
        if type(v) == table then
            v = copyTable(v)
        end
        copy[k] = v
    end
    return copy
end

local funcs = {
	getStyle = function(tags)
		local style = copyTable(defaultStyle)
		print(style, defaultStyle)
		for a, key in pairs(keys) do
			if tags[a] then
				for b, value in pairs(key) do
					if tags[a] == b then
						for c, styleSetting in pairs(value) do
							style[c] = styleSetting
						end
					end
				end
			end
		end
		return style
	end
	}

return funcs
