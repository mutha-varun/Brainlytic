# Brainlytic

Brainlytic is a cross-platform quiz application built with Flutter and Firebase. It allows users to test their knowledge across various topics, track their progress, and engage in an interactive learning experience.

## Features

- **Multi-platform Authentication**: Secure and easy sign-in/sign-up process using:
    - Email and Password
    - Google Sign-In
    - GitHub Sign-In
- **Dynamic Quiz Topics**: Quiz categories are loaded dynamically from Firebase Firestore, allowing for easy updates and additions.
- **Interactive Quiz Sessions**: 
    - Questions and options are fetched from the database for each quiz.
    - Real-time feedback on whether an answer is correct or incorrect.
    - A summary screen at the end of each quiz displays the final score.
- **Progress Tracking**: User scores for each quiz are saved to Firestore, with a star rating system displayed on the home screen to visualize progress.
- **User-Friendly Interface**: A clean and intuitive UI with a clear onboarding process, a central home screen for quiz selection, and a focused quiz interface.

## Tech Stack

- **Framework**: Flutter
- **Language**: Dart
- **Backend & Database**:
    - **Firebase Authentication**: For user management and authentication.
    - **Cloud Firestore**: As the NoSQL database for storing quiz questions, topics, and user progress.

## Project Structure

The core application logic is organized within the `lib/` directory:

- `main.dart`: The entry point of the application, handling initialization and routing based on authentication state.
- `screens/auth/`: Contains all UI screens related to user authentication, including onboarding, login, registration, and social sign-in handlers.
- `screens/home/`: Includes the main home screen that users see after logging in, displaying the list of available quiz topics.
- `screens/quiz/`: The interactive quiz page where users answer questions.

## Images

<img src = "https://github.com/user-attachments/assets/c4d652dc-d878-43bc-ab79-863a63d5f751" height="300" width="200">
<img src = "https://github.com/user-attachments/assets/d92d813c-d0c8-476e-a1d3-b35e319ee2e7" height="300" width="200">
<img src="https://github.com/user-attachments/assets/5d276fa7-739e-4223-bc91-c883d668a510" height="300" width="200">
<img src  = "https://github.com/user-attachments/assets/710ae866-6ac9-4164-8804-456adcce29db" height="300" width="200">
<img src = "https://github.com/user-attachments/assets/bad56253-8e5d-4a77-8ee8-6a30f2624203" height="300" width="200">
<img src = "https://github.com/user-attachments/assets/eb34bb48-cbe5-402f-894c-11e7640554f8" height="300" width="200">
<img src= "https://github.com/user-attachments/assets/91e46dbf-71de-4ba9-8390-ca1c99f50301" height = "300" width="200">
<img src= "https://github.com/user-attachments/assets/1af76ac7-fbf4-4c84-b20f-f71cbc9fe175" height = "300" width="200">
<img src = "https://github.com/user-attachments/assets/5f780555-2f1d-4a70-bca9-05921cc1c9e4" height = "300" width="200">



## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) installed on your machine.
- A configured Firebase project.

### Installation

1. **Clone the repository:**
   ```sh
   git clone https://github.com/mutha-varun/Brainlytic.git
   ```

2. **Navigate to the project directory:**
   ```sh
   cd Brainlytic/brainlytic
   ```

3. **Install dependencies:**
   ```sh
   flutter pub get
   ```

4. **Set up Firebase:**
   - Create a new project on the [Firebase Console](https://console.firebase.google.com/).
   - Add an Android, iOS, and Web app to your Firebase project.
   - Follow the Firebase setup instructions and place the generated configuration files in their respective locations:
     - For Android: `android/app/google-services.json`
     - For iOS/macOS: `ios/Runner/GoogleService-Info.plist` & `macos/Runner/GoogleService-Info.plist`
   - Configure the Firestore database and authentication methods (Email/Password, Google, GitHub).

5. **Run the application:**
   ```sh
   flutter run
