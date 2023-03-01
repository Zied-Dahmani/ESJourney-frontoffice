import 'package:esjourney/data/models/curriculum/course_model.dart';
import 'package:esjourney/presentation/screens/curriculum/course_detail_screen.dart';
import 'package:esjourney/presentation/screens/curriculum/course_screen.dart';
import 'package:esjourney/presentation/screens/curriculum/games/jackpot/jackpot_screen.dart';
import 'package:esjourney/presentation/screens/curriculum/level_map_screen.dart';
import 'package:esjourney/presentation/screens/sign_in_screen.dart';
import 'package:esjourney/presentation/screens/zoom_drawer_screen.dart';
import 'package:flutter/material.dart';


import '../screens/challenges/leaderboard/leaderboard_screen.dart';
import '../screens/challenges/quiz/quiz.dart';
import '../screens/challenges/quiz/quiz_result.dart';
import 'routes.dart';

class AppRouter {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final Object? args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.signInScreen:
        return MaterialPageRoute(builder: (_) => SignInScreen());

      case AppRoutes.zoomDrawerScreen:
        return MaterialPageRoute(
          builder: (_) => const ZoomDrawerScreen(),
        );

      case AppRoutes.courseDetails:
        return MaterialPageRoute(
          builder: (_) => CourseDetailScreen(
            course: args as Course,
          ),
        );

      case AppRoutes.jackpotGame:
        return MaterialPageRoute(builder: (_) => const JackpotScreen());

      case AppRoutes.levelMap:
        return MaterialPageRoute(
          builder: (_) => LevelMapScreen(
            grade: args as int,
          ),
        );
        case AppRoutes.quizScreen:
        return MaterialPageRoute(
          builder: (_) =>  QuizScreen(
            //  language: args as String,
            restart: args as bool,

          ),
        );
      case AppRoutes.quizResult:
        return MaterialPageRoute(
          builder: (_) => QuizResultScreen(
            score : args as int,
          ),
        );

      case AppRoutes.leaderboardScreen:
        return MaterialPageRoute(
          builder: (_) =>  const LeaderboardScreen(


          ),
        );

      default:
        return null;
    }
  }
}
