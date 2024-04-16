
$processes = Get-Process | Where-Object { $_.CPU -gt 10 }

# 사용자에게 선택할 수 있는 표 표시
$selected = $processes | Out-GridView -OutputMode Single -Title "Select a User" 

# 선택된 사용자 정보 출력
if ($selected) {
    Write-Output "선택: $($selected.ProcessName)"
} else {
    Write-Output "No selected."
}

# 현재 디렉토리의 파일 목록을 Out-GridView로 보여주기
$files = Get-ChildItem
$files | Out-GridView

# 실행 중인 프로세스 중 이름이 "chrome"인 프로세스만 Out-GridView로 보여주기
$processes = Get-Process | Where-Object { $_.ProcessName -like "chrome" }
$processes | Out-GridView

# Object 정보를 Grid로 보여주기
Get-ChildItem | Get-Member | Out-GridView