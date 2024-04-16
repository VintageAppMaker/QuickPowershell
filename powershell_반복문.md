# 반복문 

PowerShell에서 반복문 사용법은 다음과 같다. 
### 1. foreach 문

foreach 문은 배열 또는 컬렉션의 각 요소에 대해 작업할 때 사용한다. 크게 배열을 기준으로 반복을 하거나 범위를 기준으로 반복을 한다. 

 ```powershell
$fruits = @("Apple", "Banana", "Cherry")

foreach ($fruit in $fruits) {
    Write-Output "Fruit: $fruit"
}
```

```powershell
foreach ($num in 1..5) {
    Write-Output "Number: $num"
}
```

### 2. for 문

for 문은 조건을 기반으로 특정 횟수만큼 반복할 때 사용

```powershell
for ($i = 1; $i -le 5; $i++) {
    Write-Output "Iteration: $i"
}
```

### 3. while 문과 do-while 문

while 문과 do-while 문은 조건이 true인 동안 반복한다. while문과 do-while문을 제공한다. 

-  while 문:

```powershell
$counter = 1
while ($counter -le 5) {
    Write-Output "Counter: $counter"
    $counter++
}
```

-  do-while 문:

```powershell
$counter = 1
do {
    Write-Output "Counter: $counter"
    $counter++
} while ($counter -le 5)
```

### 4. 반복문 제어

반복문에서 특정 조건에 따라 반복을 중지하거나 건너뛸 수 있다.

-  break 문:

```powershell
foreach ($num in 1..10) {
    if ($num -eq 6) {
        break  # 반복문 종료
    }
    Write-Output "Number: $num"
}
```

-  continue 문:

```powershell
foreach ($num in 1..5) {
    if ($num -eq 3) {
        continue  # 현재 반복 건너뛰기
    }
    Write-Output "Number: $num"
}
```
