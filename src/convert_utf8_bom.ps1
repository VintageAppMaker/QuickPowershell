# 현재 폴더 내의 모든 .ps1 파일 가져오기
$ps1Files = Get-ChildItem -Path . -Filter *.ps1

foreach ($file in $ps1Files) {
    # UTF-8 BOM으로 변환
    Set-Content -Path $file.FullName -Value (Get-Content -Path $file.FullName -Encoding UTF8) -Encoding UTF8
}

