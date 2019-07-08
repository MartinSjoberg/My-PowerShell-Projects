# Connect vcenter  SNAPSHOT 2
Connect-VIServer vcenter

# Skapa snapshot
New-Snapshot -VM server -Name MSSnap2 -RunAsync -Description 'MS took this snapshot'

Disconnect-VIServer
