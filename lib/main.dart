import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tengesa/model/state/sales_state.dart';
import 'package:tengesa/model/state/user_state.dart';
import 'package:tengesa/ui/splash_screen/splash_screen.dart';
import 'package:tengesa/utils/colors.dart';
import 'package:tengesa/utils/strings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static Map<int, Color> color = {
    50: AppColors.primaryColor,
    100: AppColors.primaryColor,
    200: AppColors.primaryColor,
    300: AppColors.primaryColor,
    400: AppColors.primaryColor,
    500: AppColors.primaryColor,
    600: AppColors.primaryColor,
    700: AppColors.primaryColor,
    800: AppColors.primaryColor,
    900: AppColors.primaryColor
  };

  MaterialColor primaryColor = MaterialColor(0xFF880E4F, color);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SalesStateModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserStateModel(),
        ),
      ],
      child: MaterialApp(
        title: Strings.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Oxygen',
          primarySwatch: primaryColor,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
