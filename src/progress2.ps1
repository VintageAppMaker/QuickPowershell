function Show-ProgressBar {
    param (
        [int]$maxProgress,
        [String]$msg
    )

    $progress = 0

    while ($progress -lt $maxProgress) {
        $progress += 10
        Write-Progress -Activity "Processing" -Status "Percent complete: $($progress)%" -PercentComplete $progress 
        Start-Sleep -Seconds 1
    }

    Write-Host "$msg"
}

# 함수 호출 예시
$maxProgress = 100
Show-ProgressBar -maxProgress $maxProgress -msg "완료되었습니다."
