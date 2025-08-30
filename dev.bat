@echo off
setlocal EnableDelayedExpansion

echo 🚀 Starting StockHub Development Servers...

REM Start backend
echo 🐍 Starting FastAPI backend...
cd backend
call venv\Scripts\activate
start "Backend" cmd /k "python main.py"
cd ..

REM Wait a moment for backend to start
timeout /t 3 /nobreak > nul

REM Start frontend
echo ⚛️  Starting React frontend...
start "Frontend" cmd /k "npm run dev"

echo.
echo ✅ Development servers started!
echo 🌐 Frontend: http://localhost:3000
echo 🔧 Backend API: http://localhost:8000
echo 📚 API Docs: http://localhost:8000/docs
echo.
echo Both servers are running in separate windows.
echo Close the windows or press Ctrl+C in each to stop them.

pause
