REM ~/.win/envvars.bat - setup permanent Windows environment variables

@echo off

REM Cygwin
REM - 
setx CYGWIN "winsymlinks:nativestrict" /m
