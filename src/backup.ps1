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
        
        Remove-Item $recentBackup.name
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
