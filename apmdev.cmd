@echo off
setlocal

set CacheDir=C:\src\Bentley\APM\bin\cache
set DestDir=D:\Apm\backup
set BuildDir=\\torprdfs01\Product\Builds\7.11.0
set /p Current=<%BuildDir%\Current.txt
set CurrentDir=%BuildDir%\%Current%

if %1.==. goto invalid
if %1==help goto help
if %1==getcache goto getcache
if %1==getapptesting goto getapptesting
if %1==getqabase goto getqabase
if %1==getall goto getall
if %1==unzipcache goto unzipcache
if %1==restoreapptesting goto restoreapptesting
if %1==restoreqabase goto restoreqabase
goto invalid

:getcache
echo Fetching cache from %CurrentDir%
copy %CurrentDir%\cache.7z %DestDir%
goto end

:getapptesting
echo Fetching IvaraApplicationTesting from %CurrentDir%
copy %CurrentDir%\IvaraApplicationTestingLocal-%Current%.bak %DestDir%
goto end

:getqabase
echo Fetching QA_Base from %CurrentDir%
copy %CurrentDir%\QA_BASE_TESTSUITESLocal-%Current%.bak %DestDir%
goto end

:getall
echo Fetching from %CurrentDir%
copy %CurrentDir%\cache.7z %DestDir%
copy %CurrentDir%\IvaraApplicationTestingLocal-%Current%.bak %DestDir%
copy %CurrentDir%\QA_BASE_TESTSUITESLocal-%Current%.bak %DestDir%
goto end

:unzipcache
set PATH=%PATH%;"C:\Program Files\7-Zip"
echo Deleting old cache files from %CacheDir%
del %CacheDir% /s /q
echo Unzipping Cache from %DestDir%\cache.7z to %CacheDir%
7z x -y %DestDir%\cache.7z -o%CacheDir%
popd
rem
goto end

:restoreapptesting
echo Restoring IvaraApplicationTestingLocal-%Current%.bak
call %~dp0restoredb IvaraApplicationTestingLocal %DestDir%\IvaraApplicationTestingLocal-%Current%.bak
goto end

:restoreqabase
echo Restoring QA_BASE_TESTSUITESLocal-%Current%.bak
call %~dp0restoredb QA_Base %DestDir%\QA_BASE_TESTSUITESLocal-%Current%.bak
goto end


:invalid
echo Invalid command
echo.

:help
echo Update my APM Development Environment
echo.
echo Options:
echo   help              - Show this help
echo   getcache          - Copies the current cache locally
echo   getapptesting     - Copies the current app testing db locally
echo   getqabase         - Copies the current qa_base db locally
echo   getall            - Copies the current cache and dbs locally
echo   unzipcache        - Unzips the cache
echo   restoreapptesting - Restores the app testing db
echo   restoreqabase     - Restores the qa_base db

:end