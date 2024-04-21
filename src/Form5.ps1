Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$xmlFilePath = "$pwd\mainwindow.xml"
$xml = [xml](Get-Content $xmlFilePath)

$form = New-Object System.Windows.Forms.Form
$form.Text = "Design from XML"
$form.Size = New-Object System.Drawing.Size(300, 200)

function ButtonClickHandler {
    [System.Windows.Forms.MessageBox]::Show("Click!", "Info", "OK", "Information")
}

# Field와 값을 파싱해야 한다. 
# 필요할 때마다 추가해야 한다. 
foreach ($element in $xml.GuiElements.ChildNodes) {
    $controlType = $element.Name
    $control = New-Object System.Windows.Forms.$controlType
    foreach ($attr in $element.Attributes) {
        $propertyName = $attr.Name
        $propertyValue = $attr.Value
        if ($propertyName -eq "Text") {
            $control.Text = $propertyValue
        } elseif ($propertyName -eq "X") {
            $control.Location = New-Object System.Drawing.Point($propertyValue, $control.Location.Y)
        } elseif ($propertyName -eq "Y") {
            $control.Location = New-Object System.Drawing.Point($control.Location.X, $propertyValue)
        } elseif ($propertyName -eq "Handler") {
            $handlerFunction = $propertyValue
        } else {
            $control.$propertyName = $propertyValue
        }
    }

    if ($controlType -eq "Button" -and $handlerFunction) {
        $handlerScriptBlock = [ScriptBlock]::Create("`& $handlerFunction")
        $control.Add_Click($handlerScriptBlock)
    }

    $form.Controls.Add($control)
}


# Show Form
$form.ShowDialog()
