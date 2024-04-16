# [주의]
# 경로명은 절대경로로 해야 한다. 
# 인증안된 msoffice일 경우, word.Visible을 false로 해야 한다. 

$word = New-Object -ComObject Word.Application
$word.Visible = $false

$doc = $word.Documents.Add()

$selection = $word.Selection
$selection.TypeText("Hello, World!")

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
