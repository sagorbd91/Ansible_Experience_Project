@echo off
setlocal
set port=19001
netstat -an | findstr /RC:":%port% .*LISTENING" 1>nul 2>nul >> list.txt && (ECHO Port is in use)
PAUSE