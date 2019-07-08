# Connect vcenter  SNAPSHOT 2
Connect-VIServer vcenter01

# Skapa snapshot
New-Snapshot -VM serverVM -Name MSSnap2 -RunAsync -Description 'MS took this snapshot'


Disconnect-VIServer
