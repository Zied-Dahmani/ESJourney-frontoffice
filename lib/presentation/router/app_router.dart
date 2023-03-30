import 'package:esjourney/data/models/events/event_model.dart';
import 'package:esjourney/data/models/user_model.dart';
import 'package:esjourney/presentation/screens/club/apply_to_club_screen.dart';
import 'package:esjourney/presentation/screens/club/club_screen.dart';
import 'package:esjourney/presentation/screens/club/done_screen.dart';
import 'package:esjourney/presentation/screens/club/shorts_screen.dart';
import 'package:esjourney/presentation/screens/club_event/club_event_tickets_screen.dart';
import 'package:esjourney/presentation/screens/club_event/club_event_timeline_screen.dart';
import 'package:esjourney/presentation/screens/curriculum/avatar/avatar_screen.dart';
import 'package:esjourney/presentation/screens/curriculum/chat/conversation_screen.dart';
import 'package:esjourney/presentation/screens/curriculum/chat/grade_chat_room_screen.dart';
import 'package:esjourney/presentation/screens/curriculum/chat/messages_screen.dart';
import 'package:esjourney/presentation/screens/curriculum/games/draw/feature/draw/presentation/drawing_screen.dart';
import 'package:esjourney/presentation/screens/curriculum/games/draw/feature/room/presentation/room_screen.dart';
import 'package:esjourney/presentation/screens/curriculum/games/hangman/screens/hangman_screen.dart';
import 'package:esjourney/presentation/screens/curriculum/games/jackpot/jackpot_screen.dart';
import 'package:esjourney/presentation/screens/curriculum/games/memory/screen/memory_screen.dart';
import 'package:esjourney/presentation/screens/curriculum/games/slide/pages/slide_screen.dart';
import 'package:esjourney/presentation/screens/curriculum/games/worldy/screens/wordly_game.dart';
import 'package:esjourney/presentation/screens/curriculum/map/level_map.dart';
import 'package:esjourney/presentation/screens/sign_in_screen.dart';
import 'package:esjourney/presentation/screens/sign_up_screen.dart';
import 'package:esjourney/presentation/screens/zoom_drawer_screen.dart';
import 'package:flutter/material.dart';

import '../screens/Events/event_details_screen.dart';
import '../screens/Internship/profileScreen.dart';
import '../screens/challenges/leaderboard/leaderboard_screen.dart';
import '../screens/challenges/quiz/quiz.dart';
import '../screens/challenges/quiz/quiz_result.dart';
import '../screens/profile/edit_profile/edit_profile_screen.dart';
import 'routes.dart';

class AppRouter {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final Object? args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.signInScreen:
        return MaterialPageRoute(builder: (_) => SignInScreen());

      case AppRoutes.zoomDrawerScreen:
        return MaterialPageRoute(
          builder: (_) => ZoomDrawerScreen(),
        );

      case AppRoutes.jackpotGame:
        return MaterialPageRoute(builder: (_) => const JackpotScreen());

      case AppRoutes.eventDetails:
        return MaterialPageRoute(
          builder: (_) => EventDetails(
            event: args as Event,
          ),
        );

      case AppRoutes.avatar:
        return MaterialPageRoute(
          builder: (_) => const AvatarScreen(),
        );

      case AppRoutes.slideGame:
        return MaterialPageRoute(
          builder: (_) => const SlideScreen(),
        );

      case AppRoutes.listDrawRoom:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const RoomScreen(),
        );

      case AppRoutes.drawingRoom:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => const DrawingRoomScreen(),
          transitionDuration: const Duration(milliseconds: 400),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );

      case AppRoutes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => SignUpScreen(),
        );

      case AppRoutes.wordlyGame:
        return MaterialPageRoute(builder: (_) => const WordlyPage());

      case AppRoutes.memoryGame:
        return MaterialPageRoute(builder: (_) => const MemoryScreen());

      case AppRoutes.hangmanGame:
        return MaterialPageRoute(builder: (_) => const HangmanScreen());

      case AppRoutes.messages:
        return MaterialPageRoute(builder: (_) => const MessagesScreen());

      case AppRoutes.mapLevels:
        return MaterialPageRoute(
            builder: (_) => MapLevelScreen(myCourses: args as List<dynamic>));

      case AppRoutes.gradeChatRoom:
        final Map<String, dynamic> argsMap = args as Map<String, dynamic>;
        final int grade = argsMap['grade'] as int;
        final String token = argsMap['token'] as String;
        final String myUsername = argsMap['myUsername'] as String;
        return MaterialPageRoute(
          builder: (_) => ChatGradeRoomScreen(
            grade: grade,
            token: token,
            myUsername: myUsername,
          ),
        );

      case AppRoutes.conversation:
        final Map<String, dynamic> argsMap = args as Map<String, dynamic>;
        final User receiver = argsMap['receiver'] as User;
        final String myUsername = argsMap['myUsername'] as String;
        final String token = argsMap['token'] as String;
        return MaterialPageRoute(
          builder: (_) => ConversationScreen(
            receiver: receiver,
            myUsername: myUsername,
            token: token,
          ),
        );

      // Zied
      case AppRoutes.clubScreen:
        return MaterialPageRoute(
          builder: (_) => ClubScreen(club: args),
        );

      case AppRoutes.applyToClubScreen:
        return MaterialPageRoute(
          builder: (_) => ApplyToClubScreen(clubId: args),
        );

      case AppRoutes.doneScreen:
        return MaterialPageRoute(
          builder: (_) => const DoneScreen(),
        );

      case AppRoutes.clubEventTimelineScreen:
        return MaterialPageRoute(
          builder: (_) => ClubEventTimelineScreen(clubEvent: args),
        );

      case AppRoutes.clubEventTicketsScreen:
        return MaterialPageRoute(
          builder: (_) => ClubEventTicketsScreen(clubEvent: args),
        );

      case AppRoutes.shortsScreen:
        final Map<String, dynamic> argsMap = args as Map<String, dynamic>;
        final int index = argsMap['index'] as int;
        final List<String> shorts = argsMap['shorts'] as List<String>;
        return MaterialPageRoute(
          builder: (_) => ShortsScreen(
            shorts: shorts,
            startIndex: index,
          ),
        );

// souhail
      case AppRoutes.quizScreen:
        return MaterialPageRoute(
          builder: (_) => QuizScreen(
            //  language: args as String,
            restart: args as bool,
          ),
        );
      case AppRoutes.quizResult:
        return MaterialPageRoute(
          builder: (_) => QuizResultScreen(
            score: args as int,
          ),
        );

      case AppRoutes.leaderboardScreen:
        return MaterialPageRoute(
          builder: (_) => const LeaderboardScreen(),
        );
      case AppRoutes.profileScreen:
        return MaterialPageRoute(
          builder: (_) => const ApplicationFormScreen(),
        );
      case AppRoutes.editProfileScreen:
        return MaterialPageRoute(
          builder: (_) => const EditProfileScreen(),
        );

      default:
        return null;
    }
  }
}
