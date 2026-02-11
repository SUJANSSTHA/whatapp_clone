import 'package:flutter/material.dart';
import 'package:whatapp_clone/features/app/splash/splash_Screen.dart';
import 'package:whatapp_clone/features/app/theme/style.dart';
import 'package:whatapp_clone/firebase_options.dart';
import 'package:whatapp_clone/routes/on_generate_routes.dart';
import 'main_injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
       theme: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.fromSeed(
              seedColor: tabColor,
              brightness: Brightness.dark
          ),
          scaffoldBackgroundColor: backgroundColor,
          dialogTheme: DialogThemeData(backgroundColor: backgroundColor),
          appBarTheme: const AppBarTheme(
            backgroundColor: appBarColor,
          ),
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
        '/': (context) => const SplashScreen(),
      },
    );
  }
}
