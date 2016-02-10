echo %USERPROFILE%\AppData\Roaming\Microsoft\Windows\SendTo\shortcut

echo set WshShell = WScript.CreateObject("WScript.Shell") >shortcut.vbs
echo set oShellLink = WshShell.CreateShortcut(("%USERPROFILE%\AppData\Roaming\Microsoft\Windows\SendTo\mp4fromavi.batへのショートカット" ^& ".lnk")) >>shortcut.vbs
echo oShellLink.TargetPath = "%~dp0mp4fromavi.bat" >>shortcut.vbs
echo oShellLink.WindowStyle = 1 >>shortcut.vbs
echo oShellLink.Save >>shortcut.vbs
shortcut.vbs

echo set WshShell = WScript.CreateObject("WScript.Shell") >shortcut.vbs
echo set oShellLink = WshShell.CreateShortcut(("%USERPROFILE%\AppData\Roaming\Microsoft\Windows\SendTo\mp4fromavitd.batへのショートカット" ^& ".lnk")) >>shortcut.vbs
echo oShellLink.TargetPath = "%~dp0mp4fromavitd.bat" >>shortcut.vbs
echo oShellLink.WindowStyle = 1 >>shortcut.vbs
echo oShellLink.Save >>shortcut.vbs
shortcut.vbs

del shortcut.vbs
