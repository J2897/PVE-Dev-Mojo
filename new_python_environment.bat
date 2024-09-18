@echo OFF
cls

REM List installed Python versions and create a selection menu
echo Available Python versions:
py -0 > temp_versions.txt
setlocal enabledelayedexpansion
set "count=0"
set "choices="

REM Read the list of installed Python versions
for /f "tokens=*" %%i in (temp_versions.txt) do (
    if not "%%i"=="" (
        set /a count+=1
        echo !count!. %%i
        set "version!count!=%%i"
        set "choices=!choices!!count!"
    )
)
del temp_versions.txt

REM Prompt user to select a Python version
choice /C %choices% /M "Select the desired Python version by number: "
set "PYTHON_VERSION=!version%ERRORLEVEL%!"

REM Extract the version number from the selected line
for /f "tokens=2 delims=:- " %%i in ("!PYTHON_VERSION!") do set "PYTHON_VERSION=%%i"

REM Debugging: Display selected Python version
echo Selected Python version: %PYTHON_VERSION%

REM Set the paths for the Python project
set "PYTHON=%USERPROFILE%\Code\Python"
set /P "PROJECT=New project name: "
set "PRDIR=%PYTHON%\%PROJECT%"
set "ENV=%PRDIR%\venv"

REM Check if the virtual environment already exists
if exist "%ENV%" (
    echo That project already exists.
    REM Jump to the part where we activate the environment and open Notepad++
    goto :ACTIVATE_ENV
)

REM Initialize UPGRADE_DEPS to be empty
set "UPGRADE_DEPS="

REM Process version numbers
for /f "tokens=1,2 delims=." %%v in ("%PYTHON_VERSION%") do (
    set "MAJOR=%%v"
    set "MINOR=%%w"

    REM Check if the Python version should use --upgrade-deps
    if !MAJOR! GTR 3 set "UPGRADE_DEPS=--upgrade-deps" else if !MAJOR!==3 (
        if !MINOR! GEQ 9 set "UPGRADE_DEPS=--upgrade-deps"
    )
)

REM Define the command to create the virtual environment with the selected Python version.
set "CREATE_VENV_CMD=py -%PYTHON_VERSION% -m venv "%ENV%" %UPGRADE_DEPS%"

REM Create the virtual environment
title New Python virtual environment
echo Creating the virtual environment with Python %PYTHON_VERSION% . . .
call %CREATE_VENV_CMD%

REM Temporarily disable delayed expansion to write the correct line to run.py.
setlocal disabledelayedexpansion
echo #! python%PYTHON_VERSION%>"%PRDIR%\run.py"
endlocal

:ACTIVATE_ENV

REM Activate the virtual environment
title Python virtual environment
cd "%PRDIR%"
cls
echo Activating the virtual environment...
start "" /D "%PRDIR%" "C:\Program Files\Notepad++\notepad++.exe" "%PRDIR%\run.py"
cmd /K "%ENV%\Scripts\activate.bat"
