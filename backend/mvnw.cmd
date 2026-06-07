@REM Maven Wrapper startup script for Windows
@echo off

if not "%JAVA_HOME%"=="" set JAVACMD=%JAVA_HOME%\bin\java.exe
if "%JAVACMD%"=="" set JAVACMD=java

set BASE_DIR=%~dp0
set MAVEN_WRAPPER_JAR=%BASE_DIR%.mvn\wrapper\maven-wrapper.jar
set MAVEN_WRAPPER_PROPERTIES=%BASE_DIR%.mvn\wrapper\maven-wrapper.properties

for /f "tokens=2 delims==" %%a in ('findstr "wrapperUrl" "%MAVEN_WRAPPER_PROPERTIES%"') do set DOWNLOAD_URL=%%a

if not exist "%MAVEN_WRAPPER_JAR%" (
  echo Downloading Maven Wrapper...
  curl -o "%MAVEN_WRAPPER_JAR%" "%DOWNLOAD_URL%" 2>nul
)

"%JAVACMD%" ^
  -classpath "%MAVEN_WRAPPER_JAR%" ^
  "-Dmaven.multiModuleProjectDirectory=%BASE_DIR%" ^
  org.apache.maven.wrapper.MavenWrapperMain %*
