# 나만의 cmdlet & 모듈
나만의 cmdlet을 만드는 것은 `기본적으로 함수를 만들고 사용하는 것`이다. 크게 ps1 소스를 가져오는 방법과 모듈을 만들어 함수를 가져오는 방법이 존재한다. 차이점은 (1) import를 사용하여 모듈을 가져오는 방법과 (2) . 연산자를 사용하여 소스를 가져오는 방법의 차이가 있다. 간편한 방식을 원한다면 . 연산자를 활용하는 것이 좋다. 

### 1. cmdlet 만들기(모듈)
나만의 cmdlet을 만들어 Import-Module을 호출하여 사용할 수 있다. 

| 순서  | 명령어                               | 설명                                                                                                                                                                                         |
| --- | --------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 1   | 폴더 만들기<br>(mkdir, New-Item)       | 특정 폴더를 만든다.<br>.psd1 파일과 .psm1 파일을 저장할 곳이다                                                                                                                                                 |
| 2   | 매니페이스 만들기<br>(New-ModuleManifest) | 매니페스트 파일을 만든다(Option). <br>모듈에 대한 정보를 저장하는 파일이다.<br><br>-RootModule : .psm1 파일(함수정의)<br>-Author : 작성자<br>-Description : 설명<br>-PowerShellVersion : 타겟 파워셀 버전<br>-ModuleVersion : 작성한 모듈 버전 |
| 3   | 파일 만들기<br>(New-Item)              | 모듈 스크립트 파일을 만든다. <br>`cmdlet은 함수로 정의`한다.                                                                                                                                                   |

위의 순서로 다음과 같은 예제를 만들 수 있다. 

1. **모듈 프로젝트 디렉토리 만들기**

```plaintext
New-Item -Type Directory -Path C:\MyModule
```

2. **모듈 매니페스트 파일 만들기**

일반적으로 모듈 경로명과 동일하다. 
```plaintext
New-ModuleManifest -Path C:\MyModule\MyModule.psd1 -RootModule MyModule.psm1 -Author "me" -Description "first module" -PowerShellVersion "5.1" -ModuleVersion "1.0"
```

3. **모듈 스크립트 파일 만들기**
   
일반적으로 모듈 경로명과 동일하다 
```plaintext
New-Item -Type File -Path C:\MyModule\MyModule.psm1
```

```plaintext
# MyModule.psm1 파일 내용
function Invoke-Message {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Message
    )

    Write-Output "your message: $Message"
}
```

4. **모듈 로드 및 사용**:

시스템 모듈 폴더에서 정의했다면 Module 이름만으로도 import 가능하다. 그러나 그 외의 경우라면 전체 경로명과 파일이름까지 서술해야 한다.

```plaintext
# 모듈 로드
Import-Module C:\MyModule\MyModule.psd1

# cmdlet 사용
Invoke-Message -Message "Hi!"
```

### 2. `.` 연산자로 가져오기(소스)

. 연산자를 이용하면 다른 소스(.ps1)의 함수나 변수를 가져올 수 있다.

```plaintext
# OtherScript.ps1
function Show-Notice {
    Write-Output "Notice: OOOOOO "
}
```

다음과 같이 해당 함수를 불러와서 호출할 수 있습니다:

```plaintext
. C:\Path\To\OtherScript.ps1

Show-Notice
```
