# Excel COM 개체 생성
$excel = New-Object -ComObject Excel.Application

# Excel 창 숨기기
$excel.Visible = $false

# 새 워크북 생성
$workbook = $excel.Workbooks.Add()

# 워크시트 선택
$worksheet = $workbook.Worksheets.Item(1)

# 데이터 쓰기
$worksheet.Cells.Item(1, 1) = "Hello"
$worksheet.Cells.Item(1, 2) = "World!"

# 저장 및 닫기
$workbook.SaveAs("C:\example_all\file.xlsx")
$workbook.Close()
$excel.Quit()

# COM 개체 해제
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($worksheet) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($workbook) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel) | Out-Null
[System.GC]::Collect()
[System.GC]::WaitForPendingFinalizers()

