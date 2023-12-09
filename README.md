# Renewal Mate - Deadline Management Application



## Project Scope

Renewal Mate is an Android application designed as a smart organizer to manage various deadlines, including subscription renewals and warranty expirations. It consolidates and reminds users of these deadlines, ensuring they never miss essential dates. The app offers secure and straightforward login methods, enabling users to sign in through Google or Facebook accounts via OAuth.

## Problem Definition

In today’s digital landscape, individuals struggle to manage diverse deadlines, leading to issues with subscription renewals, warranty expirations, and other time-sensitive commitments. Managing multiple passwords across different platforms and concerns about insecure login systems raise data security concerns.

OAuth stands as a solution for secure and seamless authentication across various applications. Its core goal is to enable users to grant limited access to their resources to other applications without revealing their login credentials. This authorization framework ensures secure and standardized authentication and authorization methods, enabling third-party applications to access specific resources for a limited duration.

## Project Analysis

### OAuth Setup

#### Google OAuth

Setup involves creating a new project in Google Cloud Console, enabling Google Identity Toolkit API, and integrating Google Authentication Provider in Firebase with the obtained Google Web Client ID.

#### Facebook OAuth

Requires creating a developer account on the Facebook Developer website, setting up a new app, obtaining the App ID and App Secret, and activating Facebook sign-in in Firebase using the acquired credentials.

### Implementation Environment

- **Flutter:** Used as a user-friendly framework for building cross-platform mobile applications.
- **Firebase:** Utilized as the backend database for the Flutter app, providing tools for databases, authentication, hosting, and analytics.
- **VS Code:** Integrated development environment (IDE) with extensive language support and extensions.
- **Android Studio and Emulators:** IDE tailored for Android app development, equipped with code editing, debugging tools, and an integrated emulator for testing.
- **USB Debugging:** Allows direct communication between a computer and an Android device for development purposes.

## Setting Up App

### To set up and run the app:

1. Install Flutter by following the official installation guide.
2. Install dependencies by running `flutter pub get` in the terminal.
3. Run the app using `flutter run` in the terminal after connecting a device or starting an emulator.

### Explore the Code

- Navigate to the lib directory to explore the source code.
- Modify the code according to your project requirements.
