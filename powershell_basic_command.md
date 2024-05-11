# Powershell 기초 명령어
Powershell을 사용하면서 필수적으로 알아야 할 내용을 다음과 같이 정리했다. 

## 0. 화면에 문자출력 및 입력
PowerShell에서 `Write-Host`와 `Write-Output`의 주요 차이점은 다음과 같다:

1. **출력 방식:**
    
    * `Write-Host`: 콘솔에 직접 출력
    * `Write-Output`: 데이터를 파이프라인으로 전달
2. **호출 방식:**
    
    * `Write-Host`: 함수 호출로 직접 값을 출력
    * `Write-Output`: 값을 함수나 변수로 반환하고, 이후에 다른 작업에 파이프라인을 통해 전달

3. **입력받기:**
    
    * `Read-Host`: 입력값을 읽기
    * -AsSecureString : 비밀번호
    * -MaskInput : 비밀번호


**Write-Host 예제:**

```powershell
Write-Host "This is a message displayed using Write-Host"

$variable = "Value"
Write-Host "The value of the variable is: $variable"

Write-Host "This is a message with foreground and background color" -ForegroundColor Yellow -BackgroundColor Black

Write-Host "Error occurred!" -ForegroundColor Red

Write-Host "This is another message" | Out-File -FilePath "output.txt"

```

**Write-Output 예제:**

```powershell

Write-Output "This is a message displayed using Write-Output"

$variable = "Value"
Write-Output "The value of the variable is: $variable"

Write-Output "This message will be sent through the pipeline" | ForEach-Object { $_ + " (Modified)" }

Get-ChildItem | Write-Output

$numbers = 1..10
Write-Output $numbers

```

**Read-Host 예제:**

```powershell
$Age = Read-Host "Please enter your age"
$pwd_secure_string = Read-Host "Enter a Password" -AsSecureString
$pwd_string = Read-Host "Enter a Password" -MaskInput
```
## 1. 도움말
Powershell 명령어를 검색하는 도움말

| 명령어                      | 내용                                                                     |
| ------------------------ | ---------------------------------------------------------------------- |
| Get-Verb                 | Verb에 관련된 리스트를 보여준다.                                                   |
| Get-command              | command에 관련된 리스트를 보여준다.                                                |
| Get-Help 커맨드 -online(옵션) | help 매뉴얼을 보여준다. -Online을 추가하면 온라인 메뉴얼로 이동한다(-Online은 자세한 정보를 제공하고 있다). |

## 2. File
파일을 처리하는 명령어 정리. File외에도 $_은 객체를 뜻한다. 그러므로 . 을 사용하여 해당 객체의 멤버필드와 메소드를 사용할 수 있다.

- `$_` 은 전체경로
- `$_.BaseName` 은 확장자 제외 파일명
- `$_Extension` 은 확장자

| 커맨드                            | 사용법                                                                                                                |
| ------------------------------ | ------------------------------------------------------------------------------------------------------------------ |
| (Get-Command `실행파일명`).Path     | Path에 등록된 파일의 경로를 보여준다.<br><br>                                                                                    |
| Get-ChildItem                  | 파일이나 디렉토리 정보를 가져온다.<br><br>-Path는 경로<br>-Recursive는 서브폴더까지 설정                                                      |
| New-Item                       | 파일이나 디렉토리를 생성한다.<br><br>-Path는 경로 <br>-Name는 파일 이름 <br>-ItemType은 타입 "file", "directory"<br>-Value는 최초생성 후, 입력되는 값 |
| Remove-Item                    | 파일이나 디렉토리를 지울 때 사용한다.                                                                                              |
| <br>Rename-Item -NewName{}<br> | 파일의 이름을 변경 <br><br>-NewName { 코드 }                                                                                 |
| Set-Content                    | 파일에 정보를 입력 <br><br>-Path는 경로<br>-Value는 저장할 값                                                                      |
| Get-Content                    | 파일의 정보를 가져온다.<br><br>-Path는 경로<br><br>`binary file로 가져오기`<br>-AsByteStream <br>-Raw                                |

- 자주 사용하는 명령어 1

```powershell

# 파일개수 
( Get-ChildItem -filter "*.zip").count 

# 경로명 가져오기 
(get-Command notepad.exe).path

# 하위폴더까지 파일과 디렉토리 정보 가져오기  
Get-ChildItem -Path . -Recurse -Force

# 파일생성 및 값 넣기   
New-Item -Path . -Name "test.txt" -ItemType "file" -Value "테스트 입니다"

# 하위폴더까지 temp 파일 지우기    
Get-ChildItem * -Include *.tmp -Recurse | Remove-Item

# 디렉토리 내의 모든 파일이름 바꾸기     
Get-ChildItem | Rename-Item -NewName {  "ren_" + $_.BaseName + $_.Extension }

# 특정 파일에다가 내용을 넣기 
Set-Content -Path .\Test*.txt -Value 'Hello, World'

# 특정 파일 내용가져오기 
Get-Content -Path .\Test.txt

# 압축해제하기(quick_ktor.zip을 .\ext 폴더에 풀기 )
expand-archive .\quick_ktor.zip .\ext   

# 현재 폴더를 backup.zip으로 압축
Compress-Archive -Path * -DestinationPath "backup.zip"

```

- 자주 사용하는 명령어 2
```powershell
#현재 폴더의 zip 파일들을 하부폴더로 이동시키기 

# 서브폴더를 생성할 폴더명 설정
$backupFolder = "backup_zip"

# 만약 서브폴더가 존재하지 않으면 생성
if (-not (Test-Path $backupFolder)) {
    New-Item -ItemType Directory -Path $backupFolder | Out-Null
}

# 현재 폴더의 zip 파일들을 서브폴더로 이동
Get-ChildItem -Filter *.zip | Move-Item -Destination $backupFolder
```

## 3. Object 정보처리 
Powershell에서 명령어를 실행하면 Object 형태의 정보를 넘길 때가 있다.이 때 넘겨진 Object 정보를 출력 또는 관리하는 명령어는 다음과 같다. 

| 커맨드           | 사용법                                        |
| ------------- | ------------------------------------------ |
| Get-Member    | Object로 결과가 넘어왔다면 Object의 멤버필드와 메소드를 보여준다. |
| Where-Object  | 넘어온 Object에서 멤버필드(메소드)를 이용하여 비교            |
| Select-Object | 넘어온 Object를 선택하여 값을 가져오기                   |
| Sort-Object   | 객체를 정렬                                     |

```powershell
# 넘어온 결과의 Object 정보를 출력한다. 
Get-ChildItem | Get-Member

# 디렉토리 정보만 출력한다. 
$items = Get-ChildItem
$directories = $items | Where-Object { $_.PSIsContainer }
$directories

# 디렉토리 이름별로 Sorting 및  
Get-ChildItem | Sort-Object -Property Name | Select-Object -Last 5

```
## 4. process & internet
프로세스를 가져오기 또는 멈추기를 할 경우 사용하는 명령어와 Internet을 액세스할 때 사용하는 명령어 정리.

| 커맨드               | 사용법                                                                  |
| ----------------- | -------------------------------------------------------------------- |
| Get-Process       | 실행 중인 Process를 가져온다.                                                 |
| Stop-Process      | Process를 종료시킨다.<br><br>-Name은 이름으로 지정<br>-Id는 Id로 지정<br>-Force는 강제종료 |
| Invoke-WebRequest | 인터넷의 정보를 가져온다. 강력한 기능으로 curl의 역할을 대신한다.                              |

```powershell

# 프로세스를 title로 보여주기 
Get-Process | Where-Object {$_.mainWindowTitle} | Format-Table Id, Name, mainWindowtitle -AutoSize

# 프로세스를 종료하기 
notepad
$p = Get-Process -Name "notepad"
Stop-Process -InputObject $p

# 주소 내의 모든링크 가져오기 
(Invoke-WebRequest -Uri "http://vintageappmaker.com").Links.Href
```
## 5. 기타정보 

| 커맨드                                                         | 사용법                      |
| ----------------------------------------------------------- | ------------------------ |
| [System.Convert]::ToBase64String                            | 내용을 Base64String으로 변환한다. |
| (New-Object System.Net.WebClient).DownloadFile(웹주소, 저장할경로명) | 웹에서 파일 다운로드              |
| ii .                                                        | 현재 폴더를 기본으로 파일탐색기 열기     |
| \| set-clipboard                                            | 파이프로 넘어온 값을 클립보드로 복사한다.  |

```powershell
 
 # 이미지 File을 Base64로 변환해서 저장
 [System.Convert]::ToBase64String((get-content -Path .\example.jpg -AsByteStream -Raw)) >> base64cnvt.txt 
 
 # 웹에서 파일다운로드  
 (New-Object System.Net.WebClient).
DownloadFile("http://vintageappmaker.com/wp-content/uploads/2015/03/cropped-logo.png", "$pwd\down.png")

```
