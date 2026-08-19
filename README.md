# Assignment Tracker (Flutter)

A Flutter app to help students organize academic modules, track assignments, and manage assignment tasks with progress visibility.

---

## ✨ Features

- User authentication (Register, Login, Logout)
- Module management (create and view modules)
- Assignment management
  - Create assignment
  - Edit assignment
  - View assignment list
  - View assignments by module
- Task management inside each assignment
  - Add task
  - Update task
  - Delete task
  - Mark task complete/incomplete
- Assignment progress tracking (percentage and status message)
- Home dashboard summaries
  - Due today
  - Due this week
  - Upcoming assignments
- Calendar view to filter assignments by date
- Profile screen with profile image upload

---

## 🧱 Tech Stack

- **Framework:** Flutter
- **State Management:** Provider
- **Networking:** http
- **Local Storage:** shared_preferences (JWT token persistence)
- **Utilities:** intl, jwt_decoder, image_picker, carousel_slider

---

## 📁 Project Structure

```text
lib/
├── app/                # App root, theme
├── auth/               # Auth gate
├── custom/             # Reusable custom text/form widgets
├── model/              # Data models
├── provider/           # State management (Auth, Module, Assignment, Task, Profile)
├── screens/            # UI screens
├── services/           # API service layer
└── widgets/            # Reusable UI components (cards, etc.)
```

---

## 🔌 Backend Requirement

This app expects a backend running locally at:

- `http://localhost:3000`

Used API routes include:

- `/api/auth/*`
- `/api/module/*`
- `/api/assignment/*`
- `/api/task/*`
- `/api/images/profile-image`

> If running on an Android emulator, `localhost` usually needs to be replaced with `10.0.2.2`.

---

## ✅ Prerequisites

- Flutter SDK installed
- Dart SDK compatible with the project
- A running backend API server on port `3000`

---

## 🚀 Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/Aayush2004-stack/assignment-tracker-flutter.git
   cd assignment-tracker-flutter
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

---

## 🧪 Useful Commands

- Analyze code:
  ```bash
  flutter analyze
  ```
- Run tests:
  ```bash
  flutter test
  ```

---

## 🔐 Authentication Behavior

- JWT token is saved using `shared_preferences`
- App startup checks token presence and expiry (`jwt_decoder`)
- Expired/invalid token routes users back to login

---

## 📌 Notes

- Date input format used in forms: `YYYY-MM-DD`
- Assignment progress is derived from completed tasks vs total tasks
- Profile image upload is supported via multipart request

---

## 👤 Author

**Aayush2004-stack**
