@echo off
:: ##########################################################################
:: # Gradle startup script for Windows
:: #
:: # Author: Hans Dockter
:: #
:: ##########################################################################

@rem Check if the current script is run with administrator privileges
@rem If so, print a warning that the build should not be run as an administrator

@rem Check if the user is running under the Administrator account
openfiles >nul 2>&1
@if "%errorlevel%" == "0" (
    echo WARNING: This script is not intended to be run with administrator privileges!
)

@rem Capture current directory before changing it
setlocal
set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set GRADLE_HOME=%DIRNAME%

@rem Add default JVM options here. You can also configure them in the gradle.properties file.
set DEFAULT_JVM_OPTS=

@rem Find java.exe
if "%JAVA_HOME%" == "" set JAVA_EXE=java.exe
if not "%JAVA_HOME%" == "" set JAVA_EXE="%JAVA_HOME%/bin/java.exe"

@rem Check if Java is installed
"%JAVA_EXE%" -version >nul 2>&1
if "%ERRORLEVEL%" neq 0 (
    echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
    echo Please set the JAVA_HOME variable in your environment to match the location of your Java installation.
    exit /b 1
)

@rem Get command-line arguments, handling Windows variants

if not "%OS%" == "Windows_NT" setlocal
set CMD_LINE_ARGS=%*

@rem Launch the Gradle build process
@rem Add default JVM options if not already provided by the user

set CLASSPATH=%GRADLE_HOME%/lib/gradle-launcher-7.0.2.jar

@rem Execute Gradle wrapper with the provided command-line arguments
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% -cp "%CLASSPATH%" org.gradle.launcher.GradleMain %CMD_LINE_ARGS%
