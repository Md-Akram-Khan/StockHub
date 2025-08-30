import React, { useState, useEffect } from 'react'
import { useAuth } from '@contexts/AuthContext'
import LandingPage from './landing/LandingPage'
import SignInPage from './landing/SignInPage'
import SignUpPage from './landing/SignUpPage'
import Header from '@components/Header'
import Dashboard from '@components/Dashboard'

const Router = () => {
  const [currentPage, setCurrentPage] = useState('landing')
  const { user, loading } = useAuth()

  // Simple client-side routing based on URL hash
  useEffect(() => {
    const handleHashChange = () => {
      const hash = window.location.hash.slice(1) // Remove #
      if (hash === 'signin') {
        setCurrentPage('signin')
      } else if (hash === 'signup') {
        setCurrentPage('signup')
      } else if (hash === 'dashboard' && user) {
        setCurrentPage('dashboard')
      } else {
        setCurrentPage('landing')
      }
    }

    // Set initial page based on hash
    handleHashChange()

    // Listen for hash changes
    window.addEventListener('hashchange', handleHashChange)
    
    return () => {
      window.removeEventListener('hashchange', handleHashChange)
    }
  }, [user])

  // Handle navigation
  const navigate = (page) => {
    setCurrentPage(page)
    if (page === 'landing') {
      window.location.hash = ''
    } else {
      window.location.hash = page
    }
  }

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="animate-spin rounded-full h-32 w-32 border-b-2 border-primary-600"></div>
      </div>
    )
  }

  // If user is authenticated, show the dashboard
  if (user) {
    return (
      <>
        <Header />
        <main>
          <Dashboard />
        </main>
      </>
    )
  }

  // Show different pages based on current route
  switch (currentPage) {
    case 'signin':
      return <SignInPage navigate={navigate} />
    case 'signup':
      return <SignUpPage navigate={navigate} />
    default:
      return <LandingPage navigate={navigate} />
  }
}

export default Router
