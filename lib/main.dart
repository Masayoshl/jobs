import 'package:flutter/material.dart';
import 'package:jobs/UI/router/main_router.dart';
import 'package:jobs/UI/theme/theme.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  static final mainRouter = MainRouter();

  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: CustomAppTheme.lightTheme,
      darkTheme: CustomAppTheme.darkTheme,
      onGenerateRoute: mainRouter.onGenerateRoute,
    );
  }
}
