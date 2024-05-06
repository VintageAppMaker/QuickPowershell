function serverRun(){
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response

        # 데이터 읽기
        $reader = New-Object System.IO.StreamReader($request.InputStream)
        $data = $reader.ReadToEnd()
        $reader.Close()

        Write-Host "Received command: $data"

        # Out-String을 하지 않으면 Object 정보로 전달함
        $result = Invoke-Expression $data
        $resultString = $result | Out-String

        # 결과전송
        $writer = New-Object System.IO.StreamWriter($response.OutputStream)
        $writer.Write($resultString)
        $writer.Close()
    }
}
# 서버정의
$serverUrl = "http://localhost:8080/"

# HTTP 서버(COM)
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add($serverUrl)
$listener.Start()

Write-Host "Server is listening on $serverUrl"
Write-Host "CTRL + C를 누르면 다음 클라이언트 접속 시 종료됨 "

# URL 채크안함. 초간단 처리.
# CTRL + C를 구현하기 위해 try..catch
try{
    serverRun
} catch{
    Write-Host "Server stopped."
}

