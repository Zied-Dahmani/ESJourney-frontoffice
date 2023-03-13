import 'package:esjourney/presentation/screens/club/apply_to_club_screen.dart';
import 'package:esjourney/presentation/screens/club/club_screen.dart';
import 'package:esjourney/presentation/screens/club/done_screen.dart';
import 'package:esjourney/presentation/screens/club_event/club_event_tickets_screen.dart';
import 'package:esjourney/presentation/screens/club_event/club_event_timeline_screen.dart';
import 'package:esjourney/presentation/screens/sign_in_screen.dart';
import 'package:esjourney/presentation/screens/zoom_drawer_screen.dart';
import 'package:flutter/material.dart';
import 'routes.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    final Object? args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.signInScreen:
        return MaterialPageRoute(
          builder: (_) => SignInScreen(),
        );

      case AppRoutes.zoomDrawerScreen:
        return MaterialPageRoute(
          builder: (_) => const ZoomDrawerScreen(),
        );

      // Zied
      case AppRoutes.clubScreen:
        return MaterialPageRoute(
          builder: (_) => ClubScreen(club: args),
        );

      case AppRoutes.applyToClubScreen:
        return MaterialPageRoute(
          builder: (_) => const ApplyToClubScreen(),
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

      default:
        return null;
    }
  }
}
