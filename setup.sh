#!/bin/bash

echo "🚀 Setting up StockHub Full-Stack Application"

# Frontend setup
echo "📦 Installing frontend dependencies..."
npm install

# Backend setup
echo "🐍 Setting up Python backend..."
cd backend

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    python -m venv venv
fi

# Activate virtual environment and install dependencies
source venv/bin/activate
pip install -r requirements.txt

cd ..

echo "✅ Setup complete!"
echo ""
echo "📝 Next steps:"
echo "1. Set up your Supabase database by running the SQL in backend/database_schema.sql"
echo "2. Update environment variables in .env and backend/.env"
echo "3. Start the application:"
echo "   - Frontend: npm run dev"
echo "   - Backend: cd backend && python main.py"
echo ""
echo "🌐 Your app will be available at:"
echo "   - Frontend: http://localhost:3000"
echo "   - Backend API: http://localhost:8000"
echo "   - API Docs: http://localhost:8000/docs"
