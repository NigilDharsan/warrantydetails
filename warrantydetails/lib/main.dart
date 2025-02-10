import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warrantydetails/src/Dashboard/Dashboard.dart';
import 'package:warrantydetails/src/Login/loginScreen.dart';
import 'package:warrantydetails/utils/Language/Language.dart';
import 'package:warrantydetails/utils/Language/LocaleString.dart';
import 'package:warrantydetails/utils/Provider/client_api.dart';
import 'package:warrantydetails/utils/config.dart';
import 'package:warrantydetails/utils/initial_binding/initial_binding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Locale initialLocale = await getSavedLocale(); // Load saved locale
  bool logged = await getLoggedStatus(); // Load saved locale

  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(
      appBaseUrl: Config.baseUrl, sharedPreferences: sharedPreferences));

  runApp(MyApp(
    initialLocale: initialLocale,
    logged: logged,
  ));
}

class MyApp extends StatelessWidget {
  final Locale initialLocale;
  final bool logged;

  MyApp({required this.initialLocale, required this.logged});

  static void setLocale(BuildContext context, Locale locale) {
    Get.updateLocale(locale);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Warranty Details',
      initialBinding: InitialBinding(),

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
      home: logged == true ? Dashboard() : Loginscreen(),
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
