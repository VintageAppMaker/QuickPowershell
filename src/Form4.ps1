Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "Progress Example"
$form.Size = New-Object System.Drawing.Size(300, 150)

$progressBar = New-Object System.Windows.Forms.ProgressBar
$progressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous
$progressBar.Location = New-Object System.Drawing.Point(10, 10)
$progressBar.Size = New-Object System.Drawing.Size(250, 20)
$form.Controls.Add($progressBar)

$startButton = New-Object System.Windows.Forms.Button
$startButton.Text = "Start"
$startButton.Location = New-Object System.Drawing.Point(10, 50)
$form.Controls.Add($startButton)

$startButton.Add_Click({
    $progressBar.Value = 0  # 진행 막대 초기화
    $maxValue = 100  # 최대 진행 값 설정
    for ($i = 1; $i -le $maxValue; $i++) {
        $progressBar.Value = $i
        Start-Sleep -Milliseconds 50  # 작업 시뮬레이션을 위한 잠시 대기
    }
    [System.Windows.Forms.MessageBox]::Show("Task completed!", "Info", "OK", "Information")
})

$form.ShowDialog()
