-- Create the residence_profiles table
CREATE TABLE IF NOT EXISTS residence_profiles (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR NOT NULL,
    middle_name VARCHAR,
    last_name VARCHAR NOT NULL,
    blood_type VARCHAR,
    sex VARCHAR NOT NULL,
    marital_status VARCHAR NOT NULL,
    name_extension VARCHAR,
    educational_attainment VARCHAR NOT NULL,
    birth_place VARCHAR NOT NULL,
    birth_date DATE NOT NULL,
    latitude REAL,
    longitude REAL,
    photo_path VARCHAR,
    is_synced BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Function to update updated_at on update
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to automatically update updated_at
CREATE TRIGGER update_residence_profiles_updated_at
    BEFORE UPDATE ON residence_profiles
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Index on is_synced for efficient querying of unsynced profiles
CREATE INDEX IF NOT EXISTS idx_residence_profiles_is_synced ON residence_profiles (is_synced);
