# 현재 Folder에서 docx 가져오기
$docxFiles = Get-ChildItem -Path . -Filter *.docx

foreach ($file in $docxFiles) {
    # Word COM 생성 
    $wordApp = New-Object -ComObject Word.Application

    # Word 열기
    $doc = $wordApp.Documents.Open($file.FullName)

    try {
        Write-Host($file.FullName)

        # Word 전체문장 가져오기
        $doc.ActiveWindow.Selection.WholeStory()
        $doc.ActiveWindow.Selection.Copy()

        # Word 닫기
        $doc.Close()

        # 가져온 문장 저장
        $clipContent = Get-Clipboard 

        Write-Host($clipContent)

        # 문자열 찾기
        if ($clipContent -match "고객님") {
            # user 이름 분리
            $match = $clipContent | Select-String -Pattern "\b\w+\s고객님" -AllMatches | Select-Object -First 1
            $user = $match.Matches.Value.Trim().Replace("고객님", "_")

            # 현재시각
            $currentTime = Get-Date -Format "yyyyMMdd_HHmmss"
            $newFileName = $user + "$currentTime.docx"
            $newFilePath = Join-Path -Path (Get-Location) -ChildPath $newFileName

            Write-Host($newFilePath)

            # 문서추가
            $newDoc = $wordApp.Documents.Add()
            $newDoc.ActiveWindow.Selection.Paste()
            
            # Word 저장 및 종료
            $newDoc.SaveAs([System.Object]$newFilePath)
            $newDoc.Close()

            Write-Host "FileSaved: $newFilePath"
        }
        
    }
    finally {
        # Word COM 해제
        $wordApp.Quit()
        [System.Runtime.Interopservices.Marshal]::ReleaseComObject($wordApp) | Out-Null
        Remove-Variable wordApp  -ErrorAction SilentlyContinue
    }
}


