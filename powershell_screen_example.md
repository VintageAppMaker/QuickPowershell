# Powershell 화면처리  
Powershell을 사용하면서 화면처리하는 소스를 다음과 같이 정리했다. 참고할 것은 `.ps1 파일은 utf-8(bom)으로 저장`되어야 한다. 그렇게 하지 않으면 한글을 처리할 수 없다. 


### 1. menu
문자를 색상별로 출력하고 입력된 값을 받아 실행할 수 있는 메뉴예제이다. 

~~~powershell
function Show-Menu {
    Clear-Host
    Write-Host "1. Option 1" -ForegroundColor Green
    Write-Host "2. Option 2" -ForegroundColor Cyan
    Write-Host "3. Option 3" -ForegroundColor Yellow
    Write-Host "4. Exit" -ForegroundColor Red
}

# 배경색 설정
$Host.UI.RawUI.BackgroundColor = "DarkOrange"

do {
    Show-Menu
    $choice = Read-Host "Please make a selection"

    switch ($choice) {
        "1" {
            Write-Host "You selected Option 1" -ForegroundColor Green
            # Do something for Option 1
            Pause
        }
        "2" {
            Write-Host "You selected Option 2" -ForegroundColor Cyan
            # Do something for Option 2
            Pause
        }
        "3" {
            Write-Host "You selected Option 3" -ForegroundColor Yellow
            # Do something for Option 3
            Pause
        }
        "4" {
            Write-Host "Exiting..." -ForegroundColor Red
        }
        default {
            Write-Host "Invalid selection! Please try again." -ForegroundColor Red
            Pause
        }
    }

    # 사용자가 Enter를 누르면 메뉴를 다시 표시
    $null = Read-Host "Press Enter to continue"
} while ($choice -ne "4")

~~~

### 2. 문자 애니메이션
프로그램이 무엇인가 수행하고 있다는 표시를 할 때 사용한다. 
~~~powershell
$animationText = "./\_-@"
$animationSpeed = 100  # 밀리초 단위

$count = 10 #10번 반복
Write-Host -NoNewline "progress...  " 
while ($count -gt 0) {
    foreach ($char in $animationText.ToCharArray()) {
        Write-Host -NoNewline $char -ForegroundColor Green
        Start-Sleep -Milliseconds $animationSpeed
        Write-Host -NoNewline "`b"  # 백스페이스를 사용하여 현재 문자를 지웁니다.
    }
    $count = $count - 1
}

~~~

아래는 위의 내용을 함수로 만들어 범용적으로 수정한 것이다. 
```powershell
function Start-TextAnimation {
    param (
        [string]$animationText,
        [int]$animationSpeed,  # 밀리초 단위
        [int]$count
    )

    Write-Host -NoNewline "progress...  " 
    while ($count -gt 0) {
        foreach ($char in $animationText.ToCharArray()) {
            Write-Host -NoNewline $char -ForegroundColor Green
            Start-Sleep -Milliseconds $animationSpeed
            Write-Host -NoNewline "`b"  # 백스페이스를 사용하여 현재 문자를 지웁니다.
        }
        $count = $count - 1
    }
}

# 함수 호출 예시
$animationText = "./\_-@"
$animationSpeed = 100  # 밀리초 단위
$count = 10

Start-TextAnimation -animationText $animationText -animationSpeed $animationSpeed -count $count

```
### 3. progress bar
Powershell에서 제공하는 Progress 
~~~powershell
$progress = 0
$maxProgress = 100

while ($progress -lt $maxProgress) {
    $progress += 10
    Write-Progress -Activity "Processing" -Status "Percent complete: $($progress)%" -PercentComplete $progress 
    Start-Sleep -Seconds 1
}

Write-Host "Task completed."

~~~

다음은 범용적 사용을 위해 함수로 변환한 것이다. 

```powershell
function Show-ProgressBar {
    param (
        [int]$maxProgress,
        [String]$msg
    )

    $progress = 0

    while ($progress -lt $maxProgress) {
        $progress += 10
        Write-Progress -Activity "Processing" -Status "Percent complete: $($progress)%" -PercentComplete $progress 
        Start-Sleep -Seconds 1
    }

    Write-Host "$msg"
}

# 함수 호출 예시
$maxProgress = 100
Show-ProgressBar -maxProgress $maxProgress -msg "완료되었습니다."

```
### 4. GridView(Out-GridView) 
Powershell에서는 GUI 형태의 GridView를 기본으로 제공한다. 

```powershell
# 현재 디렉토리의 파일 목록을 Out-GridView로 보여주기
$files = Get-ChildItem
$files | Out-GridView

# 실행 중인 프로세스 중 이름이 "chrome"인 프로세스만 Out-GridView로 보여주기
$processes = Get-Process | Where-Object { $_.ProcessName -like "chrome" }
$processes | Out-GridView

# Object 정보를 Grid로 보여주기
Get-ChildItem | Get-Member | Out-GridView

```

다음은 Out-GridView에서 항목을 선택하는 방법을 예시한 것이다. 

```powershell
$processes = Get-Process | Where-Object { $_.CPU -gt 10 }

# 사용자에게 선택할 수 있는 표 표시
$selected = $processes | Out-GridView -OutputMode Single -Title "Select a User"

# 선택된 사용자 정보 출력
if ($selected) {
    Write-Output "선택: $($selected.ProcessName)"

} else {
    Write-Output "No selected."
}
```


### 4. Format-Table, Format-List 
명령어로 나온 결과물을 Table 형식 또는 List 형식으로 보여준다.  

```powershell

# 모든 프로세스의 리스트 형식 출력
Get-Process | Format-List

# 서비스 목록 중 일부 속성을 테이블 형식으로 출력
# -AutoSize를 옵션으로 지정하면 화면크기에 맞게 출력
Get-Service | Select-Object DisplayName, Status | Format-Table

```