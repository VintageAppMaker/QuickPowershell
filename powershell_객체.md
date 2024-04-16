# 객체 

PowerShell은 .NET Framework의 객체 지향 프로그래밍 모델을 기반으로 하기 때문에 .NET Framework의 클래스와 메서드를 사용하여 개체를 생성하고 조작할 수 있다. 

- Property 위주의 객체 
```powershell
# 새로운 객체 생성
$car = New-Object -TypeName PSObject -Property @{
    Make = "Toyota"
    Model = "Camry"
    Year = 2022
}

# 객체 속성 출력
Write-Output "Car Make: $($car.Make)"
Write-Output "Car Model: $($car.Model)"
Write-Output "Car Year: $($car.Year)"
```

- C# Class 정의를 활용한 객체 

 Add-Type으로 C#의 Class를 정의하여 Powershell에서 사용할 수 있다. 
```powershell
# 클래스 정의
Add-Type @"
    using System;

    public class Calculator {
        public int Add(int num1, int num2) {
            return num1 + num2;
        }

        public int Subtract(int num1, int num2) {
            return num1 - num2;
        }
    }
"@

# Calculator 클래스의 인스턴스 생성
$calc = New-Object Calculator

# Add 메서드 호출
$resultAdd = $calc.Add(5, 3)
Write-Output "Addition Result: $resultAdd"

# Subtract 메서드 호출
$resultSubtract = $calc.Subtract(10, 3)
Write-Output "Subtraction Result: $resultSubtract"
```


- Add-Member를 사용하여 메소드를 추가하는 방법

아래 방법은 Add-Member를 활용하여 직접 함수를 구현하는 방법이다. 
```powershell
# 객체 생성
$person = New-Object -TypeName PSObject -Property @{
    Name = "John Doe"
    Age = 30
}

# 메서드 추가
$person | Add-Member -MemberType ScriptMethod -Name SayHello -Value {
    Write-Output "Hello, my name is $($this.Name)!"
}

# 메서드 호출
$person.SayHello()
```

아래 방법은 위와 동일하나 함수형 변수를 활용하여 가독성을 높이는 방법이다. 

```powershell
# 객체 생성
$car = New-Object -TypeName PSObject -Property @{
    Make = "Toyota"
    Model = "Camry"
    Year = 2022
}

# 함수형 변수로 사용할 메서드 정의
$driveMethod = {
    param($distance)
    Write-Output "Driving $distance kilometers."
}

# 메서드 추가
$car | Add-Member -MemberType ScriptMethod -Name Drive -Value $driveMethod

# 메서드 호출
$car.Drive(100)
```

