# Barangay E-System - Residence Profiling

A Flutter mobile application for collecting residence profiling data in barangays (local communities). The app features offline data collection with automatic synchronization when online.

## Features

- **Offline-First**: Collect data without internet connection
- **Step-by-Step Form**: User-friendly multi-step profiling form
- **GPS Integration**: Automatic location capture
- **Photo Upload**: Camera integration for resident photos
- **Data Sync**: Automatic upload to backend when connected
- **Local Database**: SQLite database using Drift ORM

## Project Structure

```
lib/
├── database/          # Drift database schema and DAOs
├── pages/            # UI pages (Welcome, Step)
├── services/         # API and connectivity services
├── widgets/          # Reusable widgets (Form)
└── main.dart         # App entry point

backend/              # Node.js Express backend example
├── server.js
└── package.json
```

## Setup Instructions

### Prerequisites

- Flutter SDK (3.10.8 or later)
- Dart SDK
- Android Studio or VS Code with Flutter extensions
- Node.js (for backend)

### Flutter App Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd barangay_esystem
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate database code**
   ```bash
   flutter pub run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Backend Setup (Optional)

1. **Navigate to backend directory**
   ```bash
   cd backend
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Start the server**
   ```bash
   npm start
   ```

   The backend will run on `http://localhost:3000`

## Usage

1. **Launch the app**: The welcome screen appears
2. **Start Profiling**: Click "Start Profiling" to begin the form
3. **Fill Form**: Complete each step of the profiling form
4. **Save Data**: Choose to Save (and sync if online) or Save Draft
5. **Sync**: Data automatically syncs to backend when online

## Form Fields

- Personal Information: First Name, Middle Name, Last Name, Name Extension
- Demographics: Sex, Marital Status, Blood Type
- Education: Educational Attainment
- Location: Birth Place, GPS Coordinates
- Media: Profile Photo

## API Endpoints

- `POST /api/residence-profiles` - Upload profile data
- `GET /api/residence-profiles` - Retrieve all profiles (for testing)

## Technologies Used

- **Frontend**: Flutter, Dart
- **Database**: SQLite with Drift ORM
- **Backend**: Node.js, Express
- **Plugins**: Geolocator, Image Picker, Connectivity Plus, HTTP

## Permissions

The app requires the following permissions:
- Location (GPS coordinates)
- Camera (photo capture)
- Storage (save photos)

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make changes and test
4. Submit a pull request

## License

This project is licensed under the MIT License.
