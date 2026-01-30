# WhatsApp Clone

A feature-rich Flutter messaging application that replicates the core functionality of WhatsApp. This project demonstrates modern mobile app development practices with Firebase integration, real-time messaging, and media sharing capabilities.

## 🚀 Features

### Core Messaging
- **Real-time Messaging** - Send and receive messages instantly using Cloud Firestore
- **Message Status** - View message delivery status (sent, delivered, seen)
- **Emoji Support** - Integrated emoji picker for expressive messaging
- **Message Timestamps** - Display when messages were sent with formatted time

### Media & Attachments
- **Photo Sharing** - Share images from gallery or capture directly
- **Document Sharing** - Send various document types
- **Audio Messages** - Record and share audio messages using Flutter Sound
- **Video Support** - Share and play video content
- **Camera Integration** - Direct camera access for photos and videos

### User Interface
- **Modern Chat Interface** - Clean, intuitive UI inspired by WhatsApp
- **Swipe Actions** - Swipe to reply functionality on messages
- **Long Press Menu** - Context menu for message actions
- **Dark Theme** - Professional dark theme throughout the app
- **Responsive Design** - Works seamlessly across different screen sizes

### Additional Features
- **User Profiles** - View and manage user information
- **Status Updates** - Share status stories like WhatsApp
- **Call Features** - Voice and video call interfaces (ready for implementation)
- **Contact Management** - Access device contacts for easy messaging
- **Location Sharing** - Share location with contacts

## 📁 Project Structure

```
lib/
├── main.dart                          # App entry point
├── features/
│   ├── app/                          # App configuration & theme
│   │   ├── theme/
│   │   │   └── style.dart           # App colors and styling
│   │   └── splash/
│   │       └── splash_screen.dart    # Splash screen
│   ├── chat/                         # Chat messaging feature
│   │   └── presentation/
│   │       └── pages/
│   │           └── single_chart_page.dart  # Individual chat screen
│   ├── call/                         # Voice & video calls
│   ├── status/                       # Status stories feature
│   └── user/                         # User profile management
├── routes/
│   └── on_generate_routes.dart      # Route navigation configuration
└── assets/                           # Images and app resources
```

## 🛠️ Tech Stack

### Framework & Language
- **Flutter** 3.10.1+ - Cross-platform mobile framework
- **Dart** - Programming language

### Key Dependencies
- **cloud_firestore: ^6.1.2** - Real-time database and backend
- **flutter_sound: ^9.13.0** - Audio recording and playback
- **image_picker: ^1.0.0** - Image selection from device
- **emoji_picker_flutter: ^2.0.0** - Emoji selection widget
- **swipe_to: ^1.0.6** - Swipe gesture animations
- **video_player: ^2.10.1** - Video playback
- **intl: ^0.19.0** - Internationalization and date formatting
- **file_picker: ^8.0.0** - File selection from device
- **just_audio: ^0.9.34** - Audio playback control
- **bloc: ^8.1.0** - State management (partially integrated)

## 📋 Prerequisites

Before running this project, ensure you have:

- **Flutter SDK** 3.10.1 or higher installed
- **Dart SDK** included with Flutter
- A **Firebase Project** set up with Cloud Firestore
- **Android Studio** or **Xcode** for building on Android/iOS
- Android API level 21+ or iOS 11+

## 🔧 Installation & Setup

### 1. Clone the Repository
```bash
git clone <repository-url>
cd whatapp_clone
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Configure Firebase

#### For Android:
1. Download `google-services.json` from Firebase Console
2. Place it in `android/app/` directory

#### For iOS:
1. Download `GoogleService-Info.plist` from Firebase Console
2. Add it to the Xcode project in `ios/Runner/`

### 4. Enable Firestore & Authentication
In your Firebase Console:
- Enable Cloud Firestore
- Set up security rules for development
- Enable any additional services needed (Authentication, Storage)

### 5. Run the Application
```bash
flutter run
```

## 📱 Usage

### Starting a Chat
1. Navigate to the chat list
2. Select a contact or start a new conversation
3. Type your message and tap send or hold for voice message

### Sending Media
1. Tap the attachment button (📎) in the message input area
2. Choose from available options:
   - Document - Send files
   - Camera - Take a photo/video
   - Gallery - Select from device storage
   - Audio - Record audio message
   - Location - Share your location
   - Contact - Share a contact
   - Poll - Create a poll
   - GIF - Search and send GIFs
   - Video - Share video files

### Message Interactions
- **Swipe Right** - Reply to a specific message
- **Long Press** - View message options
- **Tap Send Icon** - Send text message
- **Hold Mic Icon** - Record voice message

## 🚧 Work in Progress

This project includes features that are ready for implementation:
- Complete call functionality (audio/video)
- Advanced state management with BLoC
- Message encryption
- Database synchronization improvements
- Push notifications
- Message search

## 🎨 Customization

### Theme Colors
Edit `lib/features/app/theme/style.dart` to customize:
- Background colors
- AppBar styling
- Chat bubble colors
- Accent colors

### Firebase Configuration
Update Firebase settings in your `firebase.json` and initialize files for your project credentials.

## 📝 Notes

- Messages are stored in Cloud Firestore
- The app uses a dark theme for better user experience
- Audio files are stored in device storage via `path_provider`
- Images and videos are handled through `image_picker`

## 🤝 Contributing

Feel free to fork this project and submit pull requests for any improvements.

## 📄 License

This project is open source and available under the MIT License.

## 👨‍💻 Author

Created as a learning project to demonstrate Flutter development with Firebase integration.

## 📞 Support

For issues or questions, please create an issue in the repository.

---

**Happy Chatting!** 💬✨
