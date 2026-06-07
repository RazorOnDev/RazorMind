import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:razor_mind/data/models/challenge_mode.dart';
import 'package:razor_mind/features/challenge/challenge_screen.dart';
import 'package:razor_mind/features/challenge/mode_select_screen.dart';
import 'package:razor_mind/features/home/home_screen.dart';
import 'package:razor_mind/features/learn/learn_screen.dart';
import 'package:razor_mind/features/onboarding/onboarding_screen.dart';
import 'package:razor_mind/features/profile/profile_screen.dart';
import 'package:razor_mind/features/ranking/ranking_screen.dart';
import 'package:razor_mind/features/splash/splash_screen.dart';
import 'package:razor_mind/features/stats/stats_screen.dart';
import 'package:razor_mind/shared/widgets/app_bottom_nav.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

const _shellRoutes = ['/home', '/learn', '/stats', '/profile'];

int _locationToIndex(String location) {
  for (int i = 0; i < _shellRoutes.length; i++) {
    if (location.startsWith(_shellRoutes[i])) return i;
  }
  return 0;
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: '/',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/modes',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ModeSelectScreen(),
      ),
      GoRoute(
        path: '/ranking',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const RankingScreen(),
      ),
      GoRoute(
        path: '/challenge',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final params = state.uri.queryParameters;
          final modeStr = params['mode'] ?? 'daily';
          final mode = ChallengeMode.values.firstWhere(
            (m) => m.name == modeStr,
            orElse: () => ChallengeMode.daily,
          );
          final categoryId = params['categoryId'];
          return ChallengeScreen(mode: mode, categoryId: categoryId);
        },
        routes: [
          GoRoute(
            path: 'result',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (context, state) {
              final params = state.uri.queryParameters;
              return ResultScreen(
                score: int.tryParse(params['score'] ?? '0') ?? 0,
                total: int.tryParse(params['total'] ?? '10') ?? 10,
                xpEarned: int.tryParse(params['xpEarned'] ?? '0') ?? 0,
                rankPointsEarned: int.tryParse(params['rankPoints'] ?? '0') ?? 0,
                categoryId: params['categoryId'] ?? 'general',
                mode: params['mode'] ?? 'daily',
              );
            },
          ),
        ],
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          final index = _locationToIndex(state.uri.path);
          return _ShellScaffold(currentIndex: index, child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: HomeScreen()),
          ),
          GoRoute(
            path: '/learn',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: LearningScreen()),
            routes: [
              GoRoute(
                path: ':categoryId',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => CategoryDetailScreen(
                  categoryId: state.pathParameters['categoryId'] ?? '',
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/stats',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: StatsScreen()),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ProfileScreen()),
          ),
        ],
      ),
    ],
  );
});

class _ShellScaffold extends StatelessWidget {
  const _ShellScaffold({
    required this.currentIndex,
    required this.child,
  });

  final int currentIndex;
  final Widget child;

  void _onNavTap(BuildContext context, int index) {
    context.go(_shellRoutes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: AppBottomNav(
        currentIndex: currentIndex,
        onTap: (index) => _onNavTap(context, index),
      ),
    );
  }
}
