const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const { Client } = require('pg');

const app = express();
const PORT = 3000;

// PostgreSQL client
const client = new Client({
  connectionString: 'postgresql://neondb_owner:npg_azBtUTsW8wJ2@ep-dark-lab-ai9vq796-pooler.c-4.us-east-1.aws.neon.tech/neondb?sslmode=require&channel_binding=require',
  ssl: { rejectUnauthorized: false }
});

// Connect to PostgreSQL
client.connect()
  .then(() => console.log('Connected to Neon PostgreSQL'))
  .catch(err => console.error('Connection error', err.stack));

// Middleware
app.use(cors());
app.use(bodyParser.json());

// Route to receive residence profiling data
app.post('/api/residence-profiles', async (req, res) => {
  try {
    const profile = req.body;

    // Check if profile already exists
    const checkQuery = `
      SELECT id FROM residence_profiles
      WHERE first_name = $1 AND last_name = $2 AND birth_date = $3
    `;
    const checkValues = [profile.firstName, profile.lastName, profile.birthDate];
    const checkResult = await client.query(checkQuery, checkValues);

    if (checkResult.rows.length > 0) {
      console.log('Profile already exists with ID:', checkResult.rows[0].id);
      return res.status(200).json({
        message: 'Profile already exists',
        profileId: checkResult.rows[0].id
      });
    }

    // Insert into PostgreSQL
    const insertQuery = `
      INSERT INTO residence_profiles (
        first_name, middle_name, last_name, blood_type, sex, marital_status,
        name_extension, educational_attainment, birth_place, birth_date,
        latitude, longitude, photo_path
      ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13)
      RETURNING id
    `;
    const insertValues = [
      profile.firstName,
      profile.middleName,
      profile.lastName,
      profile.bloodType,
      profile.sex,
      profile.maritalStatus,
      profile.nameExtension,
      profile.educationalAttainment,
      profile.birthPlace,
      profile.birthDate,
      profile.latitude,
      profile.longitude,
      profile.photoPath
    ];

    const insertResult = await client.query(insertQuery, insertValues);
    const profileId = insertResult.rows[0].id;

    console.log('Profile saved to database with ID:', profileId);

    res.status(201).json({
      message: 'Profile saved successfully',
      profileId: profileId
    });
  } catch (error) {
    console.error('Error saving profile:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Route to get all profiles (for testing)
app.get('/api/residence-profiles', async (req, res) => {
  try {
    const result = await client.query('SELECT * FROM residence_profiles ORDER BY created_at DESC');
    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching profiles:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Health check
app.get('/health', (req, res) => {
  res.json({ status: 'OK', timestamp: new Date().toISOString() });
});

app.get('/api/test', (req, res) => {
  res.json({ status: 'Backend reachable ✅' });
});

app.listen(3000, '0.0.0.0', () => {
  console.log('Backend running on http://0.0.0.0:3000');
});


