# 기초정보

- 변수는 `$`, 주석은 `#`
- 강력한 프로그래밍 도구(내장함수, 패키지, ise 등등) 제공
- C#과 연동되는 스크립트 언어
- .ps1 파일에서 한글처리 시 반드시 UTF-8 BOM 형식으로 저장되어야 함

# 자료형

| 자료형    | 설명                             | 예제                             |
| ------ | ------------------------------ | ------------------------------ |
| 문자열    | 텍스트 데이터를 나타내는 자료형              | `$str = "Hello, PowerShell!"`  |
| 정수     | 소수점 없는 숫자를 나타내는 자료형            | `$int = 10`                    |
| 부동 소수점 | 소수점을 포함하는 숫자를 나타내는 자료형         | `$float = 3.14`                |
| 불리언    | 참(True) 또는 거짓(False)을 나타내는 자료형 | `$bool = $true`                |
| 배열     | 여러 개의 값을 담을 수 있는 자료형           | `$arr = @(1, 2, 3, 4)`         |
| 해시 테이블 | 키-값 쌍을 담을 수 있는 자료형             | `$hash = @{ "name" = "John" }` |
| 날짜/시간  | 날짜와 시간 정보를 나타내는 자료형            | `$date = Get-Date`             |
| 객체     | 속성과 메서드를 가진 복합적인 자료형           | `$obj = New-Object PSObject`   |
| 스트림    | 입력 및 출력 데이터를 다루는 자료형           | `$stream = [System.IO.Stream]` |

1. **문자열(String)**
    
    * 설명: 텍스트 데이터를 나타내는 자료형
    * 예제: `$str = "Hello, PowerShell!"`
2. **정수(Integer)**
    
    * 설명: 소수점 없는 숫자를 나타내는 자료형
    * 예제: `$int = 10`
3. **부동 소수점(Float)**
    
    * 설명: 소수점을 포함하는 숫자를 나타내는 자료형
    * 예제: `$float = 3.14`
4. **불리언(Boolean)**
    
    * 설명: 참(True) 또는 거짓(False)을 나타내는 자료형
    * 예제: `$bool = $true`
5. **배열(Array)**
    
    * 설명: 여러 개의 값을 담을 수 있는 자료형
    * 예제: `$arr = @(1, 2, 3, 4)`
6. **해시 테이블(Hashtable)**
    
    * 설명: 키-값 쌍을 담을 수 있는 자료형
    * 예제: `$hash = @{ "name" = "John" }`
7. **날짜/시간(DateTime)**
    
    * 설명: 날짜와 시간 정보를 나타내는 자료형
    * 예제: `$date = Get-Date`
8. **객체(Object)**
    
    * 설명: 속성과 메서드를 가진 복합적인 자료형
    * 예제: `$obj = New-Object PSObject`
9. **스트림(Stream)**
    
    * 설명: 입력 및 출력 데이터를 다루는 자료형
    * 예제: `$stream = [System.IO.Stream]`
