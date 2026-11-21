<div align="center">

<img src="https://github.com/user-attachments/assets/2006d0e9-9470-4b51-acb7-3aae6c317939" height="80" alt="Brainlytic Logo"/>

# Brainlytic

**A cross-platform quiz app built with Flutter & Firebase**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Firestore%20%7C%20Auth-FFCA28?logo=firebase&logoColor=black)](https://firebase.google.com)

</div>

---

## 📖 About

Brainlytic is a cross-platform mobile quiz application that lets users test their knowledge across a variety of topics, track their progress with a star rating system, and enjoy a smooth, interactive learning experience — all powered by Firebase on the backend.

---

## ✨ Features

| Feature | Description |
|---|---|
| 🔐 **Multi-provider Auth** | Sign in with Email/Password, Google, or GitHub |
| 📚 **Dynamic Quiz Topics** | Categories fetched live from Firestore — no app update needed to add new topics |
| ❓ **Interactive Quiz Sessions** | Per-question real-time feedback with correct/incorrect highlighting |
| 🏆 **Score Summary** | End-of-quiz results screen with your final score |
| ⭐ **Progress Tracking** | Scores saved to Firestore; star ratings shown on the home screen |
| 🌐 **Cross-platform** | Runs on Android, iOS, and Web from a single codebase |

---

## 📸 Screenshots

<div align="center">

| Initial Screen| Onboarding | Register |
|:---:|:---:|:---:|
| <img src= "https://github.com/user-attachments/assets/ca40b0ba-1d6d-40c1-ac45-6aea76c5ebe2" height="300"/> | <img src="https://github.com/user-attachments/assets/7fc80c8a-e29c-43fd-8896-472d007694ae" height="300"/> | <img src="https://github.com/user-attachments/assets/80c7cdf3-1f8a-4449-8903-cfb40139e0d8" height="300"/> |

| Sign in| Password | Quiz Topics |
|:---:|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/0a754696-07aa-483c-a1b0-192433669fad" height="300"/> | <img src="https://github.com/user-attachments/assets/d13c4626-44f7-421d-9f61-948f463b9a02" height="300"/> | <img src="https://github.com/user-attachments/assets/33c3302b-d9db-44a8-9c94-ba1f59b96870" height="300"/> |

| Question Screen | Results | Score Summary |
|:---:|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/7647f937-e312-4304-9388-10e5d6727cdc" height="300"/> | <img src="https://github.com/user-attachments/assets/b9721596-f71d-4c0b-954b-a2fedebdde92" height="300"/> | <img src="https://github.com/user-attachments/assets/a74e3b53-28f2-495b-8148-51f4d1a0f14e" height="300"/> |

</div>

---

## 🛠 Tech Stack

- **Framework:** Flutter (Dart)
- **Authentication:** Firebase Authentication (Email/Password, Google, GitHub)
- **Database:** Cloud Firestore
- **State Management:** *(in progress)*

---

## 📁 Project Structure

```
brainlytic/
└── lib/
    ├── main.dart               # App entry point; auth-based routing
    ├── screens/
    │   ├── auth/               # Onboarding, login, registration, OAuth handlers
    │   ├── home/               # Home screen — topic listing & star progress
    │   └── quiz/               # Quiz session — questions, feedback, summary
    └── ...
```

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) installed
- A Firebase project set up on the [Firebase Console](https://console.firebase.google.com/)

### Installation

**1. Clone the repository**
```sh
git clone https://github.com/mutha-varun/Brainlytic.git
cd Brainlytic/brainlytic
```

**2. Install dependencies**
```sh
flutter pub get
```

**3. Set up Firebase**

- Create a new project on the [Firebase Console](https://console.firebase.google.com/)
- Add Android, iOS, and Web apps to your project
- Enable **Authentication** methods: Email/Password, Google, and GitHub
- Enable **Cloud Firestore** and set up your database rules
- Download and place the config files:

  | Platform | File | Location |
  |---|---|---|
  | Android | `google-services.json` | `android/app/` |
  | iOS | `GoogleService-Info.plist` | `ios/Runner/` |
  | macOS | `GoogleService-Info.plist` | `macos/Runner/` |

> **Note:** For GitHub Sign-In, you'll also need to configure an OAuth app under your GitHub Developer Settings and add the client ID/secret to Firebase Authentication.

**4. Run the app**
```sh
flutter run
```

---

## 🗃 Firestore Data Structure

Your Firestore database should follow this structure for the app to work correctly:

```
quizzes/                          ← collection
  quiz{Id}/
    title: "Science"
    Questions: "10"
    id: {Id}
    color: 4382f7
    questions/                   ← sub-collection
      {questionId}/
        question: "What is ...?"
        options: ["A", "B", "C", "D"]
        answerIndex: "A"

usersData/                           ← collection
  {uid}/
    quizData/                      ← sub-collection
      quiz{Id}/
        stars: 8
        id: {Id}
```

---
