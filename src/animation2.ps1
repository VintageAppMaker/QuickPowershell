function Start-TextAnimation {
    param (
        [string]$animationText,
        [int]$animationSpeed,  # 밀리초 단위
        [int]$count
    )

    Write-Host -NoNewline "progress...  " 
    while ($count -gt 0) {
        foreach ($char in $animationText.ToCharArray()) {
            Write-Host -NoNewline $char -ForegroundColor Green
            Start-Sleep -Milliseconds $animationSpeed
            Write-Host -NoNewline "`b"  # 백스페이스를 사용하여 현재 문자를 지웁니다.
        }
        $count = $count - 1
    }
}

# 함수 호출 예시
$animationText = "./\_-@"
$animationSpeed = 100  # 밀리초 단위
$count = 10

Start-TextAnimation -animationText $animationText -animationSpeed $animationSpeed -count $count