# Assignment App

A mobile application built with Flutter that fetches data from a public REST API (DummyJSON), supports offline access, and demonstrating clean architecture principles.

## Demo Video

[Watch App Demo](assets/assignment_video.mp4)

![App Demo](assets/assignment_video.gif)

## Features

- **Fetch Data**: Displays a list of products fetched from `https://dummyjson.com/products`.
- **Pagination**: Supports infinite scrolling with a subtle loading indicator.
- **Pull-to-Refresh**: Update the list with fresh data.
- **Offline Support**: Caches the initial list of posts so the app works even without an internet connection.
- **Detail View**: Navigate to a detail screen to view the full content of a product.
- **State Management**: Handles Loading, Empty, and Error states gracefully with retry mechanisms.

## Architecture

This project follows a **Clean Architecture** approach using **MVVM** pattern with **GetX** for state management.

### Structure
- **Core**: Application-wide constants (`ApiConstants`).
- **Data**:
    - `Models`: Data structures (`PostModel`) with JSON serialization.
    - `Services`: API calls (`ApiService`).
    - `Repositories`: Data handling logic (`PostRepository`), managing the source of data (API vs. Local Cache).
- **Presentation**:
    - `Controllers`: Business logic and state management (`PostController`).
    - `Screens`: UI pages (`PostListScreen`, `PostDetailScreen`).
    - `Widgets`: Reusable UI components (`PostTile`).

## Key Decisions & Trade-offs
1.  **State Management (GetX)**:
    - *Decision*: Chosen for its simplicity and reduced boilerplate compared to BLoC for a small-to-medium sized assignment.
    - *Benefit*: Allows for easy dependency injection and reactive state updates with less code.
2.  **Caching Strategy (SharedPreferences)**:
    - *Decision*: Instead of a full database (SQLite/Hive), simple JSON caching in `SharedPreferences` was chosen.
    - *Trade-off*: Less performant for massive datasets, but significantly simpler to implement and sufficient for caching a few pages of text-based posts. ideal for an MVP.
3.  **Pagination Implementation**:
    - *Decision*: Implemented using a `ScrollController` listener in the controller to fetch more data when the user nears the bottom of the list.
    - *Refinement*: The loading indicator was moved to the bottom of the list (instead of a full-screen loader) to allow the user to see existing content while waiting.

## Setup Instructions

1.  **Prerequisites**: Ensure you have Flutter SDK installed (`flutter doctor`).
2.  **Clone/Download** the repository.
3.  **Install Dependencies**:
    ```bash
    flutter pub get
    ```
4.  **Run the App**:
    ```bash
    flutter run
    ```

## Known Limitations
- **Offline Caching**: Currently limited to the first page of results to ensure vital content is available without consuming excessive storage.
- **Orientation**: The UI is optimized for mobile portrait mode.

## AI Usage
Please refer to `AI_USAGE.md` for details on how AI tools were utilized in this project.