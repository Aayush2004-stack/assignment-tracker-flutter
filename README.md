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
