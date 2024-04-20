Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Form 만들기
$form = New-Object System.Windows.Forms.Form
$form.Text = "Layout Example"
$form.Size = New-Object System.Drawing.Size(400, 400)

# Button 만들기  
$buttonFlowLayout1 = New-Object System.Windows.Forms.Button
$buttonFlowLayout1.Text = "1"
$buttonFlowLayout2 = New-Object System.Windows.Forms.Button
$buttonFlowLayout2.Text = "2"

$buttonTableLayout1 = New-Object System.Windows.Forms.Button
$buttonTableLayout1.Text = "1"
$buttonTableLayout2 = New-Object System.Windows.Forms.Button
$buttonTableLayout2.Text = "2"
$buttonTableLayout3 = New-Object System.Windows.Forms.Button
$buttonTableLayout3.Text = "3"


$buttonAnchorDock = New-Object System.Windows.Forms.Button
$buttonAnchorDock.Text = "Button 3 (Anchor/Dock)"

# FlowLayoutPanel 예제 
$flowLayoutPanel = New-Object System.Windows.Forms.FlowLayoutPanel
$flowLayoutPanel.FlowDirection = [System.Windows.Forms.FlowDirection]::TopDown
$flowLayoutPanel.Location = New-Object System.Drawing.Point(10, 10)
$flowLayoutPanel.Size = New-Object System.Drawing.Size(150, 250)
$flowLayoutPanel.Controls.Add($buttonFlowLayout1)
$flowLayoutPanel.Controls.Add($buttonFlowLayout2)

# TableLayoutPanel 예제 
$tableLayoutPanel = New-Object System.Windows.Forms.TableLayoutPanel
$tableLayoutPanel.Location = New-Object System.Drawing.Point(170, 10)
$tableLayoutPanel.Size = New-Object System.Drawing.Size(200, 250)
$tableLayoutPanel.ColumnCount = 2
$tableLayoutPanel.RowCount = 2
$tableLayoutPanel.ColumnStyles.Add((New-Object System.Windows.Forms.ColumnStyle([System.Windows.Forms.SizeType]::Percent, 50)))
$tableLayoutPanel.ColumnStyles.Add((New-Object System.Windows.Forms.ColumnStyle([System.Windows.Forms.SizeType]::Percent, 50)))
$tableLayoutPanel.Controls.Add($buttonTableLayout1, 0, 0)
$tableLayoutPanel.Controls.Add($buttonTableLayout2, 0, 1)
$tableLayoutPanel.Controls.Add($buttonTableLayout3, 1, 1)

# Anchor and Dock 예제 
$buttonAnchorDock.Anchor = [System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Left
$buttonAnchorDock.Dock = [System.Windows.Forms.DockStyle]::Bottom

# Form에 Layout 붙이기
$form.Controls.Add($flowLayoutPanel)
$form.Controls.Add($tableLayoutPanel)
$form.Controls.Add($buttonAnchorDock)

# Form 보이기 
$form.ShowDialog()