# Powershell은 
# C#을 사용할 수 있기에 Windows.Forms를 활용할 수 있다. 

# 1. Form을 생성한다. Caption을 지정한다. 
Add-Type -AssemblyName System.Windows.Forms
$form = New-Object System.Windows.Forms.Form
$form.Text = "from C# Forms"

# 2. Button을 만들고 이벤트 핸들러를 추가한다. 
# Form에 Button을 위치 설정 및 추가한다. 
$button = New-Object System.Windows.Forms.Button
$button.Text = "Click!!"
$button.Add_Click({ Write-Host "Button Clicked!" })
$button.Location = New-Object System.Drawing.Point(10, 10)
$form.Controls.Add($button)

# 3. Label을 생성하고 문자열을 설정한다. 
# Form에 Label을 위치 설정 및 추가한다.  
$label = New-Object System.Windows.Forms.Label
$label.Text = "Hello, 파워쉘"
$label.Location = New-Object System.Drawing.Point(10, 40)
$form.Controls.Add($label)

# 4. TextBox를 생성하고 문자열을 설정한다. 
# Form에 TextBox를 위치 설정 및 추가한다.  
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Text = "입력하세요"
$textBox.Location = New-Object System.Drawing.Point(10, 70)
$form.Controls.Add($textBox)

# 5. ComboBox를 생성하고 문자열을 설정한다. 
# Form에 ComboBox를 위치 설정 및 추가한다.  
$comboBox = New-Object System.Windows.Forms.ComboBox
$comboBox.Items.AddRange(@("1", "2", "3"))
$comboBox.Location = New-Object System.Drawing.Point(10, 100)
$form.Controls.Add($comboBox)

# 6. CheckBox를 생성하고 문자열을 설정한다. 
# Form에 CheckBox를 위치 설정 및 추가한다.  
$checkBox = New-Object System.Windows.Forms.CheckBox
$checkBox.Text = "체크할 것인가?"
$checkBox.width = 300
$checkBox.Location = New-Object System.Drawing.Point(10, 150)
$form.Controls.Add($checkBox)

# Form을 보여준다. 
$form.ShowDialog()