# 함수 

PowerShell에서 함수는 특정 작업을 수행하는 코드 블록을 정의하는 데 사용된다. 함수를 정의하려면 `function` 키워드를 사용한다. 

### 1. 기본함수 정의 및 사용
 
```powershell
function Get-Total {
    param(
        [int]$num1,
        [int]$num2
    )
    
    $total = $num1 + $num2
    return $total
}

$result = Get-Total -num1 5 -num2 10
Write-Output "Total: $result"
```

위의 예제에서 `Get-Total` 함수는 두 숫자를 받아서 그 합계를 반환하는 함수이다. `param` 키워드를 사용하여 함수에 전달되는 매개변수를 정의하고 변수 앞의 []는 데이터 형을 지정한다(반드시 지정할 필요는 없다). return 값은 return 명령어를 통해 전달한다. 

### 2. 함수형 변수
함수형 변수는 프로그래밍에서 자주 사용하는 기법이다. 동적함수 처리를 하기 위해서는 함수형 변수가 필수이기 때문이다. 

| 문법                                | 내용        |
| --------------------------------- | --------- |
| `$functionVariable = { <함수 내용> }` | 함수형 변수 선언 |
| `&$함수형변수`                         | 함수형 변수 실행 |

```powershell
$addFunction = {
    param($num1, $num2)
    $num1 + $num2
}

$result = &$addFunction 5 10
Write-Output "Result: $result"
```

### 3. 고차 함수 

고차 함수는 다른 함수를 인자로 받거나 함수를 반환하는 함수이다. PowerShell에서는 이러한 기능을 활용하여 함수형 프로그래밍을 할 수 있다.

```powershell
# 고차 함수 예제: 함수를 인자로 받는 함수
$applyOperation = {
    param($operation, $num1, $num2)
    &$operation $num1 $num2
}

$add = { param($a, $b) $a + $b }
$resultAdd = &$applyOperation $add 5 3
Write-Output "Addition Result: $resultAdd"
```

함수형 변수를 사용하면 코드를 모듈화하고 재사용 가능한 단위로 분리하여 작성할 수 있다. 이는 코드의 가독성과 유지보수성을 높이는 데 도움이 된다.
