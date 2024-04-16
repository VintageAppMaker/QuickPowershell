
# 현재 폴더 내의 xlsx 파일 가져오기
$files = Get-ChildItem -Path . -Filter *.xlsx

# 각 xlsx 파일에 대해 작업하기
foreach ($file in $files) {
    # Excel 파일 열기
    $excel = New-Object -ComObject Excel.Application
    $workbook = $excel.Workbooks.Open($file.FullName)

    try {
        # 각 시트별로 작업하기
        foreach ($sheet in $workbook.Sheets){
            $sheetName = $sheet.Name
            
            # 새 파일명 생성
            $newFileName = "{0}\{1}_{2}.xlsx" -f $file.DirectoryName, $file.BaseName, $sheetName

            # 시트 데이터 추출
            $sheetData = $workbook.Sheets.Item($sheetName)
            $range = $sheetData.UsedRange

            # 새 파일 생성
            $newWorkbook = $excel.Workbooks.Add()
            $newSheet = $newWorkbook.Sheets.Item(1)

            # 범위 복사 및 붙여넣기
            $range.Copy()
            $newSheet.Paste()

            # 새 파일 저장 및 닫기
            $newWorkbook.SaveAs($newFileName)
            $newWorkbook.Close()
            
            Write-Host $newFileName
        }
    }
    finally {
        # Excel 객체 정리
        $workbook.Close()
        $excel.Quit()
        [System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel) | Out-Null
        Remove-Variable excel -ErrorAction SilentlyContinue
    }
}
