import 'package:esjourney/chatest/chat_service.dart';
import 'package:esjourney/chatest/socket_service.dart';
import 'package:esjourney/logic/app_bloc_observer.dart';
import 'package:esjourney/logic/cubits/chat/user/users_cubit.dart';
import 'package:esjourney/logic/cubits/connectivity/connectivity_cubit.dart';
import 'package:esjourney/logic/cubits/curriculum/course_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:esjourney/presentation/router/app_router.dart';
import 'package:esjourney/presentation/screens/curriculum/games/draw/core/bloc/user_cubit/drawer_cubit.dart';
import 'package:esjourney/presentation/screens/sign_in_screen.dart';
import 'package:esjourney/presentation/screens/zoom_drawer_screen.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'presentation/screens/curriculum/games/draw/main_module.dart';
import 'presentation/screens/curriculum/games/slide/tools/board_controller.dart';
import 'presentation/screens/curriculum/games/slide/tools/navigation.dart';
import 'presentation/screens/curriculum/games/worldy/provider/controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MainModule.init();

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
  runApp(MyApp());
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
          //start game providers
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
          //end chat provider
          BlocProvider<ConnectivityCubit>(
              create: (context) => ConnectivityCubit(), lazy: false),
          BlocProvider<UserCubit>(create: (context) => UserCubit(), lazy: true),
          BlocProvider<CourseCubit>(
              create: (context) => CourseCubit(), lazy: true),
        ],
        child: MaterialApp(
          title: 'ESJourney',
          debugShowCheckedModeBanner: false,
          showPerformanceOverlay: false,
          theme: lightTheme,
          themeMode: ThemeMode.light,
          onGenerateRoute: _appRouter.onGenerateRoute,
          home: BlocBuilder<UserCubit, UserState>(
            buildWhen: (oldState, newState) =>
                oldState is UserInitial && newState is! UserLoadInProgress,
            builder: (context, state) {
              if (state is UserLogInSuccess) {
                final socketService =
                    Provider.of<SocketService>(context, listen: false);
                socketService.connect(state.user.token!);
                return const ZoomDrawerScreen();
              } else {
                return SignInScreen();
              }
            },
          ),
        ));
  }
}
