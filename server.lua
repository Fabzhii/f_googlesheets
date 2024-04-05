
-- reading data

local returnValue
exports('read', function(sheetID, APIkey, page, slot1, slot2)

    returnValue = nil

    if slot2 == nil then 
        slot2 = slot1
    end 

    local location = ("%s!%s:%s"):format(page, slot1, slot2)
    local url = string.format("https://sheets.googleapis.com/v4/spreadsheets/%s/values/%s?key=%s", sheetID, location, APIkey)

    PerformHttpRequest(url, function(statusCode, body, headers)
        if statusCode == 200 then 
            response(json.decode(body))
        else 
            print('AN ERROR OCCURRED: ' .. statusCode)
        end 
    end, 'GET', '', {['Content-Type'] = 'application/json'})

    while returnValue == nil do 
        Citizen.Wait(0)
    end

    return(returnValue.values)
end)

function response(body)
    returnValue = body
end

-- writing data

exports('write', function(sheetID, accessToken, page, slot1, slot2, values)
    if slot2 == nil then 
        slot2 = slot1
    end 

    exports['f_googlesheets']:delete(sheetID, accessToken, page, slot1, slot2)
    Citizen.Wait(10)

    local requestData = {["values"] = values}
    local location = ("%s!%s:%s"):format(page, slot1, slot2)
    local url = ("https://sheets.googleapis.com/v4/spreadsheets/%s/values/%s:append?valueInputOption=RAW"):format(sheetID, location)

    PerformHttpRequest(url, function(statusCode, body, headers)
        if statusCode == 200 then
            print('UPDATE SUCCESSFULLS')
        else
            print('AN ERROR OCCURRED: ' .. statusCode)
        end
    end, 'POST', json.encode(requestData), {
        Authorization = "Bearer " .. accessToken,
        ['Content-Type'] = 'application/json'
    })
end)

-- deleting data

exports('delete', function(sheetID, accessToken, page, slot1, slot2)
    if slot2 == nil then 
        slot2 = slot1
    end 

    local location = ("%s!%s:%s"):format(page, slot1, slot2)
    local url = ("https://sheets.googleapis.com/v4/spreadsheets/%s/values/%s:clear"):format(sheetID, location)

    PerformHttpRequest(url, function(statusCode, body, headers)
        if statusCode == 200 then
            print('DELETE SUCCESSFUL')
        else
            print('AN ERROR OCCURRED: ' .. statusCode)
        end
    end, 'POST', '', {
        Authorization = "Bearer " .. accessToken,
        ['Content-Type'] = 'application/json'
    }) 

end)

-- generating token

RegisterCommand('getToken', function(source, args, rawCommand)

    local clientID = args[1]
    local clientSecret = args[2]
    local redirectURI = args[3]
    local authCode = args[4]
    
    local postData = "code=" .. authCode
    postData = postData .. "&client_id=" .. clientID
    postData = postData .. "&client_secret=" .. clientSecret
    postData = postData .. "&redirect_uri=" .. redirectURI
    postData = postData .. "&grant_type=authorization_code"
    
    PerformHttpRequest("https://oauth2.googleapis.com/token", function(statusCode, body, headers)
        if statusCode == 200 then
            print(json.decode(body).access_token)
        else
            print("Fehler beim Abrufen des OAuth-Tokens:", statusCode, body)
        end
    end, 'POST', postData, { ['Content-Type'] = 'application/x-www-form-urlencoded' })

end)
