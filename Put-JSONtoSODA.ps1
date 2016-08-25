# Application specific settings
# App token comes from https://dev.socrata.com/register
$apptoken = "<redacted>"
# Used for the Host header value in the post request -- for our purposes it's data.oregon.gov
$socratahost = "data.oregon.gov"
# Get the URI by going to the dataset, clicking Export, expanding SODA API, and copying the "API Endpoint" URL
# Note:  the .json extension is not required because we are defining the -ContentType on Invoke-RestMethod
$url = "<redacted>"
# The email address and password for a valid Open Data account
$username = "<redacted>"
$password = "<redacted>"

# Populate $json with a payload appropriate for the dataset being updated
# See https://dev.socrata.com/publishers/getting-started.html for more info
# The PowerShell ConvertTo-JSON cmdlet can be used to convert data to JSON
$json = "[{ }]"

# Create auth information for HTTP Basic Auth
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username,$password)))

# Build headers
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Host",$socratahost)
$headers.Add("Accept","*/*")
$headers.Add("Authorization",("Basic {0}" -f $base64AuthInfo))
$headers.Add("Content-Length",$json.Length)
$headers.Add("X-App-Token",$apptoken)

# Put is a full replace of the dataset. https://dev.socrata.com/publishers/replace.html
# Post is an upsert https://dev.socrata.com/publishers/upsert.html
$method = "put"

$results = Invoke-RestMethod -Uri $url -Method $method -Headers $headers -Body $json -ContentType "application/json"

# Results should contain how many inserts, updates, or deletes occurred
write-host $results
