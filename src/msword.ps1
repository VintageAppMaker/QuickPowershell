
$word = New-Object -ComObject Word.Application
$word.Visible = $true

# $doc = $word.Documents.Open("C:\Path\to\Your\File.docx")

$doc = $word.Documents.Add()

$selection = $word.Selection
$selection.TypeText("Hello, World!")

$selection.Font.Bold = $true
$selection.Font.Italic = $true
$selection.Font.Size = 14
$selection.Font.Name = "Arial"

$selection.TypeText("Hello, World!")

# $doc.PageSetup.Orientation = 1 # 가로: 0, 세로: 1
# $doc.PageSetup.TopMargin = 50
# $doc.PageSetup.BottomMargin = 50
# $doc.PageSetup.LeftMargin = 50
# $doc.PageSetup.RightMargin = 50

$selection.InlineShapes.AddPicture("test.png")


$table = $doc.Tables.Add($selection.Range, 3, 3)


$doc.SaveAs("text.docx")

$doc.Close()
$word.Quit()
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($word)
