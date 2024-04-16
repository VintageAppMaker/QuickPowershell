$progress = 0
$maxProgress = 100

while ($progress -lt $maxProgress) {
    $progress += 10
    Write-Progress -Activity "Processing" -Status "Percent complete: $($progress)%" -PercentComplete $progress 
    Start-Sleep -Seconds 1
}

Write-Host "Task completed."
