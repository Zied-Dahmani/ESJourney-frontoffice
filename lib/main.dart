import 'package:esjourney/logic/app_bloc_observer.dart';
import 'package:esjourney/logic/cubits/club/club_cubit.dart';
import 'package:esjourney/logic/cubits/connectivity/connectivity_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_cubit.dart';
import 'package:esjourney/presentation/router/app_router.dart';
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
          BlocProvider<UserCubit>(create: (context) => UserCubit(), lazy: true),
          BlocProvider<ConnectivityCubit>(create: (context) => ConnectivityCubit(), lazy: false),
          BlocProvider<ClubCubit>(create: (context) => ClubCubit(BlocProvider.of<ConnectivityCubit>(context)), lazy: true),
        ],
        child: MaterialApp(
          title: 'ESJourney',
          debugShowCheckedModeBanner: false,
          showPerformanceOverlay: false,
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
