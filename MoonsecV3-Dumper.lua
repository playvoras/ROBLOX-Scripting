local vgtw = unpack
local rmglf = appendfile 

local snfie = "yes.txt"

local afstn = "\n"..[[ 
-- Hi
]]

local function odxvsz(zsmhl, iflhk)
    if not isfile(zsmhl) then 
        writefile(zsmhl, string.format("%s\n %s", afstn, iflhk))
    end 

    return rmglf(zsmhl, iflhk)
end 

local function umzqlf(stlkh)
    for _, uzrfk in pairs(stlkh) do
        if type(uzrfk) ~= "number" then
            return false
        end
    end
    return true
end

local function mdfhqx(vbjwr, fyaog)
    fyaog = fyaog or ""
    local mgcvj = "{\n"
    local khdtv = fyaog .. "  "
    
    for kbxeu, jmwef in pairs(vbjwr) do
        if type(jmwef) == "table" then
            if next(jmwef) ~= nil and not umzqlf(jmwef) then
                mgcvj = mgcvj .. khdtv .. string.format("'%s': %s,\n", tostring(kbxeu), mdfhqx(jmwef, khdtv))
            end
        else
            mgcvj = mgcvj .. khdtv .. string.format("'%s': '%s',\n", tostring(kbxeu), tostring(jmwef))
        end
    end

    mgcvj = mgcvj .. fyaog .. "},"
    return mgcvj
end

local function zxvhle(zkpwe)
    if type(zkpwe) == "table" then 
        for ohdfx, tyqmk in pairs(zkpwe) do 
            if type(tyqmk) == "table" then
                if next(tyqmk) ~= nil and not umzqlf(tyqmk) then
                    odxvsz(snfie, mdfhqx(tyqmk) .. "\n")
                end
            else
                odxvsz(snfie, string.format("'%s': '%s',\n", tostring(ohdfx), tostring(tyqmk)))
            end
        end
    end 
end 

function unpack(...)
    if type(vgtw(...)) == "table" then 
        zxvhle(vgtw(...))
    end 
    return vgtw(...)
end 

loadstring(game:HttpGet("https://raw.githubusercontent.com/cool5013/TBO/refs/heads/main/paid"))()
