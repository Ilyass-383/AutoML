@echo off
echo ========================================
echo   Démarrage Auto-ML Detection System
echo ========================================
echo.

cd /d "C:\Users\HP\Documents\Data_Mining AutoML"

echo [1/3] Lancement des conteneurs...
docker-compose up -d

echo.
echo [2/3] Attente du démarrage...
timeout /t 10 /nobreak > nul

echo.
echo [3/3] Services démarrés !
echo.
echo ========================================
echo   ACCES AUX SERVICES :
echo ========================================
echo.
echo   API : http://localhost:8000
echo   Swagger : http://localhost:8000/docs
echo   Grafana : http://localhost:3000 (admin/admin)
echo.
echo ========================================
echo   Pour arreter : docker-compose down
echo ========================================

start http://localhost:8000/docs
start http://localhost:3000

pause