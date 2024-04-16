# WMI  
WMI는 Windows Management Instrumentation의 약자로, Microsoft Windows 운영 체제에서 사용되는 강력한 관리 및 모니터링 도구이다.

- 시스템 및 네트워크 관리
- 보안 모니터링
- 이벤트 알림
- 자원 사용 추적 
 
등을 제공한다. 그런 점에서 Powershell에서 자주 사용하게 되는 기능이다. 특히 원격으로 자동화를 해야 하는 Windows Server 환경에서 많이 사용되고 있다. 


### 1. 시스템 정보

PC의 시스템 정보를 가져온다. 
~~~powershell
Get-WmiObject -Class Win32_ComputerSystem
~~~

### 2. **운영 체제 정보**

운영체제 정보를 가져온다. 
~~~powershell
Get-WmiObject -Class Win32_OperatingSystem
~~~

### 3. **하드웨어 정보**

하드웨어 정보를 가져온다. 
~~~powershell

# CPU(프로세서) 정보
Get-WmiObject -Class Win32_Processor

# 그래픽 카드 정보
Get-WmiObject -Class Win32_VideoController

# 시스템 보드 정보
Get-WmiObject -Class Win32_BaseBoard

# BIOS 정보
Get-WmiObject -Class Win32_BIOS

# 오디오 장치 정보
Get-WmiObject -Class Win32_SoundDevice

~~~

### 4. **서비스 정보**

서비스 정보를 가져온다. 
~~~powershell
Get-WmiObject -Class Win32_Service
~~~

### 5. **Network interface**

Network interface 정보를 가져온다. 
~~~powershell
# IP가 할당된 interface 정보를 가져온다.
Get-WmiObject -Class Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true }
~~~

### 6. **메모리 정보**

Ram 정보를 가져온다. 
~~~powershell
Get-WmiObject -Class Win32_PhysicalMemory
~~~

### 7. **디스크 공간**

물리적인 디스크 공간 정보를 가져온다. 
~~~powershell
Get-WmiObject -Class Win32_LogicalDisk
~~~



