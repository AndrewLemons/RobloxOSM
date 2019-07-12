local httpService = game:GetService("HttpService")

local opapi = {
	overpassUrl = "https://overpass-api.de/api/interpreter",
	
	query = function(code)
		local requestUrl = "https://overpass-api.de/api/interpreter?data=[out:json];"..code
		print(requestUrl)
		local request = {Url = requestUrl, Method = "GET"}
		local response = httpService:RequestAsync(request)
		return response.Body
	end,
	}

return opapi
