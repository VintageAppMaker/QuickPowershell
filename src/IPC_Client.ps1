# 서버접속
$serverUrl = "http://localhost:8080/"

# 이곳에서 커맨드처리 
$command = "Get-Process | Select-Object -First 5"

# Send command to server and get result
$response = Invoke-RestMethod -Uri $serverUrl -Method Post -Body $command

# Print result
Write-Host "결과:"
$response
