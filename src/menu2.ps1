
function Write-ColorText {
    param(
        [int]$row,
        [int]$col,
        [string]$text,
        [ConsoleColor]$color
    )

    # 커서를 지정된 위치로 이동.
    [Console]::SetCursorPosition($col, $row)

    # 색상을 변경.
    $originalColor = $host.UI.RawUI.ForegroundColor
    $host.UI.RawUI.ForegroundColor = $color

    # 텍스트를 출력.
    Write-Host $text -NoNewline

    # 원래 색상으로 복원.
    $host.UI.RawUI.ForegroundColor = $originalColor
}

# 메뉴 핸들러
function menu1{
    Write-Host "menu1 실행" -ForegroundColor Yellow
}
function menu2{
    Write-Host "menu2 실행" -ForegroundColor Yellow
}
function menu3{
    Write-Host "menu3 실행" -ForegroundColor Yellow
}


# 메뉴 항목 배열 정의
$menuItems   = @("항목 1", "항목 2", "항목 3", "종료")
$fnMenuItems = @({ menu1 }, { menu2 }, { menu3 }, {exit})


# 메뉴 화면 출력 함수 정의
function ShowMenu {
    Clear-Host
    Write-Host "메뉴를 선택하세요:" -ForegroundColor Yellow

    # 메뉴 항목 출력
    for ($i = 0; $i -lt $menuItems.Count; $i++) {
        $item = $menuItems[$i]
        if ($i -eq $selectedIndex) {
            Write-ColorText -row ($i + 2) -col 2 -text "👉🏾$item" -color Green
        } else {
            Write-ColorText -row ($i + 2) -col 4 -text "$item" -color White
        }
    }

    # 선택된 항목 표시
    Write-Host "`n선택된 항목: $($menuItems[$selectedIndex])"
}

# 초기 선택 인덱스 설정
$selectedIndex = 0
ShowMenu

# 메뉴 항목 선택 반복
while ($true) {
    $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown").VirtualKeyCode

    # 방향키 처리
    switch ($key) {
        38 {  # 위쪽 방향키
            if ($selectedIndex -gt 0) {
                $selectedIndex--
                ShowMenu
            }
        }
        40 {  # 아래쪽 방향키
            if ($selectedIndex -lt ($menuItems.Count - 1)) {
                $selectedIndex++
                ShowMenu
            }
        }
        13 {  # 엔터 키
            Clear-Host
            Write-Host "선택된 항목: $($menuItems[$selectedIndex])"
            &$fnMenuItems[$selectedIndex]

            Read-Host
            ShowMenu
            
            break
        }
    }
}
