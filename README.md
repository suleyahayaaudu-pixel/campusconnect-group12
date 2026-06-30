# CampusConnect

## CSE 413 – Mobile Application Development (Android/iOS)

CampusConnect is a mobile application developed by **Group 12** of the Department of Software Engineering, Federal University Dutse, as part of the requirements for the **CSE 413 Mobile Application Development (Android/iOS)** course.

The application was developed using Flutter to demonstrate the practical implementation of cross-platform mobile application development. The project integrates several campus services into a single application to improve communication, information sharing, and access to important student services.

---

# Project Information

**Project Title:** CampusConnect

**Course:** CSE 413 – Mobile Application Development (Android/iOS)

**Department:** Software Engineering

**Institution:** Federal University Dutse

**Academic Session:** 2025/2026

**Group:** 12

---

# Group Members

| Name | Registration Number |
|------|----------------------|
| Yahaya Sule Audu | FCP/CSE/23/2009 |
| Habibu Adamu Muhammad | FCP/CSE/22/1024 |
| Yusuf Sulaiman Imam | FCP/CSE/22/1071 |

---

# Project Overview

CampusConnect provides a centralized platform where students can access different campus services from one application instead of using multiple independent systems.

The application demonstrates the implementation of authentication, messaging, notifications, scheduling, attendance management, marketplace services, offline data storage, location services, and REST API communication using Flutter.

The project also demonstrates state management, cloud integration, local database management, responsive interface design, and modular application development.

---

# Objectives

The objectives of this project include:

- Develop a cross-platform mobile application using Flutter.
- Demonstrate Firebase Authentication.
- Implement cloud database integration using Cloud Firestore.
- Demonstrate local data storage using SQLite.
- Implement REST API communication.
- Demonstrate Provider state management.
- Build a modular application architecture.
- Design a responsive and user-friendly interface.
- Provide offline support.
- Demonstrate Android and Web deployment.

---

# Features

The application currently includes the following modules:

## Authentication

- User login
- Authentication interface
- Session management

## Dashboard

- Central navigation page
- Quick access cards
- Responsive design

## Messaging

- Chat interface
- Message sending
- Typing indicator
- Read status

## Notifications

- Campus announcements
- Notification display
- Alert management

## Smart Scheduling

- Timetable display
- Academic schedule
- Upcoming activities

## Marketplace

- Product listing
- Marketplace interface
- Campus items

## Attendance

- Attendance records
- Attendance status
- Student attendance management

## Offline Support

- Local SQLite database
- Cached records
- Offline storage

## API Services

- HTTP communication
- REST API integration
- Data retrieval

## Location Services

- Campus location
- Google Maps support
- Navigation interface

---

# Technologies Used

| Technology | Purpose |
|------------|---------|
| Flutter | Cross-platform development |
| Dart | Programming language |
| Firebase Authentication | User authentication |
| Cloud Firestore | Cloud database |
| SQLite (sqflite) | Offline storage |
| Provider | State management |
| HTTP | REST API communication |
| Flutter Local Notifications | Notification services |
| Google Maps Flutter | Location services |
| Connectivity Plus | Network monitoring |

---

# Project Structure

```
lib/
│
├── assets/
├── config/
├── models/
├── providers/
├── screens/
│   ├── api/
│   ├── attendance/
│   ├── auth/
│   ├── home/
│   ├── location/
│   ├── marketplace/
│   ├── messaging/
│   ├── notifications/
│   ├── offline/
│   └── scheduling/
│
├── services/
└── main.dart
```

---

# System Architecture

The application follows a modular architecture.

```
Flutter UI
      │
Provider
      │
───────────────
Firebase
SQLite
REST API
```

Firebase handles authentication and cloud data.

SQLite is used for local offline storage.

REST API is used for backend communication.

---

# Installation

Clone the repository.

```bash
git clone https://github.com/suleyahayaaudu-pixel/campusconnect-group12.git
```

Move into the project directory.

```bash
cd campusconnect-group12
```

Install dependencies.

```bash
flutter pub get
```

Run the application.

```bash
flutter run
```

---

# Screenshots

The application includes the following interfaces:

- Login Screen
- Dashboard
- Messaging
- Notifications
- Scheduling
- Marketplace
- Attendance
- Offline Support
- API Services
- Location Services

Sample screenshots are included in the project documentation.

---

# Challenges Encountered

During the development of this project, several challenges were encountered, including:

- Firebase configuration.
- Android emulator setup.
- SQLite compatibility with Flutter Web.
- Runtime configuration validation.
- GitHub repository synchronization.

These issues were resolved through testing, debugging, and project configuration updates.

---

# Future Improvements

Possible future improvements include:

- Complete Google Maps navigation.
- Push notification support.
- QR Code attendance.
- Student profile management.
- Course registration.
- Timetable synchronization.
- Online payment integration.

---

# Repository

GitHub Repository:

https://github.com/suleyahayaaudu-pixel/campusconnect-group12

---

# License

This project was developed strictly for academic purposes as part of the CSE 413 Mobile Application Development course offered by the Department of Software Engineering, Federal University Dutse.