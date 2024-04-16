function Show-Menu {
    Clear-Host
    Write-Host "1. Option 1" -ForegroundColor Green
    Write-Host "2. Option 2" -ForegroundColor Cyan
    Write-Host "3. Option 3" -ForegroundColor Yellow
    Write-Host "4. Exit" -ForegroundColor Red
}

# 배경색 설정
$Host.UI.RawUI.BackgroundColor = "DarkOrange"

do {
    Show-Menu
    $choice = Read-Host "Please make a selection"

    switch ($choice) {
        "1" {
            Write-Host "You selected Option 1" -ForegroundColor Green
            # Do something for Option 1
            Pause
        }
        "2" {
            Write-Host "You selected Option 2" -ForegroundColor Cyan
            # Do something for Option 2
            Pause
        }
        "3" {
            Write-Host "You selected Option 3" -ForegroundColor Yellow
            # Do something for Option 3
            Pause
        }
        "4" {
            Write-Host "Exiting..." -ForegroundColor Red
        }
        default {
            Write-Host "Invalid selection! Please try again." -ForegroundColor Red
            Pause
        }
    }

    # 사용자가 Enter를 누르면 메뉴를 다시 표시
    $null = Read-Host "Press Enter to continue"
} while ($choice -ne "4")
