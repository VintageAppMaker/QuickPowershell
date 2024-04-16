# 조건문

PowerShell에서 조건문을 사용하는 방법은 다른 프로그래밍 언어와 같다. 
### 1. `if` 문 사용하기

```powershell
$number = 10

if ($number -gt 0) {
    Write-Host "$number is positive"
}
```

### 2. `if`-`else` 문 사용하기

```powershell
$number = -5

if ($number -gt 0) {
    Write-Host "$number is positive"
} else {
    Write-Host "$number is non-positive"
}
```

### 3. `if`-`elseif`-`else` 문 사용하기

```powershell
$grade = 85

if ($grade -ge 90) {
    Write-Host "Grade: A"
} elseif ($grade -ge 80) {
    Write-Host "Grade: B"
} elseif ($grade -ge 70) {
    Write-Host "Grade: C"
} else {
    Write-Host "Grade: D"
}
```

### 4. `switch` 문 사용하기

```powershell
$fruit = "apple"

switch ($fruit) {
    "apple" {
        Write-Host "It's an apple"
    }
    "banana" {
        Write-Host "It's a banana"
    }
    default {
        Write-Host "Unknown fruit"
    }
}
```

### 5. 산술 비교 연산자

* `-eq`: 값이 같은지 비교
* `-ne`: 값이 다른지 비교
* `-gt`: 왼쪽 값이 오른쪽 값보다 큰지 비교
* `-lt`: 왼쪽 값이 오른쪽 값보다 작은지 비교
* `-ge`: 왼쪽 값이 오른쪽 값보다 크거나 같은지 비교
* `-le`: 왼쪽 값이 오른쪽 값보다 작거나 같은지 비교

```powershell
$number1 = 10
$number2 = 5

if ($number1 -gt $number2) {
    Write-Host "number1이 number2보다 크다"
}
```

### 6. 논리 연산자

* `-and`: 논리 AND 연산자로, 양쪽 모두가 참일 때 참을 반환
* `-or`: 논리 OR 연산자로, 어느 한 쪽이라도 참이면 참을 반환
* `-not`: 논리 NOT 연산자로, 뒤에 오는 조건을 부정

```powershell
$age = 25
$hasLicense = $true

if ($age -ge 18 -and $hasLicense) {
    Write-Host "투표권한이 있습니다"
}
```

### 3. 문자열 비교 연산자

* `-eq`: 문자열이 완전히 일치하는지 비교
* `-ne`: 문자열이 일치하지 않는지 비교
* `-like`: 와일드카드 패턴을 사용하여 문자열을 비교
* `-notlike`: 와일드카드 패턴을 사용하여 문자열을 부정적으로 비교

```powershell
$name1 = "Ninja"
$name2 = "닌자"

if ($name1 -eq $name2) {
    Write-Host "이름이 같다"
} else {
    Write-Host "이름이 틀리다"
}
```
