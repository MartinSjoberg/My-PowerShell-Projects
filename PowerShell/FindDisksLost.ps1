# Not finished!
Get-Eventlog -log Application -computername server1.vt.net -after ((get-date).addDays(-3)) -EntryType Error, Warning -Message "*SQL*" | Select-Object TimeGenerated, MachineName, EventID, EntryType, Message, UserName | Out-GridView
