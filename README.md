# 📝 Flutter ToDo App – Clean Architecture with BLoC

A Flutter ToDo application built using Clean Architecture principles, leveraging `flutter_bloc` for state management. This project serves as a practical example of structuring Flutter apps for scalability, testability, and maintainability.

## 📐 Architecture Overview

This project follows the Clean Architecture pattern, dividing the codebase into distinct layers:

- **Presentation Layer**: Handles UI components and user interactions.
- **Domain Layer**: Contains business logic and use cases.
- **Data Layer**: Manages data sources, repositories, and models.

This separation ensures a clear structure, making the app easier to test and maintain.

## 🧰 Features

- ✅ Task Management: Create, update, and delete tasks.
- 📦 State Management: Utilizes `flutter_bloc` for predictable state handling.
- 💾 Local Persistence: Stores tasks locally using `objectbox`.
- 🧪 Testing: Includes unit and integration tests using `mockito`, `mocktail`.
- 🧩 Dependency Injection: Managed using `injectable` and `get_it`.

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dart SDK
- [ObjectBox CLI](https://docs.objectbox.io/getting-started/flutter)

### Installation

```bash
git clone https://github.com/tungvt-it-92/flutter-bloc-clean-architecture.git
cd flutter-bloc-clean-architecture/todos
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```
## 🧪 Testing

### Run Unit Tests

```bash
flutter test
```

### Run Integration Testing
```bash
flutter test integration_test/
```

## 📁 Project Structure

```bash
lib/
├── core/               # Shared utilities, error handling
├── data/               # API, local data sources, models
├── domain/             # Entities and business logic (use cases)
├── presentation/       # UI, BLoC, and screens
├── injection.dart      # Dependency injection setup
main.dart               # App entry point
```

## 🚀 DEMO
![App demo](demo.gif)

## 🙌 Acknowledgements
- Inspired by the principles of [Clean Architecture](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html) by Uncle Bob. <br>
- Based on community patterns from BLoC and Flutter clean architecture enthusiasts.
