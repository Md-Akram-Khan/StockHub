# StockHub - Full Stack Inventory Management System

A modern, scalable inventory management system built with React (Vite), FastAPI, and Supabase.

## 🚀 Features

- **Authentication**: Secure user authentication with Supabase Auth
- **CRUD Operations**: Full Create, Read, Update, Delete functionality for inventory items
- **Real-time Updates**: Real-time data synchronization with Supabase
- **Row-Level Security**: Secure data access with Supabase RLS policies
- **Modern UI**: Beautiful, responsive interface with TailwindCSS
- **Type Safety**: Full TypeScript support (optional)
- **Scalable Architecture**: Modular, clean code structure for easy scaling

## 🛠 Tech Stack

### Frontend
- **React 18** with functional components and hooks
- **Vite** for fast development and building
- **TailwindCSS** for styling
- **Axios** for API calls
- **React Router** for navigation
- **React Hot Toast** for notifications
- **Supabase JS Client** for authentication

### Backend
- **FastAPI** for high-performance API
- **Supabase** as PostgreSQL database
- **Pydantic** for data validation
- **JWT** token authentication
- **CORS** enabled for frontend communication
- **Async/Await** for optimal performance

### Database
- **PostgreSQL** via Supabase
- **Row-Level Security (RLS)** for data protection
- **Automatic timestamps** with triggers
- **Indexed columns** for performance

## 📦 Installation & Setup

### Prerequisites
- Node.js 18+ and npm
- Python 3.8+
- Git

### 1. Frontend Setup
```bash
# Install dependencies
npm install

# Start development server
npm run dev
```

### 2. Backend Setup
```bash
# Navigate to backend directory
cd backend

# Create virtual environment
python -m venv venv

# Activate virtual environment (Windows)
venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Start development server
python main.py
```

### 3. Database Setup
1. Go to your Supabase project dashboard
2. Navigate to SQL Editor
3. Run the SQL script from `backend/database_schema.sql`

## 🚀 Development Commands

### Frontend
- `npm run dev` - Start development server (port 3000)
- `npm run build` - Build for production
- `npm run preview` - Preview production build

### Backend
- `python main.py` - Start FastAPI server (port 8000)
- `uvicorn main:app --reload` - Alternative start command

### Code Splitting

This section has moved here: [https://facebook.github.io/create-react-app/docs/code-splitting](https://facebook.github.io/create-react-app/docs/code-splitting)

### Analyzing the Bundle Size

This section has moved here: [https://facebook.github.io/create-react-app/docs/analyzing-the-bundle-size](https://facebook.github.io/create-react-app/docs/analyzing-the-bundle-size)

### Making a Progressive Web App

This section has moved here: [https://facebook.github.io/create-react-app/docs/making-a-progressive-web-app](https://facebook.github.io/create-react-app/docs/making-a-progressive-web-app)

### Advanced Configuration

This section has moved here: [https://facebook.github.io/create-react-app/docs/advanced-configuration](https://facebook.github.io/create-react-app/docs/advanced-configuration)

### Deployment

This section has moved here: [https://facebook.github.io/create-react-app/docs/deployment](https://facebook.github.io/create-react-app/docs/deployment)

### `npm run build` fails to minify

This section has moved here: [https://facebook.github.io/create-react-app/docs/troubleshooting#npm-run-build-fails-to-minify](https://facebook.github.io/create-react-app/docs/troubleshooting#npm-run-build-fails-to-minify)
