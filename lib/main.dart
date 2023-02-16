import 'package:esjourney/logic/app_bloc_observer.dart';
import 'package:esjourney/logic/cubits/challenges/leaderboard_cubit.dart';
import 'package:esjourney/logic/cubits/challenges/quiz_cubit.dart';
import 'package:esjourney/logic/cubits/connectivity/connectivity_cubit.dart';
import 'package:esjourney/logic/cubits/curriculum/course_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:esjourney/presentation/router/app_router.dart';
import 'package:esjourney/presentation/screens/challenges/leaderboard/leaderboard_screen.dart';
import 'package:esjourney/presentation/screens/sign_in_screen.dart';
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
  BlocOverrides.runZoned(
        () {
      runApp(MyApp());
    },
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiBlocProvider(
        providers: [
          BlocProvider<ConnectivityCubit>(
              create: (context) => ConnectivityCubit(), lazy: false),
          BlocProvider<UserCubit>(create: (context) => UserCubit(), lazy: true),
          BlocProvider<QuizCubit>(create: (context) => QuizCubit(), lazy: true),
          BlocProvider<CourseCubit>(create: (context) => CourseCubit(), lazy: true),
          BlocProvider<LeaderboardCubit>(create: (context) => LeaderboardCubit(), lazy: true),

        ],
        child: MaterialApp(
          title: 'ESJourney',
          debugShowCheckedModeBanner: false,
          showPerformanceOverlay: false,
          theme: lightTheme,
          themeMode: ThemeMode.light,
          onGenerateRoute: _appRouter.onGenerateRoute,
          home: BlocBuilder<UserCubit, UserState>(
            buildWhen: (oldState, newState) => oldState is UserInitial && newState is! UserLoadInProgress,
            builder: (context, state) {
              if(state is UserLogInSuccess) {
                return const LeaderboardScreen();
              } else {
                return SignInScreen();
              }
            },
          ),
        ));
  }
}