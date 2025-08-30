import React from 'react'
import { useAuth } from '../contexts/AuthContext'

const Header = () => {
  const { user, signOut } = useAuth()

  return (
    <header className="bg-white shadow-sm border-b border-gray-200">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center py-6">
          <div className="flex items-center">
            <h1 className="text-2xl font-bold text-gray-900">
              StockHub
            </h1>
          </div>
          <div className="flex items-center space-x-4">
            <span className="text-sm text-gray-500">
              Welcome, {user?.user_metadata?.full_name || user?.email}
            </span>
            <button
              onClick={signOut}
              className="bg-gray-800 text-white px-4 py-2 rounded-md text-sm font-medium hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500"
            >
              Sign Out
            </button>
          </div>
        </div>
      </div>
    </header>
  )
}

export default Header
