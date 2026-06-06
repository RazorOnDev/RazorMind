# RazorMind — Minimalist AI-Powered Learning App

## Overview
RazorMind is a Flutter mobile application for daily general culture learning. It features a Duolingo-style challenge system, XP progression, daily streaks, and a minimalist dark-first design.

## Tech Stack
| Layer | Technology |
|---|---|
| Framework | Flutter 3.x / Dart 3.x |
| State Management | Riverpod 2.x (`NotifierProvider`) |
| Navigation | GoRouter 12.x with `ShellRoute` |
| Persistence | SharedPreferences (JSON) |
| Fonts | Google Fonts — Plus Jakarta Sans |
| Animations | flutter_animate |
| Progress UI | percent_indicator |

## Project Structure
```
lib/
├── main.dart                          # Entry point — SharedPreferences injection
├── app/
│   ├── app.dart                       # MaterialApp.router
│   ├── router.dart                    # GoRouter + ShellRoute + all routes
│   └── theme.dart                     # AppTheme.darkTheme (Material3)
├── core/
│   ├── constants/
│   │   ├── app_colors.dart            # Full color palette
│   │   └── app_strings.dart           # All UI strings (Spanish)
│   ├── extensions/
│   │   └── context_extension.dart     # BuildContext shortcuts
│   └── utils/
│       └── level_utils.dart           # XP→level conversion, titles, XP calc
├── data/
│   ├── models/
│   │   ├── question.dart              # Question model (JSON serializable)
│   │   └── category_model.dart        # CategoryModel + AppCategories.all
│   └── providers/
│       └── progress_provider.dart     # UserProgress model + ProgressNotifier + progressProvider
├── features/
│   ├── splash/
│   │   └── splash_screen.dart         # Animated logo → routes to onboarding or home
│   ├── onboarding/
│   │   └── onboarding_screen.dart     # 3-page PageView onboarding
│   ├── home/
│   │   └── home_screen.dart           # Dashboard: streak, level, challenge CTA, categories
│   ├── challenge/
│   │   └── challenge_screen.dart      # Quiz flow + ResultScreen (in same file)
│   ├── learn/
│   │   └── learn_screen.dart          # LearningScreen + CategoryDetailScreen (in same file)
│   ├── stats/
│   │   └── stats_screen.dart          # Stats dashboard with level card + stat grid
│   └── profile/
│       └── profile_screen.dart        # Profile, progress info, reset
└── shared/
    └── widgets/
        ├── app_bottom_nav.dart         # Custom animated bottom navigation bar
        └── razor_button.dart           # Primary (gradient) + secondary (outlined) button
```

## Navigation Routes
| Path | Screen | Notes |
|---|---|---|
| `/` | `SplashScreen` | Initial; auto-redirects |
| `/onboarding` | `OnboardingScreen` | Full screen, no shell |
| `/home` | `HomeScreen` | Tab 0 in ShellRoute |
| `/learn` | `LearningScreen` | Tab 1 in ShellRoute |
| `/learn/:categoryId` | `CategoryDetailScreen` | Pushed above shell |
| `/stats` | `StatsScreen` | Tab 2 in ShellRoute |
| `/profile` | `ProfileScreen` | Tab 3 in ShellRoute |
| `/challenge` | `ChallengeScreen` | Full screen, no shell |
| `/challenge/result` | `ResultScreen` | Query params: `score`, `total`, `xpEarned`, `categoryId` |

## Design System

### Color Palette (all in `AppColors`)
```dart
background   = Color(0xFF080810)   // Page background
surface      = Color(0xFF12121E)   // Bottom nav, elevated surfaces
card         = Color(0xFF1A1A2E)   // Cards, option buttons
primary      = Color(0xFF6366F1)   // Indigo — primary actions
primaryLight = Color(0xFF818CF8)   // Gradient top
primaryDark  = Color(0xFF4F46E5)   // Gradient bottom
secondary    = Color(0xFFF59E0B)   // Amber — streak, XP highlights
correct      = Color(0xFF10B981)   // Emerald — correct answers
error        = Color(0xFFEF4444)   // Red — wrong answers
textPrimary  = Color(0xFFF1F5F9)
textSecondary= Color(0xFF94A3B8)
textTertiary = Color(0xFF475569)
border       = Color(0xFF1E2040)
```

### Category Colors
```dart
historyColor    = Color(0xFFE07B54)   // Terracotta
scienceColor    = Color(0xFF3B82F6)   // Blue
geographyColor  = Color(0xFF10B981)   // Green
artColor        = Color(0xFFEC4899)   // Pink
techColor       = Color(0xFF6366F1)   // Indigo
philosophyColor = Color(0xFF8B5CF6)   // Purple
languageColor   = Color(0xFFF59E0B)   // Amber
```

### Typography
Font: **Plus Jakarta Sans** (via `google_fonts`). Applied globally through `AppTheme.darkTheme`.

## State Management

### `progressProvider` (`NotifierProvider<ProgressNotifier, UserProgress>`)
The single source of truth for user state.

**UserProgress fields:**
- `totalXp: int` — cumulative XP
- `currentStreak: int` — current daily streak
- `bestStreak: int` — all-time best streak
- `totalQuestionsAnswered: int`
- `totalCorrectAnswers: int`
- `isOnboardingComplete: bool`
- `lastPlayedDate: String?` — ISO date string `yyyy-MM-dd`
- `correctRate: double` — computed: correct / total

**ProgressNotifier methods:**
- `completeOnboarding()` — marks onboarding done
- `recordSession({xpEarned, questionsAnswered, correctAnswers})` — updates XP, streak, counters
- `resetProgress()` — clears all data (keeps onboarding flag)

**Persistence:** JSON serialized to SharedPreferences under key `'user_progress'`. Streak logic: compares `lastPlayedDate` with today/yesterday strings.

### `sharedPreferencesProvider`
`Provider<SharedPreferences>` — injected via `ProviderScope` override in `main()`.

## Level System (`LevelUtils`)
```dart
// XP thresholds
Level 1:   0 XP      Level 6:  1,400 XP   Level 11:  7,500 XP
Level 2: 100 XP      Level 7:  2,100 XP   Level 12:  9,600 XP
Level 3: 250 XP      Level 8:  3,000 XP   ...up to Level 20
Level 4: 500 XP      Level 9:  4,200 XP
Level 5: 900 XP      Level 10: 5,700 XP

// Level titles (Spanish)
1: Aprendiz → 5: Analista → 10: Genio → 15: Inmortal → 20: RazorMind
```

XP rewards per challenge:
- `correctAnswers × 10` base XP
- `+50` bonus for a perfect score (all correct)
- `+20%` streak bonus if `currentStreak > 0`

## Data Models

### `Question` (`lib/data/models/question.dart`)
```dart
String id            // e.g. 'hist_001'
String categoryId    // 'history' | 'science' | 'geography' | 'art' | 'tech' | 'philosophy' | 'language'
String type          // 'multiple_choice' | 'true_false'
String text          // The question
List<String> options // 4 options (or 2 for true_false)
String correctAnswer // Must exactly match one of options
String explanation   // 1-2 sentence explanation
int difficulty       // 1=easy, 2=medium, 3=hard
int xpReward         // 10 | 25 | 50
```

### `CategoryModel` + `AppCategories` (`lib/data/models/category_model.dart`)
7 predefined categories: `history`, `science`, `geography`, `art`, `tech`, `philosophy`, `language`.
Access via `AppCategories.getById(String id)` or `AppCategories.all`.

## Adding New Questions
The challenge screen currently uses 10 inline sample questions in `_sampleQuestions` inside `challenge_screen.dart`. To expand:

1. Add entries to `_sampleQuestions` list (or create a `QuestionService` class)
2. Follow the `_Question` format: `question`, `options`, `correctIndex`, `category`
3. Categories: `'history'`, `'science'`, `'geography'`, `'art'`, `'tech'`, `'philosophy'`, `'language'`

To implement a full `QuestionService`:
1. Create `lib/data/services/question_service.dart`
2. Add a `Provider<QuestionService>` in `lib/data/providers/question_provider.dart`
3. Inject it in `ChallengeScreen` via `ref.watch(questionServiceProvider)`

## Running the App
```bash
# Install dependencies
flutter pub get

# Run on device/simulator
flutter run

# Run with specific flavor
flutter run --debug
flutter run --release

# Build APK
flutter build apk --release

# Build iOS
flutter build ipa --release
```

## Testing
```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

## Future Improvements
- `QuestionService` with 80+ curated questions per category
- Adaptive difficulty algorithm based on per-category accuracy
- Daily challenge seeded by date (consistent questions per day)
- Streak calendar widget in stats screen
- Category XP tracking (currently only global XP)
- Achievement/badge system
- Push notifications for daily reminder
- Light theme toggle
