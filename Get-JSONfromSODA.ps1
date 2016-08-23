# App token comes from https://dev.socrata.com/register and helps to avoid throttling
$apptoken = "YOURAPPTOKENHERE"

# Get the URL by going to the dataset, clicking Export, expanding SODA API, and copying the "API Endpoint" URL
$url = "YOURDATASETURLHERE"

# Set header to accept JSON
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Accept","application/json")

# Only needed for private datasets
# The email address and password for a valid Socrata account
$username = "myemail@myagency.gov"
$password = "mypassword"
# Create auth information for HTTP Basic Auth
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username,$password)))
$headers.Add("X-App-Token",$apptoken)
#Uncomment below to add Auth header info for private datasets
#$headers.Add("Authorization",("Basic {0}" -f $base64AuthInfo))

$results = Invoke-RestMethod -Uri $url -Method get -Headers $headers

# Show results in a table
$results | ft
