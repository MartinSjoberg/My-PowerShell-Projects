# Connect vcenter  SNAPSHOT 2
Connect-VIServer vcenter01.vt.net

# Skapa snapshot
New-Snapshot -VM server1412 -Name MSSnap2 -RunAsync -Description 'MS took this snapshot 2'
New-Snapshot -VM server1413 -Name MSSnap2 -RunAsync -Description 'MS took this snapshot 2'
New-Snapshot -VM server1414 -Name MSSnap2 -RunAsync -Description 'MS took this snapshot 2'
New-Snapshot -VM server1415 -Name MSSnap2 -RunAsync -Description 'MS took this snapshot 2'
New-Snapshot -VM server1416 -Name MSSnap2 -RunAsync -Description 'MS took this snapshot 2'
New-Snapshot -VM server1417 -Name MSSnap2 -RunAsync -Description 'MS took this snapshot 2'
New-Snapshot -VM server1418 -Name MSSnap2 -RunAsync -Description 'MS took this snapshot 2'

Disconnect-VIServer
