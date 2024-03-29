# Ponder8 (Smart 8 Ball)


![Powered by firebase](https://img.shields.io/badge/Powered%20by-firebase-yellow?style=for-the-badge&logo=firebase)
![TypeScript](https://img.shields.io/badge/TypeScript-grey?style=for-the-badge&logo=typescript)
![CEL](https://img.shields.io/badge/CEL-grey?style=for-the-badge&logo=google)


![Powered by flutter](https://img.shields.io/badge/Powered%20by-flutter-blue?style=for-the-badge&logo=flutter) 
![Dart](https://img.shields.io/badge/Dart-grey?style=for-the-badge&logo=dart)

![Git Secret](https://img.shields.io/badge/Git%20Secret-Enabled-orange?style=for-the-badge&logo=git)

![Powered by OpenAI](https://img.shields.io/badge/Powered%20by-OpenAI-mediumseagreen?style=for-the-badge&logo=openai) 
![GPT3.5-Turbo](https://img.shields.io/badge/GPT3.5--turbo-grey?style=for-the-badge&logo=openai) 
![Whisper](https://img.shields.io/badge/Whisper-grey?style=for-the-badge&logo=openai)

![Google Ads Enabled](https://img.shields.io/badge/Google%20Ads-Enabled-blue?style=for-the-badge&logo=googleads)


## About

This project is a simple 8Ball that uses AI to answer your questions. Contains firebase cloud setup and flutter application (iOS/ Android).

### Run the project locally

#### Before you start

1. Install [git-secret](https://git-secret.io/installation)
2. Ensure you have access to the project secrets
3. Unpack secrets `git secret reveal`

#### Emulator (Recommended)

1. Install [Node.js](https://nodejs.org/en/) version @16
2. Install firebase-tools globally `npm install -g firebase-tools`
3. Initialize firebase `firebase init`
4. Go to the project cloud functions directory `cd firebase/functions`
5. Install dependencies `npm install`
6. Run the emulator `npm run emulator:all`

#### Application

1. Install [Flutter](https://flutter.dev/docs/get-started/install)
2. In the root of the project run `flutter pub get`
3. Run build_runner `flutter pub run build_runner build --delete-conflicting-outputs`
4. Run the app `flutter run`
   
    Environment variables:
    1. FIREBASE_ENV - `cloud` or `emulator`
    2. EMULATOR_REMOTE_HOST - `localhost` or actual host IP address to access remote emulations