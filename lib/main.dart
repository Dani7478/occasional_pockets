import 'linked_screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FYP Project',
      theme: ThemeData.light().copyWith(
          primaryColorLight: Colors.orangeAccent,
          backgroundColor: Colors.white,
          primaryColor: const Color(0xfff78205),
          primaryIconTheme: const IconThemeData(
            color: Colors.orangeAccent,
          )),
      home: const SplashView(),
    );
  }
}
