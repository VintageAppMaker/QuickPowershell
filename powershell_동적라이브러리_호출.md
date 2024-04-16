# 동적 라이브러리 호출


### 1. Add-Type의 MemberDefinition 사용

Namespace에 Type(메소드)을 추가하는 방식. 

| 구성 요소                  | 설명                                            |
| ---------------------- | --------------------------------------------- |
| `Add-Type`             | 외부 DLL을 PowerShell 세션에 추가하는 데 사용              |
| `-Name`                | 추가하는 타입의 이름을 지정                               |
| `-Namespace`           | 추가하는 타입의 네임스페이스를 지정                           |
| `-MemberDefinition`    | 추가하는 타입의 멤버를 정의하는 문자열을 지정 `(C# 문법)`           |
| `DllImport("DLL 이름")`  | 외부 DLL의 이름을 지정하여 해당 DLL의 함수를 호출               |
| `CharSet`              | 문자 집합을 지정                                     |
| `public static extern` | C#에서 함수를 정의할 때 사용되며, 외부 DLL의 함수를 정의하는 데 필요하다. |
```powershell
# user32.dll을 불러옵니다.
Add-Type -Name "User32" -Namespace "Win32" -MemberDefinition @"
[DllImport("user32.dll", CharSet = CharSet.Unicode)]
public static extern int MessageBox(int hWnd, String text, String caption, uint type);
"@

# MessageBox 함수를 호출하고 반환 값을 변수에 저장합니다.
$result = [Win32.User32]::MessageBox(0, "안녕하세요!", "알림", 0)

# 반환 값을 확인합니다. (1은 OK를 의미합니다)
if ($result -eq 1) {
    Write-Host "사용자가 OK를 클릭했습니다."
} else {
    Write-Host "메시지 박스 호출 중 오류가 발생했습니다."
}
```

### 2. Add-Type의 TypeDefinition 사용

Powershell에서 dll 호출은 c#의 소스코드로 재정의 가능하다. 그런 점에서 C#을 이해(또는 java)한 사용자라면 `TypeDefinition로 Class를 정의하여 사용하기`를 권한다. 개발자 입장에서 보다 가독성이 뛰어나고 간편하기 때문이다. 

```powershell
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class User32
{
    [DllImport("user32.dll", CharSet = CharSet.Unicode)]
    public static extern int MessageBox(int hWnd, string text, string caption, uint type);
}
"@

# PowerShell 함수를 정의하여 MessageBox를 호출하고 결과를 처리합니다.
function Show-MessageBox {
    $result = [User32]::MessageBox(0, "안녕하세요!", "알림", 0)

    if ($result -eq 1) {
        Write-Host "사용자가 OK를 클릭했습니다."
    } else {
        Write-Host "메시지 박스 호출 중 오류가 발생했습니다."
    }
}

# 함수를 호출하여 실행합니다.
Show-MessageBox

```

### 3. Linux에서 .so 호출

1. **C 코드 작성**
     
```c
// sayhello.c
#include <stdio.h>
    
void sayhello(char *name) {
    printf("Hello, %s!\n", name);
}
```
    
2. **gcc를 사용하여 컴파일**
     
```bash
gcc -shared -o mylib.so -fPIC sayhello.c
```
    
3. **PowerShell에서 호출**
    
```powershell
# mylib.so를 로딩
$code = @"
    using System;
    using System.Runtime.InteropServices;
    
    public class MyLibrary {
        [DllImport("mylib.so")]
        public static extern void sayhello(string name);
    }
"@
    
# C# 코드를 컴파일하여 사용
Add-Type -TypeDefinition $code
    
# 함수를 호출
[MyLibrary]::sayhello("World")
```
