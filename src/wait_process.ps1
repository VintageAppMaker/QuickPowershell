$p = Get-Process notepad.exe
Wait-Process -Id $p.id
Wait-Process -Name "notepad"
Wait-Process -InputObject $p