# Renewal Mate

Renewal Mate is an Android application designed to streamline deadline management for subscriptions, warranties, and important dates. This app provides a centralized platform to store and receive reminders for various deadlines while incorporating secure authentication methods.

## Project Overview

- **Project Name:** Renewal Mate
- **Author:** [B.Sashank Reddy]
- **Student ID:** [IMT2020542]

## Project Description

Renewal Mate serves as a comprehensive Android app prioritizing user privacy and efficient deadline management. Key functionalities include user registration/authentication, deadline entry management, and organized reminders. Users can access multiple authentication methods linked to a single account, enhancing flexibility.

## Features

### Authentication

- Email/Password authentication
- Google OAuth
- Facebook OAuth

### OAuth Integration

- Firebase Authentication for token-based OAuth with Google and Facebook
- Secure token exchange mechanisms ensuring data privacy and integrity

### Cross-Authentication

- Link multiple authentication methods to a single account
- Seamless login via email/password, Gmail, or Facebook

## Problem Definition

OAuth, or Open Authorization, secures access to user resources on servers without revealing credentials. The OAuth flow involves client registration, authorization requests, consent screens, and token exchange mechanisms.

## App Screens

### Login/Register Screen

- Email/password login and registration
- Social media login buttons (Google and Facebook)

### Home Screen

- Calendar view for date selection
- Entry creation and viewing options
- Navigation drawer for app sections

### Deadline Entry Details Screen

- Display of deadline details and metadata
- Navigation to the home screen

### Create Deadline Entry Screen

- Input fields for deadline details and metadata
- Save and cancel options

### User Profile Screen

- Display user information and profile picture
- Buttons to link social media accounts
- Logout option

## Setting Up OAuth

### Google

- Create a Google Sign-In Project
- Enable Google Sign-In in the Firebase console

### Facebook

- Create a Facebook app
- Enable Facebook Sign-In in the Firebase console

## Development Environment

### Tech Stack

- Flutter
- Dart
- Firebase (Authentication and Firestore)
- Facebook API

### IDE

- Visual Studio Code (VSCode)

### Testing Environment

- Android simulator

## Setting Up App

### To set up and run the app:

1. Install Flutter by following the official installation guide.
2. Install dependencies by running `flutter pub get` in the terminal.
3. Run the app using `flutter run` in the terminal after connecting a device or starting an emulator.

### Explore the Code

- Navigate to the lib directory to explore the source code.
- Modify the code according to your project requirements.

