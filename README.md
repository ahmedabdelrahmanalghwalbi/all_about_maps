# Flutter Maps Project

This project is a practice exercise focusing on various aspects of mapping in Flutter. It includes functionalities such as Markers, Map Controllers, Map Styles, Geocoding, Location Services, Places API, Circles, Polygons, Polylines, Overlays, Custom Info Windows, OpenStreetMap API, Tracking, and Clustering.

## Dependencies

- `google_maps_flutter: ^2.5.3`
- `google_maps_flutter_web: ^0.5.4+3`
- `geocoding: ^2.1.1`
- `geolocator: ^11.0.0`
- `uuid: ^4.3.3`
- `location: ^5.0.3`
- `firebase_core: ^2.25.4`
- `cloud_firestore: ^4.15.4`
- `custom_info_window: ^1.0.1`
- `google_maps_webservice: ^0.0.20-nullsafety.5`
- `http: ^0.13.6`
- `flutter_map: ^4.0.0`
- `latlong2: ^0.8.2`
- `google_maps_cluster_manager: ^3.1.0`
- `flutter_dotenv: ^5.1.0`

## Getting Started

Before running the project, you need to obtain API keys for the necessary services and configure them properly.

### Getting API Keys

1. **Google Maps API Key**:
   - Visit the [Google Cloud Console](https://console.cloud.google.com/).
   - Create a new project or select an existing one.
   - Enable the "Maps SDK for Android" and "Maps SDK for iOS" APIs.
   - Create an API key.

2. **Firebase API Key** (if using Firebase services):
   - Visit the [Firebase Console](https://console.firebase.google.com/).
   - Create a new project or select an existing one.
   - Navigate to "Project settings" > "General" and locate your Web API Key.

### Using API Keys

1. **Using `.env` File**:
   - Create a `.env` file in the root directory of your project.
   - Add your API keys in the `.env` file in the format `KEY=VALUE`. For example:

     ```
     GOOGLE_MAPS_API_KEY=your_google_maps_api_key
     FIREBASE_API_KEY=your_firebase_api_key
     ```

2. **Configuring in Code**:
   - Use the `flutter_dotenv` package to load environment variables from the `.env` file in your Dart code.

## Usage

1. Clone the repository:

   ```bash
   git clone https://github.com/ahmedabdelrahmanalghwalbi/all_about_maps.git