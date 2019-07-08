$server = $server + 'SERVER1

get-hotfix -computername $server | Where-Object { (Get-date($_.Installedon)) -gt (get-date).adddays(-3) } | 
    Sort-Object HotfixID -Descending | Out-Gridview
