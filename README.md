# f_googlesheets
Standalone FiveM API to Read, Write and Delete from Google Sheet Documents

## Setup

### SheetID
Open you google sheet document and copy the URL.
In the URL you will find your SheetID:
``https://docs.google.com/spreadsheets/d/ {YOUR SHEETID} /edit#gid=...``

### API key
In order to Read from public documents you need an API Key.
Visit https://console.cloud.google.com/apis/ to create 
a new project. Then head over to the library tab and anable the  Google Sheets API.
Under credentials you can create an API key. 

### 0-Auth Token
In order to edit documents you need an O-Auth token. 
Open the consent settings and check "extern" and click create. Then enter a name
and your google email. On the next page click add fields and tick everything with 
"Google Sheets API". Then click save and exit and add yourself as an test user.
Afterwards under credentials you can create a OAuth-Client-ID. Select Webservice and 
add a forwarding domain. You can use andy URL but I have chosen https://www.google.com.
Create the URL und open it.
```
https://accounts.google.com/o/oauth2/auth?
client_id=YOUR_CLIENT_ID
&redirect_uri=YOUR_REDIRECT_URI
&scope=https://www.googleapis.com/auth/spreadsheets
&response_type=code
```
You will get redirected but your authCode is in the url:
``https://www.google.com/?code= {authCode}``

Use the command ``getToken {clientID} {clientSecret} {redirectURI} {authCode}`` in the 
server console to get your O-Auth Token.

## Usage

| Exports         | Description                         | Parameter(s)    |
|-----------------|-------------------------------------|-----------------|
| read            |  Read from public Google sheets     | sheetID, APIkey, page, slot1, slot2      |
| write           |  Write to Google sheets             | sheetID, accessToken, page, slot1, slot2, values      |
| delete          |  Delete from Google sheets          | sheetID, accessToken, page, slot1, slot2      |

| Parameters      | Description                         | Type            |
|-----------------|-------------------------------------|-----------------|
| sheetID         |  The sheetID from the document      | string          |
| APIkey          |  Your API key                       | string          |
| accessToken     |  Your generated Token               | string          |
| page            |  The page name                      | string          |
| slot1           |  The starting slot                  | string          |
| slot2           |  The ending slot                    | string          |
| value           |  The values you want to enter       | table           |

## Examples
