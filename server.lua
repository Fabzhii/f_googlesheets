
exports('read', function(sheetID, APIkey, slot1, slot2)

    local url = string.format("https://sheets.googleapis.com/v4/spreadsheets/%s/values/Sheet1?key=%s", sheetID, APIkey)
    local returnValue

    PerformHTTPRequest(url, "GET", {}, nil, function(statusCode, body)
        if statusCode == 200 then 
            returnValue = nil
        else 
            local data = json.decode(body)
            if slot1 == nil and slot2 == nil then 
                returnValue = body
            elseif slot1 == nil or slot2 == nil then 
                -- return only one slot
            else
                -- return slot table
            end

        end 
    end)

    return(returnValue)
end)