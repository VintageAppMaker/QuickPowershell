Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Form 생성
$form = New-Object System.Windows.Forms.Form
$form.Text = "Event Handlers Example"
$form.Size = New-Object System.Drawing.Size(400, 300)

# Button
$button = New-Object System.Windows.Forms.Button
$button.Text = "Click Me"
$button.Location = New-Object System.Drawing.Point(10, 10)
$form.Controls.Add($button)

# TextBox
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10, 50)
$textBox.Width = 150
$form.Controls.Add($textBox)

# Button Click 핸들러
$button.Add_Click({
    [System.Windows.Forms.MessageBox]::Show("Button Clicked!", "Info", "OK", "Information")
})

# Form Shown Event 핸들러
$form.Add_Shown({
    [System.Windows.Forms.MessageBox]::Show("Form Shown!", "Info", "OK", "Information")
})

# Form Resize Event 핸들러 
$form.Add_Resize({
    [System.Windows.Forms.MessageBox]::Show("Form Resized!", "Info", "OK", "Information")
})

# TextBox TextChanged Event 핸들러  
$textBox.Add_TextChanged({
    [System.Windows.Forms.MessageBox]::Show("Text Changed!", "Info", "OK", "Information")
})

# Form 보이기 
$form.ShowDialog()
