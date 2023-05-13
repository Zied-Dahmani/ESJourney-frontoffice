
import 'package:esjourney/data/repositories/chat/chat_service.dart';
import 'package:esjourney/data/repositories/club/club_repository.dart';
import 'package:esjourney/logic/app_bloc_observer.dart';
import 'package:esjourney/logic/cubits/application/application_cubit.dart';
import 'package:esjourney/logic/cubits/chat/user/users_cubit.dart';
import 'package:esjourney/logic/cubits/club/club_cubit.dart';
import 'package:esjourney/logic/cubits/club_event/club_event_cubit.dart';
import 'package:esjourney/logic/cubits/connectivity/connectivity_cubit.dart';
import 'package:esjourney/logic/cubits/curriculum/course_cubit.dart';
import 'package:esjourney/logic/cubits/events/event_cubit.dart';
import 'package:esjourney/logic/cubits/location/location_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:esjourney/logic/cubits/user/username_available/username_available_cubit.dart';
import 'package:esjourney/presentation/router/app_router.dart';
import 'package:esjourney/presentation/screens/club/club_screen.dart';
import 'package:esjourney/presentation/screens/curriculum/chat/socket_service.dart';
import 'package:esjourney/presentation/screens/curriculum/games/draw/core/bloc/user_cubit/drawer_cubit.dart';
import 'package:esjourney/presentation/screens/sign_in_screen.dart';
import 'package:esjourney/presentation/screens/zoom_drawer_screen.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'logic/cubits/challenges/coding_problem_cubit.dart';
import 'logic/cubits/challenges/leaderboard_cubit.dart';
import 'logic/cubits/challenges/posts/posts_cubit.dart';
import 'logic/cubits/challenges/quiz_cubit.dart';
import 'logic/cubits/challenges/submission_cubit.dart';
import 'logic/cubits/challenges/top_solutions_cubit.dart';
import 'logic/cubits/club/club_state.dart';
import 'presentation/screens/curriculum/games/draw/main_module.dart';
import 'presentation/screens/curriculum/games/slide/tools/board_controller.dart';
import 'presentation/screens/curriculum/games/slide/tools/navigation.dart';
import 'presentation/screens/curriculum/games/worldy/provider/controller.dart';
import 'dart:io' show Platform;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white, // Set your desired color here
  ));
  await MainModule.init();
  //check os
  if (Platform.isAndroid) {
    await Firebase.initializeApp();
  }

  ErrorWidget.builder = (FlutterErrorDetails details) {
    if (kDebugMode) {
      return ErrorWidget(details.exception);
    }
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            AppStrings.kerror,
            textDirection: TextDirection.ltr,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.ksmallSpace),
          Text(
            details.exception.toString(),
            textDirection: TextDirection.ltr,
            style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.normal,
                fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  };

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _AppState();
}

class _AppState extends State<MyApp> with WidgetsBindingObserver {
  late UserCubit _userCubit;
  final AppRouter _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();

   /* _userCubit = UserCubit();
    WidgetsBinding.instance.addObserver(this);
    if (_userCubit.state is UserLogInSuccess) {
      final token = (_userCubit.state as UserLogInSuccess).user.token;
      _userCubit.refreshUserData(token!);
    }*/
  }

  @override
  void dispose() {
    //WidgetsBinding.instance.removeObserver(this);
    //_userCubit.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    /*if (state == AppLifecycleState.resumed ||
        state == AppLifecycleState.inactive) {
      final token = _userCubit.state is UserLogInSuccess
          ? (_userCubit.state as UserLogInSuccess).user.token
          : null;
      if (token != null) {
        await _userCubit.refreshUserData(token);
      }
    }*/
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return RepositoryProvider(
      lazy: false,
      create: (context) => ClubRepository(),
      child: MultiBlocProvider(
        providers: [
          /*louay*/
          BlocProvider<CourseCubit>(
              create: (context) => CourseCubit(), lazy: true),
          ChangeNotifierProvider(create: (_) => Controller()),
          ChangeNotifierProvider(create: (context) => BoardController()),
          ChangeNotifierProvider(create: (context) => Navigation()),
          BlocProvider(create: (context) => DrawerCubit()),
          //end game providers
          //chat provider
          ChangeNotifierProvider(create: (context) => SocketService()),
          ChangeNotifierProvider(create: (context) => ChatService()),
          BlocProvider<UsersDataCubit>(
              create: (context) => UsersDataCubit(), lazy: true),
          /* end louay*/

          BlocProvider<EventCubit>(create: (context) => EventCubit()),
          BlocProvider<ConnectivityCubit>(
              create: (context) => ConnectivityCubit(), lazy: false),
          BlocProvider<UserCubit>(create: (context) => UserCubit(), lazy: true),
          BlocProvider<ClubCubit>(
              create: (context) => ClubCubit(
                  BlocProvider.of<ConnectivityCubit>(context),
                  BlocProvider.of<UserCubit>(context),
                  context.read<ClubRepository>()),
              lazy: true),
          BlocProvider<LocationCubit>(
              create: (context) => LocationCubit(), lazy: true),
          BlocProvider<ClubEventCubit>(
              create: (context) => ClubEventCubit(
                  BlocProvider.of<ConnectivityCubit>(context),
                  context.read<ClubRepository>()),
              lazy: true),
          BlocProvider<ApplicationCubit>(
              create: (context) => ApplicationCubit(
                  BlocProvider.of<ConnectivityCubit>(context),
                  context.read<ClubRepository>(),
                  BlocProvider.of<UserCubit>(context)),
              lazy: true),
          // souhail blocs
          BlocProvider<QuizCubit>(create: (context) => QuizCubit(), lazy: true),
          BlocProvider<CourseCubit>(
              create: (context) => CourseCubit(), lazy: true),
          BlocProvider<LeaderboardCubit>(
              create: (context) => LeaderboardCubit(), lazy: true),
          BlocProvider<CodingProblemCubit>(
              create: (context) => CodingProblemCubit(), lazy: true),
          BlocProvider<SubmissionCubit>(
              create: (context) => SubmissionCubit(), lazy: true),
          BlocProvider<TopSolutionsCubit>(
              create: (context) => TopSolutionsCubit(), lazy: true),
          BlocProvider<UsernameAvailableCubit>(
              create: (context) => UsernameAvailableCubit(), lazy: true),
          BlocProvider<PostCubit>(create: (context) => PostCubit(), lazy: true),
        ],
        child: MaterialApp(
          title: AppStrings.kappName,
          debugShowCheckedModeBanner: false,
          showPerformanceOverlay: false,
          theme: lightTheme,
          themeMode: ThemeMode.light,
          onGenerateRoute: _appRouter.onGenerateRoute,
          home: BlocBuilder<UserCubit, UserState>(
            buildWhen: (oldState, newState) => oldState is UserInitial && newState is! UserLoadInProgress,
            builder: (context, state) {
              if (state is UserLogInSuccess) {

                BlocProvider.of<UserCubit>(context).refreshUserData(state.user.token!);


                return Builder(builder: (context) {
                  final clubState = context.watch<ClubCubit>().state;
                  if (clubState is ClubLoadSuccess && BlocProvider.of<ClubCubit>(context).getClub() != null) {
                    return ClubScreen(club: BlocProvider.of<ClubCubit>(context).getClub());
                  } else {
                    return const ZoomDrawerScreen();
                  }
                });
              } else {
                return SignInScreen();
              }
            },
          ),
      ),
    ),);
  }
}
