# Microsoft Word 
간단한 MS Offfice 제품군의 COM(Component Object Model)을 사용할 수 있다. 그러나 Windows Programming에서 COM의 동시성과 안정성 확보는 쉽지않다. 결론적으로 단순함 이상의 기능을 구현하고자 한다면 Native Programming(VC++, etc)을 사용하거나 Python의 자동화 모듈을 사용하는 것이 효율적이다. 

### 1. 예제 1 (간단예제)

```powershell
  
$word = New-Object -ComObject Word.Application
$word.Visible = $true # 작업 시 화면에 보이기

# 파일열기
# $doc = $word.Documents.Open("C:\Path\to\Your\File.docx")

# 문서추가  
$doc = $word.Documents.Add()

# 문단(글자) 적용
$selection = $word.Selection
$selection.TypeText("Hello, World!")

# 스타일 적용  
$selection.Font.Bold = $true
$selection.Font.Italic = $true
$selection.Font.Size = 14
$selection.Font.Name = "Arial"

$selection.TypeText("Hello, World!")

# 용지설정

# $doc.PageSetup.Orientation = 1 # 가로: 0, 세로: 1
# $doc.PageSetup.TopMargin = 50
# $doc.PageSetup.BottomMargin = 50
# $doc.PageSetup.LeftMargin = 50
# $doc.PageSetup.RightMargin = 50

# 이미지 추가
$selection.InlineShapes.AddPicture("test.png")
$table = $doc.Tables.Add($selection.Range, 3, 3)

# 저장 및 종료
$doc.SaveAs("text.docx")
$doc.Close()
$word.Quit()

[System.Runtime.Interopservices.Marshal]::ReleaseComObject($word)
```

위의 예제에서는 경로명을 절대경로로 하지 않았기에 PC 환경에 따라 올바르게 저장되지 않을 수도 있다. 아래는 절대 경로명을 추가한 예제이다. 
### 2. 예제 2 (간단예제)

다음은 절대경로명을 설정한 예제이다. 

```powershell
# [주의]
# 경로명은 절대경로로 해야 한다. 
# 인증안된 msoffice일 경우, word.Visible을 false로 해야 한다. 

$word = New-Object -ComObject Word.Application
$word.Visible = $false

# 문서추가
$doc = $word.Documents.Add()

# 문단 추가
$selection = $word.Selection
$selection.TypeText("Hello, World!")

# 스타일 적용
$selection.Font.Bold = $true
$selection.Font.Italic = $true
$selection.Font.Size = 12
$selection.Font.Name = "Arial"
$selection.Font.Color = 0xFFA000

# 텍스트 추가
$text = @"

문단단위로 입력은 이렇게 .
1
2
3

불편한 것인지 편한 것인지 모르겠네요

"@


$selection = $word.Selection
$selection.TypeText("$text")

# 이미지 추가
$selection.InlineShapes.AddPicture("C:\example_all\powershell_example\test.png")

$selection.Font.Bold = $false
$selection.Font.Italic = $false
$selection.Font.Size = 12
$selection.Font.Name = "D2Coding"
$selection.Font.Color = 0x000000

$table = $doc.Tables.Add($selection.Range, 3, 3)
$table.Cell(1, 1).Range.Text = "1"
$table.Cell(1, 2).Range.Text = "2"
$table.Cell(1, 3).Range.Text = "3"
$table.Cell(2, 1).Range.Text = "4"
$table.Cell(2, 2).Range.Text = "5"
$table.Cell(2, 3).Range.Text = "6"

$doc.SaveAs("C:\example_all\powershell_example\test.docx")

$doc.Close()
$word.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($word)

```

### 3. 예제 3

docx 파일 내에 "고객님"이라는 문자가 있으면 고객의 이름을 활용하여 파일명을 교체한다. 
com의 특성상, 언제나 안정성이 보장되는 것은 아니다. 결론은 python을 활용하는 것이 현명하다. 

```powershell
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


```
