function Dump(o)
    -- Convert lua values to human readable string
    if type(o) == "table" then
        local s = "{ "
        for k, v in pairs(o) do
            if type(k) ~= "number" then
                k = '"' .. k .. '"'
            end
            s = s .. "[" .. k .. "] = " .. Dump(v) .. ","
        end
        return s .. "} "
    else
        return tostring(o)
    end
end

function CombineTables(...)
    local result = {}
    for _, t in ipairs({ ... }) do
        for k, v in pairs(t) do
            result[k] = v
        end
    end
    return result
end

function Print(value)
    print(Dump(value))
end

