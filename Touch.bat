@echo off

REM Prompt for administrative privileges
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM Initialize the counter environment variable if not set
if "%COUNTER%"=="" set "COUNTER=0"

if %COUNTER%==0 (
    REM Run PowerShell command to enable the device
    powershell.exe -Command "Start-Process powershell.exe -ArgumentList '-Command ""Get-PnpDevice -FriendlyName ''HID-compliant touch screen'' | Enable-PnpDevice -Confirm:$false""' -Verb RunAs"
    set "COUNTER=1"
) else if %COUNTER%==1 (
    REM Run PowerShell command to disable the device
    powershell.exe -Command "Start-Process powershell.exe -ArgumentList '-Command ""Get-PnpDevice -FriendlyName ''HID-compliant touch screen'' | Disable-PnpDevice -Confirm:$false""' -Verb RunAs"
    set "COUNTER=0"
)

REM Save the updated counter value for the next run
setx COUNTER %COUNTER%
