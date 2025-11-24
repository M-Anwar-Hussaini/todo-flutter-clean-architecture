# Todo Flutter Clean Architecture

A robust, scalable, and testable Todo application built with Flutter, demonstrating the principles of **Clean Architecture**. This project showcases best practices in separation of concerns, dependency injection, and state management using the Bloc pattern.

## 🏗 Architecture Overview

This project adheres to **Clean Architecture** combined with **Feature-First** organization. The codebase is divided into three main layers, ensuring that the business logic is independent of the UI and data sources.

### The 3 Layers

1.  **Domain Layer (Core Business Logic)**

    - **Entities**: Pure Dart classes describing the core business objects (e.g., `TodoEntity`).
    - **Repositories (Interfaces)**: Abstract definitions of how data should be accessed, ensuring the domain layer remains agnostic of the implementation details.
    - **Use Cases**: Encapsulate specific business rules and orchestrate the flow of data to and from the entities (e.g., `GetTodosUseCase`, `AddTodoUseCase`).
    - _Note: This layer has NO dependencies on other layers or external libraries (except core utility packages)._

2.  **Data Layer (Data Access & Manipulation)**

    - **Models**: Data Transfer Objects (DTOs) that extend Entities, adding methods for serialization/deserialization (e.g., `fromJson`, `toJson`).
    - **Data Sources**: Low-level implementations for fetching data (e.g., `TodoLocalDataSource` using `SharedPreferences`).
    - **Repositories (Implementation)**: Concrete implementations of the domain repositories, coordinating between local/remote data sources and the domain layer.

3.  **Presentation Layer (UI & State Management)**
    - **Blocs/Cubits**: State management logic that handles user input and communicates with Use Cases to emit new states.
    - **Screens/Widgets**: The UI components built with Flutter widgets, observing the state changes from Blocs.

## 🛠 Tech Stack

- **[Flutter](https://flutter.dev/)**: Google's UI toolkit for building natively compiled applications.
- **[flutter_bloc](https://pub.dev/packages/flutter_bloc)**: Predictable state management library.
- **[go_router](https://pub.dev/packages/go_router)**: A declarative routing package for Flutter.
- **[get_it](https://pub.dev/packages/get_it)**: Simple Service Locator for dependency injection.
- **[equatable](https://pub.dev/packages/equatable)**: Simplifies equality comparisons for classes.
- **[shared_preferences](https://pub.dev/packages/shared_preferences)**: Persistent storage for simple data.
- **[uuid](https://pub.dev/packages/uuid)**: For generating unique IDs.

## 📂 Folder Structure

```
lib/
├── feature/
│   └── todo/
│       ├── data/
│       │   ├── data_source/    # Local/Remote data sources
│       │   ├── model/          # JSON parsing & serialization
│       │   └── repository/     # Concrete repository implementation
│       ├── domain/
│       │   ├── entities/       # Core business objects
│       │   ├── repository/     # Abstract repository definitions
│       │   └── use_case/       # Business logic operations
│       ├── presentation/
│       │   ├── bloc/           # State management (Events/States)
│       │   └── views/          # UI Screens & Widgets
│       └── todo_dependency_injection.dart # DI setup for the feature
└── main.dart                   # Entry point & App initialization
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (v3.10.0 or higher)
- Dart SDK

### Installation

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/M-Anwar-Hussaini/todo-flutter-clean-architecture.git
    cd todo-clean-architecture
    ```

2.  **Install dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Run the application:**
    ```bash
    flutter run
    ```
    - To run on Chrome: `flutter run -d chrome`

## ✅ Key Features

- **Add Todo**: Create new tasks with a title and description.
- **Edit Todo**: Update existing tasks.
- **Delete Todo**: Remove tasks from the list.
- **Mark as Completed**: Toggle the completion status of a task.
- **Local Persistence**: Tasks are saved locally and persist across app restarts.

## 🧩 Design Patterns & Principles Used

- **SOLID Principles**: Applied throughout to ensure maintainability.
- **Dependency Injection (DI)**: Decouples classes and makes testing easier.
- **Repository Pattern**: Abstracts data acquisition.
- **Sealed Classes**: Used for States and Events to ensure exhaustive pattern matching (Dart 3).

---

_Built with ❤️ using Flutter and Clean Architecture._
