# 💬 WhatsApp Clone

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.10%2B-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.1%2B-blue?logo=dart)
![Firebase](https://img.shields.io/badge/Firebase-Latest-orange?logo=firebase)
![License](https://img.shields.io/badge/License-MIT-green)
![Stars](https://img.shields.io/github/stars/username/whatapp_clone?style=social)

A **production-ready** Flutter messaging application that replicates WhatsApp's core functionality. Built with **Clean Architecture**, **BLoC pattern**, and **Firebase** integration to demonstrate professional mobile app development practices.

[Features](#-features) • [Setup](#-installation--setup) • [Architecture](#-architecture) • [Contributing](#-contributing)

</div>

---

## 🌟 Features

### 💬 **Core Messaging**
- ✅ Real-time messaging via Cloud Firestore
- ✅ Message delivery status tracking (Sent → Delivered → Seen)
- ✅ Integrated emoji picker for rich expressions
- ✅ Intelligent timestamp formatting (e.g., "2 hours ago", "Today", "Yesterday")
- ✅ Message grouping by sender and timestamp

### 📁 **Media & Attachments**
- 📸 Photo sharing from gallery and camera
- 🎥 Video recording and sharing
- 🎤 Audio message recording with playback controls
- 📄 Document (PDF, Word) sharing
- 📍 Location sharing with real-time coordinates
- 👥 Contact card sharing
- 🎬 GIF search and integration
- 🗳️ Poll creation and voting

### 👥 **User Management**
- 👤 User profiles with avatar and status
- 📝 Bio/status message updates
- 🔐 Secure authentication via Firebase Auth
- 📱 Device contact synchronization
- 🔍 Search and filter users

### 🎨 **User Interface**
- 🌙 Professional dark theme with accent colors
- 📱 Fully responsive design for all screen sizes
- ↩️ Swipe-to-reply gesture support
- 📌 Long-press context menus
- 📊 Beautiful message bubbles with animations
- 🎪 Smooth page transitions

### 🚀 **Additional Features**
- 🎙️ Voice call interfaces (ready for implementation)
- 📹 Video call interfaces (ready for implementation)
- 📢 Status/Stories feature
- 🔔 Toast notifications
- ⏰ Message timestamps with timezone support

## � Table of Contents

- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Project Architecture](#-architecture)
- [Project Structure](#-project-structure)
- [Prerequisites](#-prerequisites)
- [Installation & Setup](#-installation--setup)
- [Usage Guide](#-usage)
- [Configuration](#-configuration)
- [Development](#-development)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🏗️ **Architecture**

This project follows **Clean Architecture** principles with clear separation of concerns:

### **Architecture Layers**

```
┌─────────────────────────────────────────┐
│      Presentation Layer (UI/BLoC)      │  ← User Interface & Business Logic
├─────────────────────────────────────────┤
│         Domain Layer (Entities)          │  ← Business Rules & Use Cases
├─────────────────────────────────────────┤
│         Data Layer (Repositories)        │  ← Data Sources & Mapping
├─────────────────────────────────────────┤
│    Remote/Local Data Sources (Firebase) │  ← Actual Data Access
└─────────────────────────────────────────┘
```

### **Key Design Patterns Used**
- **BLoC Pattern** - State management and business logic separation
- **Repository Pattern** - Abstract data sources for flexibility
- **Dependency Injection** - Using GetIt for service locator
- **Entity-Model-DTO** - Clear data transformation layers
- **Use Cases** - Single responsibility principle for business logic
- **Sealed Classes & Pattern Matching** - Type-safe state handling

---

## 📂 **Project Structure**

```
lib/
├── main.dart                                    # App entry point
├── main_injection_container.dart                # Dependency Injection setup
│
├── features/
│   │
│   ├── app/                                    # App-wide configuration
│   │   ├── global/
│   │   │   ├── widgets/                        # Reusable app widgets
│   │   │   │   ├── profile_widget.dart
│   │   │   │   └── custom_widgets.dart
│   │   │   └── constants/
│   │   │       └── page_const.dart              # Route constants
│   │   ├── theme/
│   │   │   └── style.dart                      # App colors, typography
│   │   ├── splash/
│   │   │   └── splash_screen.dart
│   │   └── home/
│   │       └── contact_page.dart               # Contacts list
│   │
│   ├── chat/ (Core Feature)                   # Messaging system
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── chat_entity.dart            # Chat conversation model
│   │   │   │   └── message_entity.dart         # Message data model
│   │   │   ├── repositories/
│   │   │   │   └── chat_repository.dart        # Repository interface
│   │   │   └── use_cases/
│   │   │       ├── send_message_usecase.dart
│   │   │       ├── get_messages_usecase.dart
│   │   │       ├── delete_message_usecase.dart
│   │   │       └── delete_chat_usecase.dart
│   │   ├── data/
│   │   │   ├── data_sources/
│   │   │   │   ├── remote/                     # Firebase data source
│   │   │   │   └── local/                      # Local cache (optional)
│   │   │   ├── models/
│   │   │   │   ├── chat_model.dart
│   │   │   │   └── message_model.dart
│   │   │   └── repositories_impl/
│   │   │       └── chat_repository_impl.dart
│   │   └── presentation/
│   │       ├── bloc/                           # BLoC state management
│   │       │   ├── chat_bloc.dart
│   │       │   └── message_bloc.dart
│   │       ├── cubit/
│   │       │   └── chat_cubit.dart
│   │       ├── pages/
│   │       │   └── single_chat_page.dart      # Individual chat screen
│   │       └── widgets/
│   │           ├── chat_bubble.dart
│   │           ├── message_input.dart
│   │           └── attachment_menu.dart
│   │
│   ├── call/                                   # Voice & video calls
│   │   ├── domain/
│   │   ├── data/
│   │   └── presentation/
│   │
│   ├── status/                                 # Status/Stories feature
│   │   ├── domain/
│   │   ├── data/
│   │   └── presentation/
│   │
│   └── user/                                   # User management
│       ├── domain/
│       │   ├── entities/
│       │   │   ├── user_entity.dart
│       │   │   └── contact_entity.dart
│       │   └── repositories/
│       ├── data/
│       │   ├── data_sources/
│       │   │   ├── remote/
│       │   │   │   └── user_remote_data_source_impl.dart
│       │   │   └── local/
│       │   ├── models/
│       │   │   └── user_model.dart
│       │   └── repositories_impl/
│       └── presentation/
│           ├── cubit/
│           │   ├── user_cubit.dart
│           │   └── get_single_user_cubit.dart
│           ├── pages/
│           └── widgets/
│
├── routes/
│   └── on_generate_routes.dart                 # Navigation routing
│
├── storage/                                    # Local storage helpers
│   └── local_storage.dart
│
├── pages/                                      # Shared pages
│   └── home_page.dart
│
└── assets/                                     # Images, fonts, etc.
    ├── images/
    └── fonts/
```

---

## 🛠️ **Tech Stack**

### **Mobile Framework**
| Technology | Version | Purpose |
|-----------|---------|---------|
| ![Flutter](https://img.shields.io/badge/Flutter-3.10%2B-blue) | 3.10.1+ | Cross-platform mobile framework |
| ![Dart](https://img.shields.io/badge/Dart-3.1%2B-blue) | 3.1.0+ | Programming language |

### **Backend & Database**
| Package | Version | Purpose |
|---------|---------|---------|
| `firebase_core` | 4.5.0+ | Firebase initialization |
| `cloud_firestore` | 6.1.2+ | Real-time NoSQL database |
| `firebase_auth` | 6.1.4+ | User authentication |
| `firebase_storage` | 13.0.6+ | File and media storage |

### **State Management & Architecture**
| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_bloc` | 8.1.6+ | BLoC pattern implementation |
| `bloc` | 8.1.0+ | Core BLoC library |
| `equatable` | 2.0.8+ | Value equality comparison |
| `get_it` | 9.2.0+ | Dependency injection service locator |

### **Media & Files**
| Package | Version | Purpose |
|---------|---------|---------|
| `flutter_sound` | 9.13.0+ | Audio recording and playback |
| `image_picker` | Latest | Gallery and camera image selection |
| `video_player` | 2.10.1+ | Video playback |
| `file_picker` | 8.0.0+ | File selection from device |
| `just_audio` | 0.9.34+ | Advanced audio playback |
| `audio_session` | 0.1.16+ | Audio session management |

### **UI & Media Components**
| Package | Version | Purpose |
|---------|---------|---------|
| `emoji_picker_flutter` | Latest | Rich emoji selection widget |
| `cached_network_image` | 3.4.1+ | Image caching and loading |
| `flutter_contacts` | 1.1.9 | Device contact synchronization |
| `font_awesome_flutter` | 10.12.0+ | Icon library |
| `country_pickers` | 3.0.1+ | Country code picker |

### **Utilities & Helpers**
| Package | Version | Purpose |
|---------|---------|---------|
| `intl` | 0.19.0+ | Internationalization & date formatting |
| `timeago` | 3.6.0+ | Relative time formatting |
| `path_provider` | 2.1.0+ | Device paths and directories |
| `shared_preferences` | Latest | Local preference storage |
| `fluttertoast` | 9.0.0+ | Toast notifications |

---

## ✅ **Prerequisites**

Before you begin, ensure you have the following installed and configured:

### **System Requirements**
- **Operating System**: Windows, macOS, or Linux
- **RAM**: Minimum 8GB (16GB recommended)
- **Disk Space**: At least 5GB free
- **Internet**: Required for Firebase setup

### **Development Tools**
- ✅ Flutter SDK 3.10.1 or higher ([Download](https://flutter.dev/docs/get-started/install))
- ✅ Dart SDK (included with Flutter)
- ✅ Android Studio / Xcode for emulator/simulator
- ✅ Git for version control
- ✅ VS Code or Android Studio with Flutter extensions

### **Mobile Targets**
- **Android**: API level 21+ (Android 5.0)
- **iOS**: iOS 11.0 or higher
- **Web**: Chrome, Firefox, Safari (experimental)

### **Firebase Setup**
- ✅ Firebase Project created ([Firebase Console](https://console.firebase.google.com))
- ✅ Firestore Database enabled
- ✅ Authentication enabled (Email/Phone)
- ✅ Storage bucket configured
- ✅ Google credentials downloaded

### **Verify Installation**
```bash
# Check Flutter installation
flutter doctor -v

# Output should show:
# ✓ Flutter (version 3.10.1 or higher)
# ✓ Dart (version 3.1.0 or higher)
# ✓ Android SDK
# ✓ Xcode (for iOS)
```

---

## � **Installation & Setup**

### **Step 1: Clone the Repository**

```bash
# Clone with HTTPS
git clone https://github.com/yourusername/whatapp_clone.git
cd whatapp_clone

# Or clone with SSH
git clone git@github.com:yourusername/whatapp_clone.git
cd whatapp_clone
```

### **Step 2: Install Dependencies**

```bash
# Get Flutter packages
flutter pub get

# (Optional) Clean and get fresh dependencies
flutter clean
flutter pub get
```

### **Step 3: Firebase Configuration**

#### **Android Setup:**
```bash
# 1. Download google-services.json from Firebase Console
# 2. Place it in: android/app/google-services.json
# 3. Verify the file path matches:

ls -la android/app/google-services.json
```

#### **iOS Setup:**
```bash
# 1. Download GoogleService-Info.plist from Firebase Console
# 2. In Xcode: right-click Runner folder → Add Files
# 3. Select GoogleService-Info.plist
# 4. Ensure it's added to Runner target
```

#### **Firebase Console Configuration:**
In your [Firebase Console](https://console.firebase.google.com):

1. **Create Firestore Database**
   - Select "Test mode" for development
   - Choose your region (closest to your users)

2. **Enable Authentication**
   - Go to Authentication → Sign-in method
   - Enable: Email/Password, Google, Phone

3. **Configure Firestore Rules** (Test Mode)
   ```javascript
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       match /{document=**} {
         allow read, write: if request.auth != null;
       }
     }
   }
   ```

4. **Setup Cloud Storage**
   - Create a bucket in Storage
   - Update security rules similarly

### **Step 4: Configure App Permissions**

#### **Android Permissions:**
Already configured in `android/app/src/main/AndroidManifest.xml`:
- ✅ READ_CONTACTS / WRITE_CONTACTS
- ✅ RECORD_AUDIO
- ✅ CAMERA
- ✅ INTERNET
- ✅ ACCESS_NETWORK_STATE
- ✅ BLUETOOTH

#### **iOS Permissions:**
Edit `ios/Runner/Info.plist`:
```xml
<key>NSCameraUsageDescription</key>
<string>We need camera access to take photos and videos</string>

<key>NSMicrophoneUsageDescription</key>
<string>We need microphone access for audio messages</string>

<key>NSContactsUsageDescription</key>
<string>We need access to your contacts</string>

<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to your photos</string>
```

### **Step 5: Run the Application**

#### **Run on Android Emulator:**
```bash
# Start emulator
emulator -avd YourEmulatorName

# Run app
flutter run

# Or specify device
flutter run -d emulator-5554
```

#### **Run on iOS Simulator:**
```bash
# Start simulator
open -a Simulator

# Run app
flutter run

# Or with specific device
flutter run -d iPhone\ 15
```

#### **Run on Physical Device:**
```bash
# List connected devices
flutter devices

# Run on specific device
flutter run -d <DEVICE_ID>
```

#### **Run with Enhanced Logging:**
```bash
# Verbose mode for debugging
flutter run -v

# Release build (optimized)
flutter run --release
```

---

## 📱 **Usage Guide**

### **First Launch**
1. Complete the Splash Screen
2. Grant necessary permissions when prompted
3. Sign up with email or phone number
4. Complete your user profile (name, avatar, bio)
5. Access contacts and start messaging

### **Sending Messages**

#### **Text Messages**
1. Select a contact or existing chat
2. Type in the message input field
3. Tap the blue send button ➡️
4. Message will sync to Firestore in real-time

#### **Voice Messages**
1. Long-press the microphone icon 🎤
2. Record your message
3. Release to send automatically
4. Or tap ✓ to send, ✕ to cancel

#### **Media Messages**

| Action | Steps |
|--------|-------|
| **Photo** | Tap 📎 → Camera/Gallery → Select → Send |
| **Video** | Tap 📎 → Video → Record/Select → Send |
| **Audio** | Tap 📎 → Audio → Record → Send |
| **Document** | Tap 📎 → Files → Select PDF/Word → Send |
| **Location** | Tap 📎 → Location → Share → Send |
| **Contact** | Tap 📎 → Contact → Select → Send |
| **GIF** | Tap 📎 → GIF → Search → Select → Send |
| **Poll** | Tap 📎 → Poll → Create options → Send |

### **Message Interactions**

#### **Swipe Actions**
- **Swipe Right** → Reply to specific message
- **Swipe Left** → Mark as important/pin

#### **Long Press Menu**
- Copy message text
- Delete message
- Forward to another chat
- React with emoji
- Select multiple messages
- Mark as unread

#### **Message Status**
- ✓ **Single Tick** - Sent to server
- ✓✓ **Double Tick** - Delivered to device
- ✓✓👁️ **Blue Double Tick** - Seen by recipient

### **Contact Management**

#### **Finding Contacts**
1. Go to Contacts tab
2. Search by name or phone number
3. Tap contact to start conversation
4. System automatically filters out your own contact

#### **Contact Details**
- View user profile and status
- See when they were last active
- Block/unblock contact
- View shared media

### **Profile Management**

#### **Edit Profile**
1. Tap your profile picture in home
2. Select "Edit Profile"
3. Update:
   - Name
   - Bio/Status
   - Avatar/Photo
   - Phone number
4. Changes sync to Firestore automatically

#### **User Status**
- Online (green dot)
- Away (gray)
- Offline (no indicator)

---

## ⚙️ **Configuration**

### **App Configuration Files**

#### **firebase.json**
```json
{
  "firestore": {
    "rules": "firestore.rules",
    "indexes": "firestore.indexes.json"
  },
  "hosting": {
    "public": "build/web",
    "ignore": ["firebase.json", "**/.*", "**/node_modules/**"],
    "redirects": [
      { "source": "/", "destination": "/index.html", "type": 301 }
    ]
  }
}
```

#### **Theme Customization (style.dart)**
```dart
// Edit colors in lib/features/app/theme/style.dart
const Color tabColor = Color.fromARGB(255, 31, 44, 52);
const Color textColor = Color.fromARGB(255, 241, 241, 242);
const Color appBarColor = Color.fromARGB(255, 31, 44, 52);

// Customize message bubble colors
const Color senderBubbleColor = Color.fromARGB(255, 31, 111, 79);
const Color receiverBubbleColor = Color.fromARGB(255, 37, 45, 50);
```

#### **Environment Variables**
Create `.env` file in project root:
```env
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_API_KEY=your-api-key
FIREBASE_MESSAGING_SENDER_ID=your-sender-id
DEBUG_MODE=true
```

### **Platform-Specific Configurations**

#### **Android Configuration (build.gradle)**
```gradle
android {
    compileSdk 34
    minSdkVersion 21
    targetSdkVersion 34
    
    // Enable multidex if needed
    multiDexEnabled true
}
```

#### **iOS Configuration (Podfile)**
```ruby
platform :ios, '11.0'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
  end
end
```

---

## 👨‍💻 **Development**

### **Code Style & Standards**

#### **Dart Analysis**
```bash
# Run code analysis
flutter analyze

# Fix common issues automatically
dart fix --apply
```

#### **Code Formatting**
```bash
# Format all Dart files
dart format lib/

# Format specific file
dart format lib/main.dart
```

### **Testing** (Optional)

```bash
# Run unit tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/widget_test.dart
```

### **Building for Production**

#### **Android APK**
```bash
# Build app bundle (recommended for Play Store)
flutter build appbundle

# Build APK
flutter build apk --release
```

#### **iOS App**
```bash
# Build for iOS
flutter build ios

# Build IPA for App Store
flutter build ipa
```

#### **Web**
```bash
# Build for web
flutter build web --release

# Serve locally
flutter run -d chrome
```

### **Git Workflow**

```bash
# Create feature branch
git checkout -b feature/new-feature

# Make changes and commit
git add .
git commit -m "feat: Add new feature description"

# Push changes
git push origin feature/new-feature

# Create pull request on GitHub
```

---

## 🐛 **Troubleshooting**

### **Common Issues & Solutions**

#### **Issue: "No Android devices found"**
```bash
# Solution: Start emulator first
emulator -avd YourEmulatorName

# Or list available devices
flutter devices
adb devices
```

#### **Issue: "Flutter SDK not found"**
```bash
# Solution: Add Flutter to PATH
export PATH="$PATH:`pwd`/flutter/bin"

# Or run Flutter doctor
flutter doctor --verbose
```

#### **Issue: "Gradle build failed"**
```bash
# Solution: Clean and rebuild
flutter clean
flutter pub get
flutter run

# Or update Gradle dependencies
cd android
./gradlew --version
```

#### **Issue: "Firebase connection failed"**
```bash
# Verify google-services.json is in correct location
ls -la android/app/google-services.json

# Check your internet connection
ping firebase.google.com
```

#### **Issue: "Permission denied errors"**
```bash
# Grant permissions on physical device
adb shell pm grant com.example.whatapp_clone android.permission.RECORD_AUDIO
adb shell pm grant com.example.whatapp_clone android.permission.CAMERA
```

#### **Issue: "Hot reload not working"**
```bash
# Use hot restart instead
r # Hot reload
R # Hot restart (rebuilds app state)
```

### **Debug Logging**

```bash
# Enable verbose logging
flutter run -v

# Search for specific errors
flutter run 2>&1 | grep "ERROR"

# Save logs to file
flutter run > app.log 2>&1
```

### **Performance Issues**

```bash
# Profile the app
flutter run --profile

# Check for memory leaks
flutter run --track-widget-creation

# Monitor performance in DevTools
flutter pub global activate devtools
devtools
```

---

## 🚧 **Work in Progress Features**

The following features are in development or ready for implementation:

### **Planned Features**
- 🎙️ **Voice Calls** - Complete Agora/Twilio integration
- 📹 **Video Calls** - Real-time video conferencing
- 🔐 **E2E Encryption** - End-to-end message encryption
- 📲 **Push Notifications** - Firebase Cloud Messaging
- 🔍 **Message Search** - Full-text search in conversations
- 📍 **Advanced Location Sharing** - Real-time location tracking
- 🔗 **Message Links** - Preview URLs shared in chat
- ⭐ **Message Reactions** - Emoji reactions to messages
- 📁 **File Sharing** - Larger file support with compression
- 🌐 **Message Translation** - Real-time message translation

---

## 💡 **Best Practices Implemented**

### **Code Quality**
✅ Clean Architecture with separation of concerns
✅ BLoC pattern for state management
✅ Repository pattern for data abstraction
✅ Dependency injection for loose coupling
✅ Use cases for business logic encapsulation
✅ Entity-Model-DTO transformation layers
✅ Comprehensive error handling

### **Performance**
✅ Lazy loading of conversations and messages
✅ Image and video caching
✅ Efficient Firestore queries with pagination
✅ Optimized re-renders with BLoC
✅ Background data sync
✅ Memory-efficient media handling

### **Security**
✅ Firebase Authentication
✅ Firestore Security Rules
✅ Secure credential storage
✅ HTTPS/SSL for all connections
✅ Input validation and sanitization
✅ Protected API endpoints

---

## 📊 **Database Schema (Firestore)**

### **Collections Structure**

```
firestore /
├── users/
│   ├── {uid}/
│   │   ├── username: string
│   │   ├── email: string
│   │   ├── phoneNumber: string
│   │   ├── profileUrl: string
│   │   ├── status: string
│   │   ├── isOnline: boolean
│   │   ├── lastActive: timestamp
│   │   └── createdAt: timestamp
│
├── chats/
│   ├── {chatId}/
│   │   ├── senderUid: string
│   │   ├── recipientUid: string
│   │   ├── senderName: string
│   │   ├── recipientName: string
│   │   ├── senderProfile: string
│   │   ├── recipientProfile: string
│   │   ├── recentMessage: string
│   │   ├── createdAt: timestamp
│   │   └── updatedAt: timestamp
│
└── messages/
    ├── {chatId}/
    │   ├── {messageId}/
    │   │   ├── senderUid: string
    │   │   ├── recipientUid: string
    │   │   ├── message: string
    │   │   ├── messageType: string (text/image/audio/video)
    │   │   ├── isSeen: boolean
    │   │   ├── createdAt: timestamp
    │   │   ├── mediaUrl: string (optional)
    │   │   └── repliedTo: string (optional)
```

---

## 📚 **API & Services Documentation**

### **Firebase Services Used**

#### **Authentication (Firebase Auth)**
```dart
// Sign up
await FirebaseAuth.instance.createUserWithEmailAndPassword(
  email: email,
  password: password,
);

// Sign in
await FirebaseAuth.instance.signInWithEmailAndPassword(
  email: email,
  password: password,
);

// Get current user
final user = FirebaseAuth.instance.currentUser;
```

#### **Database (Firestore)**
```dart
// Send message
await FirebaseFirestore.instance
    .collection('messages')
    .doc(chatId)
    .collection(chatId)
    .add(messageData);

// Listen to messages
FirebaseFirestore.instance
    .collection('messages')
    .doc(chatId)
    .collection(chatId)
    .orderBy('createdAt')
    .snapshots();
```

#### **Storage (Firebase Storage)**
```dart
// Upload file
await FirebaseStorage.instance
    .ref()
    .child('messages/$messageId')
    .putFile(file);

// Download file
final url = await FirebaseStorage.instance
    .ref('messages/$messageId')
    .getDownloadURL();
```

---

## 🤝 **Contributing**

Contributions are welcome! Please follow these guidelines:

### **How to Contribute**

1. **Fork** the repository
   ```bash
   git clone https://github.com/yourusername/whatapp_clone.git
   cd whatapp_clone
   ```

2. **Create a Feature Branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```

3. **Make Your Changes**
   - Follow the existing code style
   - Add comments for complex logic
   - Keep commits atomic and meaningful
   ```bash
   git add .
   git commit -m "feat: Add amazing feature description"
   ```

4. **Push to Your Fork**
   ```bash
   git push origin feature/amazing-feature
   ```

5. **Submit a Pull Request**
   - Describe changes clearly
   - Reference any related issues
   - Include screenshots if UI changes

### **Contribution Guidelines**
- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Write meaningful commit messages
- Test your changes before submitting
- Update documentation if needed
- Be respectful and constructive

---

## 📄 **License**

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2024 Flutter Developer

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software...
```

---

## 👨‍💻 **Author**

**Flutter Developer**
- 🔗 Developed as a showcase of clean architecture and modern Flutter development
- ⭐ Learning project demonstrating best practices
- 📧 For questions or suggestions, feel free to open an issue

---

## ❤️ **Support & Acknowledgments**

### **Give a Star!** ⭐
If this project helped you, please give it a star on GitHub!

### **Technologies Used**
- Flutter & Dart Team
- Firebase Team
- Open-source community

### **Resources & References**
- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Dart Language Guide](https://dart.dev/guides)
- [Clean Architecture](https://resocoder.com/flutter-clean-architecture)
- [BLoC Library](https://bloclibrary.dev)

---

## 📞 **Contact & Support**

### **Report Bugs**
Found a bug? [Create an issue](https://github.com/yourusername/whatapp_clone/issues)

### **Feature Requests**
Have an idea? [Start a discussion](https://github.com/yourusername/whatapp_clone/discussions)

### **Questions?**
Ask in the [Q&A section](https://github.com/yourusername/whatapp_clone/discussions/categories/q-a)

---

<div align="center">

### **Made with ❤️ by Flutter Developers**

**[Give a Star!](https://github.com/yourusername/whatapp_clone)** • **[Follow](https://github.com/yourusername)** • **[Fork](https://github.com/yourusername/whatapp_clone/fork)**

**Happy Coding! 🚀**

</div>
