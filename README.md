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

| Onboarding | Register | Sign In |
|:---:|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/c4d652dc-d878-43bc-ab79-863a63d5f751" height="300"/> | <img src="https://github.com/user-attachments/assets/d92d813c-d0c8-476e-a1d3-b35e319ee2e7" height="300"/> | <img src="https://github.com/user-attachments/assets/5d276fa7-739e-4223-bc91-c883d668a510" height="300"/> |

| Password | Quiz Topics | Question Screen |
|:---:|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/710ae866-6ac9-4164-8804-456adcce29db" height="300"/> | <img src="https://github.com/user-attachments/assets/bad56253-8e5d-4a77-8ee8-6a30f2624203" height="300"/> | <img src="https://github.com/user-attachments/assets/eb34bb48-cbe5-402f-894c-11e7640554f8" height="300"/> |

| Results | Score Summary | Updated |
|:---:|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/91e46dbf-71de-4ba9-8390-ca1c99f50301" height="300"/> | <img src="https://github.com/user-attachments/assets/1af76ac7-fbf4-4c84-b20f-f71cbc9fe175" height="300"/> | <img src="https://github.com/user-attachments/assets/f76878ab-ff7c-47c6-adb9-a993eab0379f" height="300"/> |

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

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

1. Fork the repository
2. Create a new branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m 'Add your feature'`
4. Push to the branch: `git push origin feature/your-feature`
5. Open a Pull Request

---
