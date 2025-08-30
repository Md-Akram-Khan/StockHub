import React from 'react'
import { Toaster } from 'react-hot-toast'
import { AuthProvider } from './contexts/AuthContext'
import ProtectedRoute from './components/ProtectedRoute'
import Header from './components/Header'
import Dashboard from './components/Dashboard'

function App() {
  return (
    <AuthProvider>
      <div className="min-h-screen bg-gray-50">
        <Toaster 
          position="top-right"
          toastOptions={{
            duration: 4000,
            style: {
              background: '#363636',
              color: '#fff',
            },
          }}
        />
        <ProtectedRoute>
          <Header />
          <main>
            <Dashboard />
          </main>
        </ProtectedRoute>
      </div>
    </AuthProvider>
  )
}

export default App
