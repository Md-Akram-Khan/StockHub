import React from 'react'
import { Toaster } from 'react-hot-toast'
import { AuthProvider } from './contexts/AuthContext'
import Router from './components/Router'

function App() {
  return (
    <AuthProvider>
      <div className="min-h-screen">
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
        <Router />
      </div>
    </AuthProvider>
  )
}

export default App
