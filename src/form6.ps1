Add-Type -AssemblyName PresentationFramework

$xamlPath = "$pwd\main.xaml"
$xmlContent = Get-Content $xamlPath
$reader = [System.Xml.XmlReader]::Create([System.IO.StringReader]::new($xmlContent))
$window = [Windows.Markup.XamlReader]::Load($reader)

# Find Button Control
$button = $window.FindName("button")

$handler = {
    [System.Windows.MessageBox]::Show("Clicked!", "", [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Information)
}

# Add Click Event Handler to Button
$button.Add_Click($handler)

# Show Window
$window.ShowDialog() | Out-Null

