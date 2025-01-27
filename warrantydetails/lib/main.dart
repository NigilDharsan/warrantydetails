import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:warrantydetails/src/Login/loginScreen.dart';
import 'package:warrantydetails/utils/Language/Language.dart';
import 'package:warrantydetails/utils/Language/LocaleString.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Locale initialLocale = await getSavedLocale(); // Load saved locale
  // Get.put(LoaderController()); // Keep the controller alive

  runApp(MyApp(
    initialLocale: initialLocale,
  ));
}

class MyApp extends StatelessWidget {
  final Locale initialLocale;

  MyApp({required this.initialLocale});

  static void setLocale(BuildContext context, Locale locale) {
    Get.updateLocale(locale);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Warranty Details',
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.red,
          selectionColor: Colors.white,
          selectionHandleColor: Colors.red,
        ),
      ),
      translations: LocaleString(), // Provide translations
      locale: initialLocale, // Default locale
      fallbackLocale: Locale('en', 'US'), // Fallback if locale not found
      home: Loginscreen(),
      // builder: (context, child) {
      //   return Stack(
      //     children: [
      //       child!,
      //       Loader(), // Add the Loader widget here
      //     ],
      //   );
      // },
    );
  }
}
