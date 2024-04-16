# eval

일반적으로 shell programing에서 `eval` 명령어는 문자열을 인자로 받아서 해당 문자열을 shell에서 실행시키는 역할을 한다. powershell에서는 eval 명령어를 Invoke-Expression으로 구현할 수 있다. 

```powershell
# PowerShell의 Invoke-Expression을 사용하여 eval과 비슷한 기능 구현
$expression = "2 + 3"
$result = Invoke-Expression $expression
Write-Output "더하기 결과: $result"
```

Invoke-Expression은 ps1 파일을 읽어온 후 처리할 수도 있다. 

```powershell
# 파일 읽기
$scriptContent = Get-Content -Path "C:\path\to\your\script.ps1" -Raw

# 스크립트 실행
Invoke-Expression $scriptContent
```
