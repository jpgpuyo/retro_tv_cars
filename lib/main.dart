import 'package:flutter/material.dart';

import 'common/injector.dart';
import 'screens/backtothefuture/back_to_the_future_screen.dart';
import 'screens/knightrider/knight_rider_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MyApp.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static init() {
    Injector.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Retro TV Cars',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          KnightRiderScreen(),
          BackToTheFutureScreen(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
