@echo off
SET ARGV=%*

setlocal enabledelayedexpansion
CALL :PARSE_ARGV
IF ERRORLEVEL 1 (
    ECHO Cannot parse arguments
    ENDLOCAL
    EXIT /B 1
)

rem ####「VIDEOQUALITY=」の後ろに数字を指定すると、「動画の圧縮品質の指定」の操作を省略できます。
set VIDEOQUALITY=
set AUDIOQUALITY=0.95

set TMPAUDIOWAVFILE="%~n1.wav"
set TMPAUDIOM4AFILE="%~n1.m4a"
set TMPVIDEONOAUDIOFILE="%~n1_noaudio.mp4"

set CMDAVSWAV="%~dp0\avs2wav32.exe"
set CMDX264="%~dp0\x264_2851_x86.exe"
set CMDQSVENC="%~dp0\QSVEnc\QSVEncC.exe"
set CMDNVENC="%~dp0\NVEncC\NVEncC.exe"
set CMDAACENC="%~dp0\neroAacEnc.exe"
set CMDMP4BOX="%~dp0\MP4Box.exe"
set DLLFFMS="%~dp0\AvisynthPlugins\ffms2.dll"
set DLLLAMDASH="%~dp0\AvisynthPlugins\LSMASHSource.dll"
set DLLVSFILTER="%~dp0\AvisynthPlugins\VSFilterMod.dll"
set MEDIAINFO="%~dp0\tools\MediaInfo.exe"
set WORKFOLDER="%~dp1"
set TEMP_INFO=temp_movieinfo.txt

set MOVIEINDEX=0
set ASSINDEX=0
set ERRFLG=0

pushd %WORKFOLDER%

IF "%VIDEOQUALITY%" EQU "" (
    SET /P VIDEOQUALITY=動画の圧縮品質の指定[省略:24] [ファイル大:1⇔51:ファイル小（例）動画編集作業用:4，アニメ等:24，実写等:32]
)

IF "%VIDEOQUALITY%" EQU "" (
    SET VIDEOQUALITY=24
)

FOR /L %%i IN (1,1,!ARGC!) DO (
  call :check_filekind !ARG%%iQ!

)

if not '%MOVIEFILE%' == '' (
  call :movieread %MOVIEFILE%
) else (
  echo 渡されたファイルに動画ファイルがありませんでした。終了します。
  pause
  exit /b
)

rem メディア情報取得
:interlace
%MEDIAINFO% --Inform=Video;%%ScanType%% --LogFile=%TEMP_INFO% %MOVIEFILE%>nul
for /f "delims=" %%i in (%TEMP_INFO%) do set SCAN_TYPE=%%i
if defined SCAN_TYPE echo Scan Type      : %SCAN_TYPE%
%MEDIAINFO% --Inform=Video;%%ScanOrder%% --LogFile=%TEMP_INFO% %MOVIEFILE%>nul
for /f "delims=" %%i in (%TEMP_INFO%) do set SCAN_ORDER=%%i
if defined SCAN_ORDER echo Scan Order     : %SCAN_ORDER%
set FEALDODEROPT=
if /i "%SCAN_TYPE%" == "Interlaced" (
    rem echo AssumeFieldBased^( ^) 1>>%AVSFILE%
      if /i "%SCAN_ORDER%" == "TFF" (
          echo AssumeTFF^( ^) 1>>%AVSFILE%
          set FEALDODEROPT=--tff
      )
      if /i "%SCAN_ORDER%" == "BFF" (
          echo AssumeBFF^( ^) 1>>%AVSFILE%
          set FEALDODEROPT=--bff
      )
)

set /a ASSCOUNT=!ASSINDEX!-1
FOR /L %%L IN (0,1,!ASSCOUNT!) DO (
set fn=!ASSFILE[%%L]!
call :assread2 !fn!
)


echo return last 1>>%AVSFILE%


%CMDAVSWAV% %AVSFILE% %TMPAUDIOWAVFILE%
rem %CMDX264% -q %VIDEOQUALITY% --threads auto --output %TMPVIDEONOAUDIOFILE%  %AVSFILE%
rem %CMDQSVENC% -u 4 --la-icq %VIDEOQUALITY% --la-depth 80 --la-quality slow -i %AVSFILE% -o %TMPVIDEONOAUDIOFILE%
%CMDNVENC% %FEALDODEROPT% --cqp %VIDEOQUALITY% -i %AVSFILE% -o %TMPVIDEONOAUDIOFILE%
set /a "ERRFLG = ERRFLG + ERRORLEVEL"
%CMDAACENC% -q %AUDIOQUALITY% -ignorelength -if %TMPAUDIOWAVFILE% -of %TMPAUDIOM4AFILE%
set /a "ERRFLG = ERRFLG + ERRORLEVEL"

set COUNT=1
call :get_extension %VIDEOFINISHFILE%
set EXT=%extension%
set FINFILE=%filebody%
IF EXIST %VIDEOFINISHFILE% (
    call :setvideofinishfile "%FINFILE%_encoded%EXT%"
)

%CMDMP4BOX% -tmp . -add %TMPVIDEONOAUDIOFILE% -add %TMPAUDIOM4AFILE% -new %VIDEOFINISHFILE%
set /a "ERRFLG = ERRFLG + ERRORLEVEL"

echo エンコード完了！！！(何かキーを押すと中間ファイルを消して終了します)
pause
if %ERRFLG% == 0 (
 del %AVSFILE%
 del %TMPAUDIOWAVFILE%
 del %TMPAUDIOM4AFILE%
 del %TMPVIDEONOAUDIOFILE%
)

popd
exit


:movieread
set AVSFILE="%~n1_ame.avs"
if /i "%~x1" == ".avi" (
  call :tsread "%~1"
) else if /i "%~x1" == ".avs" (
  call :avsread "%~1"
) else if /i "%~x1" == ".ts" (
  call :tsread "%~1"
) else if /i "%~x1" == ".m2ts" (
  call :tsread "%~1"
) else if /i "%~x1" == ".vob" (
  call :tsread "%~1"
) else (
  call :dsread "%~1"
)
set VIDEOFINISHFILE="%~n1.mp4"
exit /b


:aviread
echo DirectShowSource(%*) 1>%AVSFILE%
rem echo ConvertToYV12() 1>>%AVSFILE%
exit /b

:dsread
rem echo LoadPlugin(%DLLFFMS%) 1>%AVSFILE%
rem echo FFVideoSource(%*) 1>>%AVSFILE%
rem echo AudioDub(FFAudioSource(%*)) 1>>%AVSFILE%
echo LoadPlugin(%DLLLAMDASH%) 1>%AVSFILE%
echo LSMASHVideoSource(%*) 1>>%AVSFILE%
echo AudioDub(LSMASHAudioSource(%*)) 1>>%AVSFILE%
rem echo ConvertToYV12() 1>>%AVSFILE%
exit /b

:tsread
echo LoadPlugin(%DLLLAMDASH%) 1>%AVSFILE%
echo LWLibavVideoSource(source=%*, stream_index=-1, repeat=true, cache=false) 1>>%AVSFILE%
echo AudioDub(LWLibavAudioSource(source=%*, stream_index=-1, av_sync=false, cache=false )) 1>>%AVSFILE%
rem echo ConvertToYV12() 1>>%AVSFILE%
exit /b


:avsread
echo Import(%*) 1>%AVSFILE%
rem echo ConvertToYV12() 1>>%AVSFILE%
exit /b

:assread2
echo LoadPlugin(%DLLVSFILTER%) 1>>%AVSFILE%
echo TextsubMod(%*) 1>>%AVSFILE%
exit /b

:setvideofinishfile
set VIDEOFINISHFILE="%FINFILE%_encoded%EXT%"
exit /b


:get_extension
set extension=%~x1
rem set extension=%extension:~1%
set filebody=%~n1
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
        REM 引数の文字列を先頭から1文字ずつチェックする
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
        REM ダブルクォート開始終了判定
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
         
        REM 要エスケープ文字をバッファに追加
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
            REM 終了判定
            REM IF !PARSE_ARGV_INSIDE_QUOTES! == TRUE (
            REM    REM ダブルクォートを閉じずに終了したらエラー
            REM    EXIT /B 1
            REM )
            SET PARSE_ARGV_END=TRUE
        ) ELSE IF NOT "%~2!PARSE_ARGV_INSIDE_QUOTES!" == " FALSE" (
            REM 通常文字をバッファに追加
            SET PARSE_ARGV_ARG=[!PARSE_ARGV_ARG:~1,-1!%~2]
            EXIT /B 0
        )
         
        REM ダブルクォートの外でスペースがきたら引数の区切りと判断
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
