# Package & Module  
Powershell은 다른 Shell Programming보다 강력한 패키지와 모듈을 제공하고 있다. powershell Gallery라는 마켓까지 지원하고 있으므로 확장성은 비교우위를 가지고 있다. 

### 1. PowerShell Gallery 패키지 설치
Install-Module을 실행하면 PowerShell Gallery에서 자료를 다운로드 받는다. 그렇게 하기 위해서는 종종 `PowerShell을 관리자 권한으로 실행`해야 할 때가 있다.  

- 설치 

```powershell
Install-Module -Name <모듈이름>
```

- 설치된 Package를 보는 법

```powershell
Get-PackageProvider -ListAvailable
```

### 2. 설치된 모듈 사용하기

Import-Module을 사용하여 모듈의 기능을 사용할 수 있다.

```powershell
Import-Module -Name <모듈이름>
```

