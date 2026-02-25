import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
    // show BlocProvider, MultiBlocProvider, BlocBuilder;
import 'package:whatapp_clone/features/app/home/home_page.dart';
import 'package:whatapp_clone/features/app/splash/splash_Screen.dart';
import 'package:whatapp_clone/features/app/theme/style.dart';
import 'package:whatapp_clone/features/user/presentation/cubit/auth/auth_cubit.dart';
import 'package:whatapp_clone/features/user/presentation/cubit/credential/credential_cubit.dart';
import 'package:whatapp_clone/features/user/presentation/cubit/get_device_number/get_device_number_cubit.dart';
import 'package:whatapp_clone/features/user/presentation/cubit/get_single_user/get_single_user_cubit.dart';
import 'package:whatapp_clone/features/user/presentation/cubit/user/user_cubit.dart';
import 'package:whatapp_clone/firebase_options.dart';
import 'package:whatapp_clone/routes/on_generate_routes.dart';
import 'main_injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<AuthCubit>()..appStarted()),
        BlocProvider(create: (context) => di.sl<CredentialCubit>()),
        BlocProvider(create: (context) => di.sl<GetSingleUserCubit>()),
        BlocProvider(create: (context) => di.sl<UserCubit>()),
        BlocProvider(create: (context) => di.sl<GetDeviceNumberCubit>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.fromSeed(
            seedColor: tabColor,
            brightness: Brightness.dark,
          ),
          scaffoldBackgroundColor: backgroundColor,
          dialogTheme: DialogThemeData(backgroundColor: backgroundColor),
          appBarTheme: const AppBarTheme(backgroundColor: appBarColor),
        ),
        // theme: ThemeData(
        //   scaffoldBackgroundColor: backgroundColor,
        //   appBarTheme: const AppBarTheme(
        //     backgroundColor : appBarColor,
        //   ), dialogTheme: DialogThemeData(backgroundColor: backgroundColor),
        // ),
        debugShowCheckedModeBanner: false,
        // home: SplashScreen(),
        initialRoute: '/',
        onGenerateRoute: OnGenerateRoutes.route,
       routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return HomePage(uid: authState.uid);
                }
                return SplashScreen();
              },
            );
          },}
      ),
    );
  }
}
