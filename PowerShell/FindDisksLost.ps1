# One server 
Get-Eventlog -log System -computername server1 -Message "*has been surprise removed.*" | Out-GridView

# Multiple servers


