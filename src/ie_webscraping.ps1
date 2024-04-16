# Internet Explorer COM 객체 생성
$ie = New-Object -ComObject "InternetExplorer.Application"

# IE 창 숨기기
$ie.Visible = $false

# 웹 페이지 열기
$url = "http://vintageappmaker.com/"
$ie.Navigate($url)

# 페이지 로딩 대기
while ($ie.Busy -eq $true) { Start-Sleep -Milliseconds 100 }

# HTML 문서 가져오기
$htmlDocument = $ie.Document

# 명언과 저자 추출
$widgets = $htmlDocument.getElementsByClassName("feedback-box")
foreach ($w in $widgets) {
    $msg = $w.getElementsByClassName("message").innerText
    Write-Host "Find: $msg"
}

# IE 닫기
$ie.Quit()

#zerif_testim-widget-6