# AI Usage Disclosure

## AI Tools Used
- **GitHub Copilot / Cursor / Gemini**: Used for code generation, refactoring, and documentation drafting.
- **ChatGPT**: Used for initial architecture brainstorming and clarifying requirements.

## Where AI Was Used

1.  **Architecture & Structure**:
    - AI suggested the Clean Architecture variation using `core`, `data`, and `presentation` layers to ensure separation of concerns.
    - AI helped set up the GetX state management pattern (bindings, controllers).

2.  **Code Generation**:
    - **Models**: `PostModel` (`fromJson`/`toJson`) was generated based on the API response structure.
    - **Repositories**: `PostRepository` logic for fetching data and offline caching (using `SharedPreferences`) was drafted by AI and refined.
    - **UI**: Implementation of `PostListScreen` and `PostDetailScreen` using `GetView` and `Obx` for reactive updates.

3.  **Refactoring**:
    - **API Migration**: AI assisted in refactoring the application from JSONPlaceholder to **DummyJSON**, updating models and pagination logic to handle `skip` and `limit` parameters.
    - **Linting**: AI helped fix linting issues (e.g., converting to super parameters, removing unused imports).

## Modifications & Refinements

- **Accepted**:
    - The overall directory structure.
    - The JSON serialization logic.
    - The core pagination logic in `PostController`.

- **Modified/Improved**:
    - **Pagination UI**: The AI initially suggested a standard large loading indicator for pagination. This was refined to a smaller, less obtrusive indicator at the bottom of the list for a better user experience.
    - **Error Handling**: The initial AI suggestion for error handling was too generic. I improved it to specific scenarios (network vs. other errors) and added a retry mechanism for the user via the UI.
    - **Caching Strategy**: AI suggested caching all pages. I decided to cache only the first page to minimize storage usage while still providing an immediate "offline" experience for the main list, which is a trade-off for performance vs. storage.

- **Rejected**:
    - **Complex Database**: AI suggested using a complex local database (sqflite) for this simple use case. I rejected it in favor of `SharedPreferences` as it is simpler and sufficient for caching a small list of JSON data, reducing complexity.

## Example of Improvement
The AI-generated `PostRepository` initially didn't handle the case where the device is offline and the cache is empty gracefully. I added a specific check to throw a user-friendly exception ("No internet connection and no cached data available") instead of a generic error, which allows the UI to show a more helpful message to the user.
