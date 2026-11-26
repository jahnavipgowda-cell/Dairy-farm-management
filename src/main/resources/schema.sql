CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name_en VARCHAR(100) NOT NULL UNIQUE,
    name_kn VARCHAR(100) NOT NULL UNIQUE,
    category VARCHAR(50) NOT NULL CHECK (category IN ('LIVESTOCK', 'POULTRY', 'AQUATIC', 'APICULTURE'))
);

CREATE TABLE animals (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tag_number VARCHAR(50) UNIQUE NOT NULL,
    species_id INT REFERENCES species(id) ON DELETE RESTRICT,
    breed_en VARCHAR(100) NOT NULL,
    breed_kn VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    gender VARCHAR(10) CHECK (gender IN ('MALE', 'FEMALE', 'CASTRATED')),
    health_status VARCHAR(50) NOT NULL CHECK (health_status IN ('HEALTHY', 'SICK', 'QUARANTINED', 'PREGNANT', 'SOLD')),
    weight_kg NUMERIC(6, 2) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    slug VARCHAR(100) UNIQUE NOT NULL,
    name_en VARCHAR(100) NOT NULL,
    name_kn VARCHAR(100) NOT NULL,
    icon_url TEXT
);

CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    category_id INT REFERENCES categories(id) ON DELETE RESTRICT,
    sku VARCHAR(100) UNIQUE NOT NULL,
    title_en VARCHAR(255) NOT NULL,
    title_kn VARCHAR(255) NOT NULL,
    base_price NUMERIC(10, 2) NOT NULL,
    sale_price NUMERIC(10, 2) NOT NULL,
    unit_type VARCHAR(20) NOT NULL CHECK (unit_type IN ('KG', 'LITER', 'PACK', 'PIECE')),
    is_available BOOLEAN DEFAULT TRUE
);
