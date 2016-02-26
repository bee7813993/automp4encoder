@echo off
SET ARGV=%*

setlocal enabledelayedexpansion
CALL :PARSE_ARGV
IF ERRORLEVEL 1 (
    ECHO Cannot parse arguments
    ENDLOCAL
    EXIT /B 1
)


set VIDEOQUALITY=24
set AUDIOQUALITY=0.95

set TMPAUDIOWAVFILE="%~dpn1.wav"
set TMPAUDIOM4AFILE="%~dpn1.m4a"
set TMPVIDEONOAUDIOFILE="%~dpn1_noaudio.mp4"

set CMDAVSWAV="%~dp0\avs2wav32.exe"
set CMDX264="%~dp0\x264.2665.x86.exe"
set CMDAACENC="%~dp0\neroAacEnc.exe"
set CMDMP4BOX="%~dp0\MP4Box.exe"


set MOVIEINDEX=0
set ASSINDEX=0

FOR /L %%i IN (1,1,!ARGC!) DO (
  call :check_filekind !ARG%%iQ!

)

if not '%MOVIEFILE%' == '' (
  call :movieread %MOVIEFILE%
) else (
  echo �n���ꂽ�t�@�C���ɓ���t�@�C��������܂���ł����B�I�����܂��B
  pause
  exit /b
)

set /a ASSCOUNT=!ASSINDEX!-1
FOR /L %%L IN (0,1,!ASSCOUNT!) DO (
set fn=!ASSFILE[%%L]!
call :assread2 !fn!
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

echo �G���R�[�h�����I�I�I
pause
exit


:movieread
set AVSFILE="%~dpn1_ame.avs"
if "%~x1" == ".avi" (
  call :aviread "%~1"
) else if "%~x1" == ".avs" (
  call :avsread "%~1"
) else (
  call :dsread "%~1"
)
set VIDEOFINISHFILE="%~dpn1.mp4"
exit /b


:aviread
echo DirectShowSource(%*) 1>%AVSFILE%
exit /b

:dsread
echo DirectShowSource(%*) 1>%AVSFILE%
exit /b

:avsread
echo Import(%*) 1>%AVSFILE%
exit /b

:assread2
echo TextsubMod(%*) 1>>%AVSFILE%
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

:check_filekind
if "%~x1" == ".ass" (
  set ASSFILE[!ASSINDEX!]="%~1"
  set /a ASSINDEX=!ASSINDEX!+1
)else if "%~x1" == ".avi" (
  if "%MOVIEINDEX%" == "0" (
    set MOVIEFILE="%~1"
    set /a MOVIEINDEX=!MOVIEINDEX!+1
  )
) else (
  if "%MOVIEINDEX%" == "0" (
    set MOVIEFILE="%~1"
    set /a MOVIEINDEX=!MOVIEINDEX!+1
  )
)
exit /b


:PARSE_ARGV
    SET ARGV=.!ARGV!
    SET PARSE_ARGV_ARG=[]
    SET PARSE_ARGV_END=FALSE
    SET PARSE_ARGV_INSIDE_QUOTES=FALSE
    SET /A ARGC = 0
    SET /A PARSE_ARGV_INDEX=1
     
    :PARSE_ARGV_LOOP
        REM �����̕������擪����1�������`�F�b�N����
        CALL :PARSE_ARGV_CHAR !PARSE_ARGV_INDEX! "%%ARGV:~!PARSE_ARGV_INDEX!,1%%"
        IF ERRORLEVEL 1 (
            EXIT /B 1
        )
        IF !PARSE_ARGV_END! == TRUE (
            EXIT /B 0
        )
        SET /A PARSE_ARGV_INDEX=!PARSE_ARGV_INDEX! + 1
        GOTO :PARSE_ARGV_LOOP
     
    :PARSE_ARGV_CHAR
        REM �_�u���N�H�[�g�J�n�I������
        IF ^%~2 == ^" (
            SET PARSE_ARGV_END=FALSE
            SET PARSE_ARGV_ARG=.!PARSE_ARGV_ARG:~1,-1!^".
            IF !PARSE_ARGV_INSIDE_QUOTES! == TRUE (
                SET PARSE_ARGV_INSIDE_QUOTES=FALSE
            ) ELSE (
                SET PARSE_ARGV_INSIDE_QUOTES=TRUE
            )
            EXIT /B 0
        )
         
        REM �v�G�X�P�[�v�������o�b�t�@�ɒǉ�
        IF ^%~2 == ^! (
            SET PARSE_ARGV_ARG=[!PARSE_ARGV_ARG:~1,-1!^^!]
            EXIT /B 0
        ) ELSE IF ^%~2 == ^) (
            SET PARSE_ARGV_ARG=[!PARSE_ARGV_ARG:~1,-1!^)]
            EXIT /B 0
        ) ELSE IF ^%~2 == ^^ (
            SET PARSE_ARGV_ARG=[!PARSE_ARGV_ARG:~1,-1!^^^^]
            EXIT /B 0
        )
         
        IF %2 == "" (
            REM �I������
            REM IF !PARSE_ARGV_INSIDE_QUOTES! == TRUE (
            REM    REM �_�u���N�H�[�g������ɏI��������G���[
            REM    EXIT /B 1
            REM )
            SET PARSE_ARGV_END=TRUE
        ) ELSE IF NOT "%~2!PARSE_ARGV_INSIDE_QUOTES!" == " FALSE" (
            REM �ʏ핶�����o�b�t�@�ɒǉ�
            SET PARSE_ARGV_ARG=[!PARSE_ARGV_ARG:~1,-1!%~2]
            EXIT /B 0
        )
         
        REM �_�u���N�H�[�g�̊O�ŃX�y�[�X������������̋�؂�Ɣ��f
        IF NOT !PARSE_ARGV_INDEX! == 1 (
            SET /A ARGC = !ARGC! + 1
            SET ARG!ARGC!=!PARSE_ARGV_ARG:~1,-1!
            IF ^%PARSE_ARGV_ARG:~1,1% == ^" (
                SET ARG!ARGC!_=!PARSE_ARGV_ARG:~2,-2!
                SET ARG!ARGC!Q=!PARSE_ARGV_ARG:~1,-1!
            ) ELSE (
                SET ARG!ARGC!_=!PARSE_ARGV_ARG:~1,-1!
                SET ARG!ARGC!Q="!PARSE_ARGV_ARG:~1,-1!"
            )
            SET PARSE_ARGV_ARG=[]
            SET PARSE_ARGV_INSIDE_QUOTES=FALSE
        )
        EXIT /B 0
