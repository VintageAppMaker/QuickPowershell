# Schedule 

Powershell에서는 Schedule Task(일정시간 반복업무)를 다음과 같이 관리할 수 있다.

| 명령                       | 내용              |
| ------------------------ | --------------- |
| New-ScheduledTaskAction  | 스케쥴을 생성하고 등록한다. |
| Get-ScheduledTask        | 스케쥴 정보를 가져온다.   |
| Unregister-ScheduledTask | 스케쥴을 삭제한다.      |

### 1. 기본 사용법

#### 1. 분 단위 등록

```powershell
# 분 단위 작업 등록
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -Command `"Write-Output '분 단위 작업 실행됨 - $(Get-Date)'`""
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(1)
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries

Register-ScheduledTask -TaskName "MinuteTask" -Action $action -Trigger $trigger -Settings $settings
Write-Output "분 단위 작업이 스케줄에 등록되었습니다."
```

#### 2. 시간 단위 등록

```powershell
# 시간 단위 작업 등록 (매 시간 정각)
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -Command `"Write-Output '시간 단위 작업 실행됨 - $(Get-Date)'`""
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddHours(1).Date
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries

Register-ScheduledTask -TaskName "HourlyTask" -Action $action -Trigger $trigger -Settings $settings
Write-Output "시간 단위 작업이 스케줄에 등록되었습니다."
```

#### 3. 날짜 단위 등록

```powershell
# 날짜 단위 작업 등록 (특정 날짜에 실행)
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -Command `"Write-Output '날짜 단위 작업 실행됨 - $(Get-Date)'`""
$trigger = New-ScheduledTaskTrigger -Once -At "2024-04-10 08:00:00"
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries

Register-ScheduledTask -TaskName "DateTask" -Action $action -Trigger $trigger -Settings $settings
Write-Output "날짜 단위 작업이 스케줄에 등록되었습니다."
```



### 2. 활용

#### 예제 1: 
하루 2시간 단위로 c:\server\log의 내용을 c:\server\logbackup으로 압축

```powershell
# 스케줄러에 등록된 작업이 이미 있다면 제거
Unregister-ScheduledTask -TaskName "LogBackupTask" -ErrorAction SilentlyContinue

# 새로운 작업을 만들기 위한 설정
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -Command `"Compress-Archive -Path 'C:\server\log\*' -DestinationPath 'C:\server\logbackup\log_$(Get-Date -Format 'yyyyMMddHHmmss').zip' -Force`""
$trigger = New-ScheduledTaskTrigger -Daily -At "02:00"
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries

# 작업 등록
Register-ScheduledTask -TaskName "LogBackupTask" -Action $action -Trigger $trigger -Settings $settings

Write-Output "로그 백업 작업이 스케줄에 등록되었습니다."
```


#### 예제 2: 

하루 2시간 단위로 현재의 폴더(git이 remote로 연결됨)를 git add , git commit -m -a "현재시간", git push를 진행


```powershell
# 스케줄러에 등록된 작업이 이미 있다면 제거
Unregister-ScheduledTask -TaskName "GitAutoCommitTask" -ErrorAction SilentlyContinue

# 새로운 작업을 만들기 위한 설정
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -Command `"cd 'C:\path\to\your\git\repository'; git add .; git commit -m 'Auto commit - $(Get-Date -Format 'yyyyMMddHHmmss')'; git push origin master`""
$trigger = New-ScheduledTaskTrigger -Daily -At "02:00"
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries

# 작업 등록
Register-ScheduledTask -TaskName "GitAutoCommitTask" -Action $action -Trigger $trigger -Settings $settings

Write-Output "Git 자동 커밋 작업이 스케줄에 등록되었습니다."
```

