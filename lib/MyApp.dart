import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:real_todo/screen/Splash_screen.dart';
import 'package:real_todo/screen/state_manegers/InprogressTask_controller.dart';
import 'package:real_todo/screen/state_manegers/getDelet_controller.dart';
import 'package:real_todo/screen/state_manegers/login_Controller.dart';
import 'package:real_todo/screen/state_manegers/new_task_controller.dart';
import 'package:real_todo/screen/state_manegers/summary_count_controller.dart';
class MyApp extends StatefulWidget {
  static GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      key: MyApp.globalKey,
      home: Splash_screen(),
      theme: ThemeData(
          textTheme: TextTheme(
              titleLarge:  TextStyle(fontSize: 32,fontWeight: FontWeight.w500,letterSpacing: 0.5)
          ),
          primarySwatch: Colors.green,
          brightness: Brightness.light,
          inputDecorationTheme: const InputDecorationTheme(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none
              )
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:const EdgeInsets.symmetric(vertical: 10),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              )
          )
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark
      ),
      initialBinding: ControllerBinding(),
      themeMode: ThemeMode.light,
    );
  }
}
class ControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(SummaryCountController());
    Get.put(NewTaskController());
    Get.put(GetDeleteController());
    Get.put(InprogressController());
  }

}