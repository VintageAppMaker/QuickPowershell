# PowerPoint COM 객체 생성
$ppt = New-Object -ComObject PowerPoint.Application
# 새로운 프레젠테이션 생성
$presentation = $ppt.Presentations.Add()

# 슬라이드 추가
$slide = $presentation.Slides.Add(1, 1)  # 1은 슬라이드 종류 (1=일반 슬라이드), 1은 슬라이드 인덱스

# 슬라이드에 텍스트 추가
$textbox = $slide.Shapes.AddTextbox(1, 100, 100, 500, 200)  # 1은 텍스트 상자 종류, 좌표 및 크기
$textbox.TextFrame.TextRange.Text = "PowerShell을 사용한 PowerPoint 프레젠테이션 예제입니다."

# 프레젠테이션 저장
#$presentation.SaveAs("./TestPresentation.pptx")

# PowerPoint 종료
$ppt.Quit()

# COM 객체 해제
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($textbox) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($slide) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($presentation) | Out-Null
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($ppt) | Out-Null
Remove-Variable ppt, presentation, slide, textbox
