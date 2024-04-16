# databackup  
정기적으로 자료를 백업해야 할 경우, Shell의 스크립트(배치파일)을 이용하는 경우가 흔하다. Powershell에서는 Compress-Archive와 Expand-Archive를 사용하여 폴더를 압축/해제하는 경우가 일반적이다. 

```powershell

# 현재 날짜와 시간을 포맷팅하여 백업 파일 이름 생성
$currentTime = Get-Date -Format "yyyyMMdd_HHmmss"
$backupFileName = "C:\backup\${currentTime}_backup.zip"

# 압축
Compress-Archive -Path "C:\관리하는폴더\" -DestinationPath $backupFileName

# 압축해제 
Expand-Archive -Path $backupFileName -DestinationPath "C:\관리하는폴더\"

```

그러나 고전적으로는 tar를 사용하여 압축하는 방법이 사용되고 있다. 대부분의 OS에서 공통적으로 사용할 수 있기 때문이다. 아래의 소스는 DOS Prompt에서 사용하던 백업 배치파일이다. 

```bash
@echo off
chcp 65001 > nul

:menu
cls
echo 원하는 메뉴를 선택하세요 😀:
echo 1. backup 
echo 2. restore 
echo 3. resotre by filename 
echo 4. show file list 
echo 5. quit 

set /p choice=선택: 

if "%choice%"=="1" goto backup
if "%choice%"=="2" goto restore
if "%choice%"=="3" goto custom_restore
if "%choice%"=="4" goto filelist
if "%choice%"=="5" goto quit 

echo 선택한 메뉴가 올바르지 않습니다.
pause
goto menu

:backup
cls
echo 자료를 백업합니다...

rem 현재 시간을 가져오기 위해 날짜 및 시간 구성 요소를 사용합니다.
set datetime=%date:/=-%_%time::=-%
set datetime=%datetime: =0%
set datetime=%datetime:~0,19%
set datetime=%datetime:~,19%

rem 자료를 tar로 압축하고 현재 시간을 이름으로 지정합니다.
rem backup 폴더와 restore 폴더를 제외하고 압축합니다.
tar -cvf backup_%datetime%.tar --exclude="backup" --exclude="restore" *

rem 만약 backup 폴더가 없으면 생성합니다.
if not exist backup mkdir backup

rem 압축된 파일을 backup 폴더로 이동합니다.
move backup_%datetime%.tar backup

echo 자료백업이 완료되었습니다.
pause
goto menu

:restore
cls
echo 자료를 가져옵니다...

rem backup 폴더에서 가장 최근의 백업 파일을 찾습니다.
for /f %%f in ('dir /b /od backup\*.tar') do set recent_backup=%%f

rem 만약 백업 파일이 없으면 메시지를 출력하고 메뉴로 돌아갑니다.
if "%recent_backup%"=="" (
    echo 백업된 자료가 없습니다.
    pause
    goto menu
) else (
    rem 백업 파일을 현재 폴더로 가져옵니다.
    copy backup\%recent_backup% .

    rem 가져온 백업 파일의 압축을 해제합니다.
    tar -xvf %recent_backup%

    rem 가져온 백업 파일을 삭제합니다.
    del %recent_backup%

    echo 백업된 자료를 가져왔습니다.
    pause
    goto menu
)

:custom_restore
cls
set /p filename=가져올 파일명을 입력하세요: 

rem 입력된 파일명으로 파일을 가져옵니다.
copy backup\%filename% .

rem 가져온 백업 파일의 압축을 해제합니다.
tar -xvf %filename%

rem 가져온 백업 파일을 삭제합니다.
del %filename%

echo 파일을 가져왔습니다.
pause
goto menu

:filelist
cls
echo backup 폴더에 있는 tar 파일 목록입니다:
dir /b /a-d backup\*.tar
pause
goto menu

:quit

```

위의 소스를  linux bash로 사용하면 다음과 같다. 

```bash
#!/bin/bash

menu() {
    clear
    echo "원하는 메뉴를 선택하세요 😀:"
    echo "1. 백업"
    echo "2. 복원"
    echo "3. 파일명으로 복원"
    echo "4. 파일 목록 보기"
    echo "5. 종료"
    read -p "선택: " choice

    case $choice in
        1) backup ;;
        2) restore ;;
        3) custom_restore ;;
        4) filelist ;;
        5) quit ;;
        *) echo "올바르지 않은 메뉴입니다." ;;
    esac
}

backup() {
    clear
    echo "자료를 백업합니다..."

    datetime=$(date +"%Y-%m-%d_%H-%M-%S")
    tar -cvf backup_$datetime.tar --exclude="backup" --exclude="restore" *

    mkdir -p backup
    mv backup_$datetime.tar backup/

    echo "자료 백업이 완료되었습니다."
    read -n 1 -s -r -p "계속하려면 아무 키나 누르세요..."
}

restore() {
    clear
    echo "자료를 복원합니다..."

    recent_backup=$(ls -t backup/*.tar | head -n 1)

    if [ -z "$recent_backup" ]; then
        echo "백업된 자료가 없습니다."
    else
        cp "$recent_backup" .
        tar -xvf "${recent_backup##*/}"
        rm "${recent_backup}"
        echo "백업된 자료를 복원했습니다."
    fi

    read -n 1 -s -r -p "계속하려면 아무 키나 누르세요..."
}

custom_restore() {
    clear
    read -p "가져올 파일명을 입력하세요: " filename

    cp "backup/$filename" .
    tar -xvf "$filename"
    rm "$filename"

    echo "파일을 가져왔습니다."
    read -n 1 -s -r -p "계속하려면 아무 키나 누르세요..."
}

filelist() {
    clear
    echo "backup 폴더에 있는 tar 파일 목록입니다:"
    ls -1 backup/*.tar
    read -n 1 -s -r -p "계속하려면 아무 키나 누르세요..."
}

quit() {
    clear
    echo "프로그램을 종료합니다."
    exit 0
}

while true; do
    menu
done

```

powershell로 변환하면 다음과 같다. 

```powershell
# 메뉴 함수 정의
function Show-Menu {
    Clear-Host
    Write-Host "원하는 메뉴를 선택하세요 😀:"
    Write-Host "1. 백업"
    Write-Host "2. 복원"
    Write-Host "3. 파일명으로 복원"
    Write-Host "4. 파일 목록 보기"
    Write-Host "5. 종료"

    $choice = Read-Host "선택"

    switch ($choice) {
        1 { Backup }
        2 { Restore }
        3 { CustomRestore }
        4 { FileList }
        5 { Exit }
        default { Write-Host "올바르지 않은 메뉴입니다." }
    }
}

# 백업 함수
function Backup {
    Clear-Host
    Write-Host "자료를 백업합니다..."

    $datetime = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
    tar -cvf "backup_$datetime.tar" --exclude="backup" --exclude="restore" *

    if (-not (Test-Path "backup")) {
        New-Item -ItemType Directory -Name "backup" | Out-Null
    }

    Move-Item "backup_$datetime.tar" "backup/"

    Write-Host "자료 백업이 완료되었습니다."
    Read-Host "계속하려면 Enter 키를 누르세요..."
}

# 복원 함수
function Restore {
    Clear-Host
    Write-Host "자료를 복원합니다..."

    $recentBackup = Get-ChildItem "backup\*.tar" | Sort-Object LastWriteTime | Select-Object -Last 1

    if (-not $recentBackup) {
        Write-Host "백업된 자료가 없습니다."
    }
    else {
        Copy-Item $recentBackup.FullName -Destination "."
        tar -xvf $recentBackup.Name
        Remove-Item $recentBackup.Name
        Write-Host "백업된 자료를 복원했습니다."
    }

    Read-Host "계속하려면 Enter 키를 누르세요..."
}

# 파일명으로 복원 함수
function CustomRestore {
    Clear-Host
    $filename = Read-Host "가져올 파일명을 입력하세요: "

    Copy-Item "backup\$filename" -Destination "."
    tar -xvf $filename
    Remove-Item $filename

    Write-Host "파일을 가져왔습니다."
    Read-Host "계속하려면 Enter 키를 누르세요..."
}

# 파일 목록 보기 함수
function FileList {
    Clear-Host
    Write-Host "backup 폴더에 있는 tar 파일 목록입니다:"
    Get-ChildItem "backup\*.tar" | Select-Object -ExpandProperty Name
    Read-Host "계속하려면 Enter 키를 누르세요..."
}

# 종료 함수
function Exit {
    Clear-Host
    Write-Host "프로그램을 종료합니다."
    Exit
}

# 메뉴 루프
while ($true) {
    Show-Menu
}

```