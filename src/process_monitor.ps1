# Powershell 5.1에서만 사용가능함. 
try {
    # 감지할 프로세스 이름 설정
    $targetProcessName = "notepad"

    # 이벤트를 감지할 WMI 쿼리 설정
    $query = "SELECT * FROM __InstanceCreationEvent WITHIN 1 WHERE TargetInstance ISA 'Win32_Process' AND TargetInstance.Name = '$targetProcessName'"

    # 이벤트를 감지하고 반응하는 이벤트 핸들러 등록
    Register-WmiEvent -Query $query -Action {
        $processName = $event.SourceEventArgs.NewEvent.TargetInstance.Name
        $processId = $event.SourceEventArgs.NewEvent.TargetInstance.ProcessId
        $timeStamp = Get-Date

        # 실행된 프로세스 정보 로그 기록
        $logMessage = "$timeStamp - Process '$processName' (PID: $processId) started."
        Add-Content -Path "C:\Logs\process.log" -Value $logMessage

        # 필요한 경우 프로세스 종료
        # Stop-Process -Id $processId -Force
    }

    # 스크립트가 실행되는 동안 대기
    Write-Host "Press Enter to stop monitoring..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

    # 이벤트 핸들러 등록 해제
    Get-EventSubscriber | Unregister-Event
} catch {
    Write-Host "Error occurred: $_"
}
