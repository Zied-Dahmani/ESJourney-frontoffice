import 'package:esjourney/logic/app_bloc_observer.dart';
import 'package:esjourney/logic/cubits/challenges/quiz_cubit.dart';
import 'package:esjourney/logic/cubits/connectivity/connectivity_cubit.dart';
import 'package:esjourney/logic/cubits/curriculum/course_cubit.dart';
import 'package:esjourney/logic/cubits/events/event_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:esjourney/presentation/router/app_router.dart';
import 'package:esjourney/presentation/screens/sign_in_screen.dart';
import 'package:esjourney/presentation/screens/zoom_drawer_screen.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _AppState();
}

class _AppState extends State<MyApp> with WidgetsBindingObserver {
  late UserCubit _userCubit;

  @override
  void initState() {
    super.initState();
    _userCubit = UserCubit();
    WidgetsBinding.instance.addObserver(this);
    if (_userCubit.state is UserLogInSuccess) {
      final token = (_userCubit.state as UserLogInSuccess).user.token;
      _userCubit.refreshUserData(token);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _userCubit.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed ||
        state == AppLifecycleState.inactive) {
      final token = _userCubit.state is UserLogInSuccess
          ? (_userCubit.state as UserLogInSuccess).user.token
          : null;
      if (token != null) {
        await _userCubit.refreshUserData(token);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiBlocProvider(
        providers: [
          BlocProvider<ConnectivityCubit>(
              create: (context) => ConnectivityCubit()),
          BlocProvider<UserCubit>.value(value: _userCubit),
          BlocProvider<QuizCubit>(create: (context) => QuizCubit()),
          BlocProvider<CourseCubit>(create: (context) => CourseCubit()),
          BlocProvider<EventCubit>(create: (context) => EventCubit()),
        ],
        child: MaterialApp(
          title: 'ESJourney',
          debugShowCheckedModeBanner: false,
          showPerformanceOverlay: false,
          theme: lightTheme,
          themeMode: ThemeMode.light,
          onGenerateRoute: AppRouter().onGenerateRoute,
          home: BlocBuilder<UserCubit, UserState>(
            buildWhen: (oldState, newState) => oldState is UserInitial && newState is! UserLoadInProgress,
            builder: (context, state) {
              if(state is UserLogInSuccess) {
                return const ZoomDrawerScreen();
              } else {
                return SignInScreen();
              }
            },
          ),
        ));
  }
}
