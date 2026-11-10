# iCook

An Indian regional culinary companion built with Flutter for Android and iOS.

## Current starter
- Mobile navigation for Home, Explore, AI Cook and Saved
- Regional discovery entry points
- Recipe cards and detail screen
- Category chips and search-field UI
- AI assistant chat interface placeholder

## Next development milestones
1. Add Firebase project configuration and Authentication.
2. Create Firestore `regions`, `recipes`, `users`, `chat_sessions`, and `messages` collections.
3. Load verified recipes and regional data from Firestore.
4. Add secure server-side AI assistant integration (never put private API keys in the app).
5. Add tests, app icons, privacy policy and store metadata.
6. Build Android App Bundle and iOS release using a cloud build service.

## Run locally
Install Flutter SDK, then run:
```bash
flutter pub get
flutter run
```

Firebase configuration files are intentionally not included. They must be generated for the owner's Firebase project.
