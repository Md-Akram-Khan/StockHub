-- ============================================
-- SUPABASE USERS TABLE CREATION SCRIPT
-- ============================================
-- Run this SQL in your Supabase SQL Editor
-- Navigate to: Supabase Dashboard > SQL Editor > New Query
-- ============================================

-- Create users profile table
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    auth_id UUID NOT NULL UNIQUE REFERENCES auth.users(id) ON DELETE CASCADE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    username VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    address TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Data validation constraints
    CONSTRAINT username_format CHECK (username ~ '^[a-zA-Z0-9_]{3,20}$'),
    CONSTRAINT email_format CHECK (email ~ '^[^\s@]+@[^\s@]+\.[^\s@]+$'),
    CONSTRAINT phone_format CHECK (phone ~ '^[\+]?[1-9][\d]{0,15}$')
);

-- Enable Row Level Security (RLS)
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- RLS Policy: Users can view their own profile
CREATE POLICY "Users can view own profile" ON users
    FOR SELECT USING (auth.uid() = auth_id);

-- RLS Policy: Users can insert their own profile (during signup)
CREATE POLICY "Users can insert own profile" ON users
    FOR INSERT WITH CHECK (auth.uid() = auth_id);

-- RLS Policy: Users can update their own profile
CREATE POLICY "Users can update own profile" ON users
    FOR UPDATE USING (auth.uid() = auth_id);

-- RLS Policy: Allow reading usernames for uniqueness checks
-- This allows the app to check if username is available during signup
CREATE POLICY "Public username read for uniqueness" ON users
    FOR SELECT USING (true);

-- Create function to automatically update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create trigger to automatically update updated_at on row updates
CREATE TRIGGER update_users_updated_at
    BEFORE UPDATE ON users
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_users_auth_id ON users(auth_id);
CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);

-- ============================================
-- TABLE STRUCTURE SUMMARY:
-- ============================================
-- Column        | Type      | Constraints
-- --------------|-----------|------------------
-- id            | SERIAL    | PRIMARY KEY
-- auth_id       | UUID      | UNIQUE, FK to auth.users(id)
-- first_name    | VARCHAR   | NOT NULL, max 50 chars
-- last_name     | VARCHAR   | NOT NULL, max 50 chars
-- username      | VARCHAR   | NOT NULL, UNIQUE, 3-20 chars, alphanumeric + underscore
-- email         | VARCHAR   | NOT NULL, UNIQUE, valid email format
-- phone         | VARCHAR   | NOT NULL, max 20 chars, valid phone format
-- address       | TEXT      | NOT NULL
-- created_at    | TIMESTAMP | DEFAULT NOW()
-- updated_at    | TIMESTAMP | AUTO-UPDATE via trigger
-- ============================================

-- Verification queries (optional - run to test):
-- SELECT table_name, column_name, data_type, is_nullable, column_default
-- FROM information_schema.columns 
-- WHERE table_name = 'users' 
-- ORDER BY ordinal_position;

-- Check RLS policies:
-- SELECT schemaname, tablename, policyname, permissive, roles, cmd, qual
-- FROM pg_policies 
-- WHERE tablename = 'users';
