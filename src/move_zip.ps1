# 서브폴더를 생성할 폴더명 설정
$backupFolder = "backup_zip"

# 만약 서브폴더가 존재하지 않으면 생성
if (-not (Test-Path $backupFolder)) {
    New-Item -ItemType Directory -Path $backupFolder | Out-Null
}

# 현재 폴더의 zip 파일들을 서브폴더로 이동
Get-ChildItem -Filter *.zip | Move-Item -Destination $backupFolder
