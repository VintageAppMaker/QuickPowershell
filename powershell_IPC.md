# IPC
powershell에서 IPC(Inter Process Communication) 예제 중에 가장 간편하게 사용할 수 있는 것이 pipe이다. 다음은 초간단 예제이다. 

- Server 
	- NamedPipeServerStream으로 파이프를 생성한다. 
	- WaitForConnection()으로 기다린다. 
	- StreamReader의 ReadLine()으로 클라이언트의 정보를 기다린다. 
	- 종료 시, StreamReader의 Dispose()를 호출한다.   

```powershell
# 파이프 서버 만들기
$pipeServer = New-Object System.IO.Pipes.NamedPipeServerStream("mypipe", [System.IO.Pipes.PipeDirection]::InOut)
$pipeServer.WaitForConnection()

# 파이프에서 데이터 읽기
$reader = New-Object System.IO.StreamReader($pipeServer)
$data = $reader.ReadLine()
Write-Host "Received from client: $data"
$reader.Dispose()
```

- Client 
	- NamedPipeClientStream으로 파이프를 생성한다. 
	- Connect()로 서버에 접속한다. 
	- StreamWriter의 WriteLine()으로 데이터를 전송한다. 
	- 종료 시, StreamWriter의 Dispose()를 호출한다. 

```powershell
# 파이프 클라이언트 만들기
$pipeClient = New-Object System.IO.Pipes.NamedPipeClientStream(".", "mypipe", [System.IO.Pipes.PipeDirection]::InOut)
$pipeClient.Connect()

# 서버와 클라이언트 간에 데이터 송수신
$writer = New-Object System.IO.StreamWriter($pipeClient)
$writer.WriteLine("Hello from client")
$writer.Dispose()
```

- Socket server

```powershell
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

```

- socket client

```powershell

# 서버접속
$serverUrl = "http://localhost:8080/"

# 이곳에서 커맨드처리 
$command = "Get-Process | Select-Object -First 5"

# Send command to server and get result
$response = Invoke-RestMethod -Uri $serverUrl -Method Post -Body $command

# Print result
Write-Host "결과:"
$response

```
