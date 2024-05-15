local objects = {}

objects.replace = {
	-- id, dff/col, txd
	{12976, "sw_diner1"}, -- bar 
	{14655, "trukstp01"}, -- colisão do bar
}

function mapas()
	for k, v in pairs(objects.replace) do
		local modelName = v[2]
		local modelPath = "files/" .. modelName .. ".dff"
		local collisionPath = "files/" .. modelName .. ".col"
		
		if not fileExists(modelPath) then
			outputDebugString("FCEB: " .. modelPath .. " não existe.")
		elseif not fileExists(collisionPath) then
			outputDebugString("FCEB: " .. collisionPath .. " não existe.")
		else
			local col = engineLoadCOL(collisionPath)
			local dff = engineLoadDFF(modelPath, v[1])
			
			if col and dff then
				engineReplaceCOL(col, v[1])
				engineReplaceModel(dff, v[1])
			else
				if not col then
					outputDebugString("FCEB: Falha ao carregar " .. collisionPath)
				end
				if not dff then
					outputDebugString("FCEB: Falha ao carregar " .. modelPath)
				end
			end
		end
	end
end

addEventHandler("onClientResourceStart", resourceRoot, mapas)
