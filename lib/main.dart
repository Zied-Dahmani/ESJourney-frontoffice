import 'package:esjourney/logic/app_bloc_observer.dart';
import 'package:esjourney/presentation/router/app_router.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  HydratedBlocOverrides.runZoned(() => runApp(MyApp()),
      storage: storage, blocObserver: AppBlocObserver());
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
          //BlocProvider<UserCubit>(create: (context) => UserCubit(), lazy: true),
          //BlocProvider<ConnectivityCubit>(create: (context) => ConnectivityCubit(), lazy: false),
          //BlocProvider<EventCubit>(create: (context) => EventCubit(BlocProvider.of<ConnectivityCubit>(context)), lazy: true),
        ],
        child: MaterialApp(
          title: 'ESJourney',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          themeMode: ThemeMode.light,
          onGenerateRoute: _appRouter.onGenerateRoute,
          /*home: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
            if (state is UserLogInSuccess) {
              return const MainScreen();
            }
            return const OnBoardingScreen();
          }),*/
        ));
  }
}


