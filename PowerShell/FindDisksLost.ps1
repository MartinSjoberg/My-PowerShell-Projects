# One server 
Get-Eventlog -log System -computername server1 -Message "*has been surprise removed.*" | Out-GridView

# One server faster!
Get-WinEvent -computername server1 -FilterHashTable @{ LogName = "System"; ID = 157 }

# Multiple servers


