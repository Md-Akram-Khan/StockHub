#!/bin/bash

# Start both frontend and backend in development mode

echo "🚀 Starting StockHub Development Servers..."

# Function to handle cleanup on script exit
cleanup() {
    echo "Shutting down servers..."
    kill $(jobs -p) 2>/dev/null
    exit 0
}

# Set trap to cleanup on script exit
trap cleanup SIGINT SIGTERM

# Start backend
echo "🐍 Starting FastAPI backend..."
cd backend
source venv/bin/activate
python main.py &
BACKEND_PID=$!
cd ..

# Wait a moment for backend to start
sleep 3

# Start frontend
echo "⚛️  Starting React frontend..."
npm run dev &
FRONTEND_PID=$!

echo ""
echo "✅ Development servers started!"
echo "🌐 Frontend: http://localhost:3000"
echo "🔧 Backend API: http://localhost:8000"
echo "📚 API Docs: http://localhost:8000/docs"
echo ""
echo "Press Ctrl+C to stop all servers"

# Wait for both processes
wait
