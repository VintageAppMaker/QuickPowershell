# Microsoft Excel 
간단한 MS Offfice 제품군의 COM(Component Object Model)을 사용할 수 있다. 그러나 Windows Programming에서 COM의 동시성과 안정성 확보는 쉽지않다. 결론적으로 단순함 이상의 기능을 구현하고자 한다면 Native Programming(VC++, etc)을 사용하거나 Python의 자동화 모듈을 사용하는 것이 효율적이다. 

### 1. 예제 1 (간단예제)

초간단 Excel Sheet에 Cell 채워넣기 예제
```powershell
  
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

```

### 2. 예제 2 (간단예제)

Sheet 이름대로 파일을 생성하는 예제. 업무상 자주 사용하게 되는 소스이다. 

```powershell
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
```


