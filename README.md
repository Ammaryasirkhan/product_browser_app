Product Browser App (Flutter)

A Flutter application that fetches and displays products from a public API, built with a clean architecture approach, Bloc state management, and Dio for API handling.

This project focuses on code quality, maintainability, and clear separation of concerns, rather than pixel-perfect UI.

Project Setup Steps
Prerequisites

Flutter SDK (stable channel)

Dart SDK

Android Studio / VS Code

Android Emulator or Physical Device

Steps to Run
git clone https://github.com/Ammaryasirkhan/product_browser_app.git
cd product_browser_app
flutter pub get
flutter run

🧠 State Management Choice
✅ Bloc (flutter_bloc)

Why Bloc?

Provides predictable and explicit state management

Clear separation between UI and business logic

Easy to handle loading, success, and error states

Scales well for production-level applications

Highly testable and widely adopted in Flutter industry projects

Bloc was chosen over simpler solutions (like Provider) to demonstrate a production-style architecture with clear event-driven state transitions.

🗂️ Folder Structure Explanation
lib/
├── core/  
 │ ├── dio/  
 │ ├── error/  
 │ └── utils/  
 │
├── data/  
 │ ├── models/  
 │ ├── sources/  
 │ └── repositories/
│
├── domain/  
 │ └── repositories/  
 │
├── presentation/
│ ├── blocs/  
 │ │ ├── product_list/
│ │ └── product_detail/
│ ├── screens/  
 │ └── widgets/  
 │
└── main.dart

Architecture Summary

UI layer → Widgets & Screens

State layer → Bloc / Cubit

Data layer → API + Repository

Core layer → Shared utilities and helpers

This ensures separation of concerns and clean code organization.

💰 Price Formatting Rule

Prices are formatted using a reusable extension:

extension PriceFormatting on num {
String asMoney() => '\$${toDouble().toStringAsFixed(2)}';
}
Bloc was chosen intentionally for this assessment because:

It enforces a clear separation between UI and business logic

Application states are explicit and predictable (Loading, Success, Error)

It scales well for production-level applications

It improves code readability, testability, and maintainability

It aligns with industry best practices for medium-to-large Flutter apps

Bloc allows handling complex flows such as:

API loading states

Error handling with retry

Search state vs normal listing state

All without leaking business logic into the UI layer.

This guarantees:

Exactly 2 decimal places

No UI-only or hardcoded formatting

Reusable across the entire app

🔍 Implemented Features

Product list with image, title, and price

Product detail screen with full information

Search products by title

Loading indicators

Error handling with retry option

Pull-to-refresh (bonus)

Clean navigation flow

Assumptions & Trade-offs

Pagination was kept simple to maintain clarity and readability

Search is implemented without debounce to avoid unnecessary dependencies and keep logic straightforward

Carousel for product images was kept optional (single image used)

Dependency injection is done manually (no service locator) for simplicity

UI focuses on usability rather than visual polish

These choices were made intentionally to prioritize maintainability and clarity over over-engineering.
