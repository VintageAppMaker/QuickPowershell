# Word COM 객체 생성
$word = New-Object -ComObject Word.Application

# 현재 폴더 내의 모든 .docx 파일 가져오기
$docxFiles = Get-ChildItem -Path . -Filter *.docx

foreach ($file in $docxFiles) {
    # Word 문서 열기
    $doc = $word.Documents.Open($file.FullName)
    
    # 찾을 문자열 정의
    $searchString = "고양이"
    
    # 찾기
    $found = $doc.Content.Find.Execute($searchString)
    
    if ($found) {
        $range = $doc.Content
        $lineNumber = $range.Information[2]   # wdFirstCharacterLineNumber 상수 대신 2를 사용하여 라인 번호 가져오기
        
        Write-Output "파일 이름: $($file.Name)"
        Write-Output "라인 번호: $lineNumber"
    }
    
    # Word 문서 닫기
    $doc.Close()
}

# Word 닫기
$word.Quit()

# COM 객체 해제
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($doc) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($word) | Out-Null
Remove-Variable doc, word