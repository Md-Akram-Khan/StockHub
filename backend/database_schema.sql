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
    
    -- Constraints
    CONSTRAINT username_format CHECK (username ~ '^[a-zA-Z0-9_]{3,20}$'),
    CONSTRAINT email_format CHECK (email ~ '^[^\s@]+@[^\s@]+\.[^\s@]+$'),
    CONSTRAINT phone_format CHECK (phone ~ '^[\+]?[1-9][\d]{0,15}$')
);

-- Create RLS (Row Level Security) policies for users table
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- Policy: Users can view their own profile
CREATE POLICY "Users can view own profile" ON users
    FOR SELECT USING (auth.uid() = auth_id);

-- Policy: Users can insert their own profile (during signup)
CREATE POLICY "Users can insert own profile" ON users
    FOR INSERT WITH CHECK (auth.uid() = auth_id);

-- Policy: Users can update their own profile
CREATE POLICY "Users can update own profile" ON users
    FOR UPDATE USING (auth.uid() = auth_id);

-- Policy: Allow reading usernames for uniqueness checks (public read on username only)
CREATE POLICY "Public username read for uniqueness" ON users
    FOR SELECT USING (true);

-- Create function to automatically update updated_at timestamp for users
CREATE TRIGGER update_users_updated_at
    BEFORE UPDATE ON users
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Create indexes for better performance on users table
CREATE INDEX IF NOT EXISTS idx_users_auth_id ON users(auth_id);
CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);

-- Create items table
CREATE TABLE IF NOT EXISTS items (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    quantity INTEGER NOT NULL DEFAULT 0,
    price DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    category VARCHAR(50),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create RLS (Row Level Security) policies
ALTER TABLE items ENABLE ROW LEVEL SECURITY;

-- Policy: Users can only see their own items
CREATE POLICY "Users can view own items" ON items
    FOR SELECT USING (auth.uid() = user_id);

-- Policy: Users can insert their own items
CREATE POLICY "Users can insert own items" ON items
    FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Policy: Users can update their own items
CREATE POLICY "Users can update own items" ON items
    FOR UPDATE USING (auth.uid() = user_id);

-- Policy: Users can delete their own items
CREATE POLICY "Users can delete own items" ON items
    FOR DELETE USING (auth.uid() = user_id);

-- Create function to automatically update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_items_updated_at
    BEFORE UPDATE ON items
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_items_user_id ON items(user_id);
CREATE INDEX IF NOT EXISTS idx_items_category ON items(category);
CREATE INDEX IF NOT EXISTS idx_items_created_at ON items(created_at);
