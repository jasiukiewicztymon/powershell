Set-Variable -name bar -Option ReadOnly -value "example value"
Write-Host $bar
Remove-Variable bar -Force
Set-Variable -name bar -Option ReadOnly -value "example"
Write-Host $bar
