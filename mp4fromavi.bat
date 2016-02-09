@echo off
set VIDEOQUALITY=24
set AUDIOQUALITY=0.95

set AVSFILE="%~dpn1.avs"
set TMPAUDIOWAVFILE="%~dpn1.wav"
set TMPAUDIOM4AFILE="%~dpn1.m4a"
set TMPVIDEONOAUDIOFILE="%~dpn1_noaudio.mp4"
set VIDEOFINISHFILE="%~dpn1.mp4"

set CMDAVSWAV="%~dp0\avs2wav32.exe"
set CMDX264="%~dp0\x264.2665.x86.exe"
set CMDAACENC="%~dp0\neroAacEnc.exe"
set CMDMP4BOX="%~dp0\MP4Box.exe"


if "%~x1" == ".avi" (
  call :aviread "%~1"
) else (
  call :dsread "%~1"
)
if not "%2" == "" (
  if "%~x2" == ".ass" (
    call :assread2 "%~2"
  )
)

echo return last 1>>%AVSFILE%


%CMDAVSWAV% %AVSFILE% %TMPAUDIOWAVFILE%
%CMDX264% -q %VIDEOQUALITY% --threads auto --output %TMPVIDEONOAUDIOFILE%  %AVSFILE%
%CMDAACENC% -q %AUDIOQUALITY% -ignorelength -if %TMPAUDIOWAVFILE% -of %TMPAUDIOM4AFILE%
set COUNT=1
call :get_extension %VIDEOFINISHFILE%
set EXT=%extension%
set FINFILE=%filebody%
IF EXIST %VIDEOFINISHFILE% (
    call :setvideofinishfile "%FINFILE%(%COUNT%)%EXT%"
)
%CMDMP4BOX% -add %TMPVIDEONOAUDIOFILE% -add %TMPAUDIOM4AFILE% -new %VIDEOFINISHFILE%
del %AVSFILE%
del %TMPAUDIOWAVFILE%
del %TMPAUDIOM4AFILE%
del %TMPVIDEONOAUDIOFILE%

echo エンコード完了！！！
pause
exit

:aviread
echo AVISource("%~1") 1>%AVSFILE%
exit /b

:dsread
echo DirectShowSource("%~1") 1>%AVSFILE%
exit /b

:assread2
echo TextsubMod("%~1") 1>>%AVSFILE%
exit /b

:setvideofinishfile
set VIDEOFINISHFILE="%FINFILE%(%COUNT%)%EXT%"
exit /b


:get_extension
set extension=%~x1
rem set extension=%extension:~1%
set filebody=%~dpn1
rem set filebody=%filebody:~1%
exit /b

