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

echo AVISource("%~1") 1>%AVSFILE%
if not "%2" == ""  echo TextsubMod("%~2") 1>>%AVSFILE%
echo return last 1>>%AVSFILE%

%CMDAVSWAV% %AVSFILE% %TMPAUDIOWAVFILE%

%CMDX264% -q %VIDEOQUALITY% --threads auto --output %TMPVIDEONOAUDIOFILE%  %AVSFILE%
%CMDAACENC% -q %AUDIOQUALITY% -ignorelength -if %TMPAUDIOWAVFILE% -of %TMPAUDIOM4AFILE%
%CMDMP4BOX% -add %TMPVIDEONOAUDIOFILE% -add %TMPAUDIOM4AFILE% -new %VIDEOFINISHFILE%
del %AVSFILE%
del %TMPAUDIOWAVFILE%
del %TMPAUDIOM4AFILE%
del %TMPVIDEONOAUDIOFILE%

echo エンコード完了！！！
pause
