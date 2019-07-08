# ========================================================
#
# Script Information
# Title: BackupFiles.ps1 - This is subject to change to make it more general.
# Version: 0.99
# Author: Martin Sjöberg
# Originally created: 20120917
# Description: Copies files from source to destination with robocopy and send email depending on outcome. Also deletes files and folders from source older than definable threshold.
# Known issues: If the user running the script doesn't have rights to delete the folder/files that should be deleted according to retentiontime the script hangs :-/ Workaround: give user more rights, or set retentiontime to 0.
# 
# ========================================================

<#### Config ####>
# Import info about sourcepath, destinationpath and retentiontime
$CSVFile = Import-Csv "BackupFiles.csv"
$LogFilePath = ".\"
$From = "guldhjartats@hotmail.com"
$To = "guldhjartats@hotmail.com"
$SMTPServer = "smtp.empir.se"
$SMTPPort = "25"
<#### End Config ####>

<#### Predefined ####>
$TimeStamp = get-date -uformat "%Y-%m%-%d"
$Logfile = "$($LogFilePath)Robocopy_$TimeStamp.log"

$EmailBody = "Robocopy Successfull!"
$EmailSubject = "Robocopy Successfull!"
$nl = [string]"
"

$FinalStatus = 0
$MSGType=@{
"16"="Error"
"8"="Error"
"4"="Warning"
"2"="Information"
"1"="Information"
"0"="Information"
}
$msg=@{
"16"="serious error. robocopy did not copy any files.`n
examine the output log: robocopy_$logfile_$timestamp.log"
"8"="some files or directories could not be copied (copy errors occurred and the retry limit was exceeded).`n
check these errors further: robocopy_$logfile_$timestamp.log"
"4"="some mismatched files or directories were detected.`n
examine the output log: robocopy_$logfile_$timestamp.log.`
housekeeping is probably necessary."
"2"="some extra files or directories were detected and removed in $path.destination.`n
check the output log for details: robocopy_$logfile_$timestamp.log"
"1"="new files from $source copied to $path.destination.`n
check the output log for details: robocopy_$logfile_$timestamp.log"
"0"="$source and $destination in sync. no files copied.`n
check the output log for details: robocopy_$logfile_$timestamp.log"
}
<#### End Predefined ####>

$SmtpClient = new-object system.net.mail.smtpClient 
$mailmessage = New-Object system.net.mail.mailmessage
$SmtpClient.Host = $SmtpServer #, $SMTPPort
$mailmessage.from = $From
$mailmessage.To.add("$To")

# Code starts here
foreach($path in $CSVFile){
    # Robocopy all files - Question: is running robocopy terminating error? Investigate!
    robocopy $path.Source $path.Destination /MT:10 /R:5 /E /Z /LOG+:$Logfile
    $ExitCode = $LastExitCode
    # Write-Host $ExitCode

    if ( $ExitCode -gt 3 )
    {
     $FinalStatus = 1

     $EmailSubject = "Robocopy Error! Copy of files failed"
     $EmailBody = "Robocopy Error!! {0}{0}{1}{0}{2}{0}Source: {3}{0}Destination: {4}" -f $nl, $MSGType["$ExitCode"], $MSG["$ExitCode"], $path.Source, $path.Destination
     $mailmessage.Subject = $EmailSubject
     $MailMessage.IsBodyHtml = $False
     $mailmessage.Body = $EmailBody
     $smtpclient.Send($mailmessage)
     }

    # delete old files and old directories that are empty, recursive and only if copy was succesfull!
    if ( 0,1,2,3 -contains $exitcode -and $path.SourceRetentionTime -gt 0 )
    {
     #  $path.Source $path.SourceRetentionTime
            $errorFile = Get-ChildItem $path.Source -recurse | Where {
                !$_.PSIsContainer -and $_.LastWriteTime -lt (get-date).AddDays( -$path.SourceRetentionTime )
            } | Remove-Item -ErrorAction silentlycontinue #-whatif

        if ( $errorFile ) {
        # send email with info about what files that was impossible to delete
            $FinalStatus = 1
            
            $EmailSubject = "Powershell Error! Recursive deletion of files older than $($path.SourceRetentionTime) have failed."
            $EmailBody = "Powershell Error!! Source: $($path.Source)"
            $mailmessage.Subject = $EmailSubject
            $MailMessage.IsBodyHtml = $False
            $mailmessage.Body = $EmailBody
            $smtpclient.Send($mailmessage)
        }

            $errorFolder = Get-ChildItem $path.Source -recurse | Where {
                $_.PSIsContainer -and @(Get-ChildItem -Lit $_.Fullname -r | Where {
                                                                                !$_.PSIsContainer
                                                                                }).Length -eq 0 -and $_.LastWriteTime -lt (get-date).AddDays(-$path.SourceRetentionTime)
            } |Remove-Item -recurse -ErrorAction silentlycontinue #-whatif

        if ( $errorFolder )  {
        # Send email with info about what folder that was not possible to delete
            $FinalStatus = 1

            $EmailSubject = "Powershell Error! Recursive deletion of folders older than $($path.SourceRetentionTime) have failed."
            $EmailBody = "Powershell Error!! Source: $($path.Source)"
            $mailmessage.Subject = $EmailSubject
            $MailMessage.IsBodyHtml = $False
            $mailmessage.Body = $EmailBody
            $smtpclient.Send($mailmessage)
        }
    }
}

# send mail if all copies successful
if ($FinalStatus -eq 0)
{
    $mailmessage.Subject = $EmailSubject
    $MailMessage.IsBodyHtml = $False 
    $mailmessage.Body = $EmailBody 
    $smtpclient.Send($mailmessage)
}
