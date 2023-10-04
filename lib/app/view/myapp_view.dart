///
import 'package:flutter/cupertino.dart';

import 'package:flutter/rendering.dart' as debug;

/// Localizations
import 'package:flutter_localizations/flutter_localizations.dart'
    show
        GlobalCupertinoLocalizations,
        GlobalMaterialLocalizations,
        GlobalWidgetsLocalizations;

import '../../_controller.dart';

import '../../_view.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State createState() => _MyAppState();
}

/// The 'root' State object
class _MyAppState extends AppStateX<MyApp> {
  _MyAppState()
      : dev = DevTools(),
        con = MyHomePageController(
            initError: false), // Cause an error in initAsync() function
        super(controller: MyAppController(errorInBuild: false), controllers: [
          Prefs(),
          GoogleFontsController(),
        ]) {
    appCon = controller as MyAppController;
  }

  final DevTools dev;
  late MyAppController appCon;
  late MyHomePageController con;
  GoogleFontsController? googleFonts;

  @override
  void initState() {
    super.initState();
    // Since this controller uses a factory constructor, both achieves the same thing.
    googleFonts = controllerByType<GoogleFontsController>();
    googleFonts = GoogleFontsController();
  }

  // This widget is the root of your application
  // The buildIn() is only called once ever.
  @override
  Widget buildIn(BuildContext context) {
    //
    if (appCon.errorInBuild) {
      // It'll trip again instantly and so don't trip it again.
      appCon.errorInBuild = false;
      // Invoke an error
      throw Exception('Error in build!');
    }

    assert(() {
      // Highlights UI while debugging.
      debug.debugPaintSizeEnabled = dev.debugPaintSizeEnabled;
      debug.debugPaintBaselinesEnabled = dev.debugPaintBaselinesEnabled;
      debug.debugPaintPointersEnabled = dev.debugPaintPointersEnabled;
      debug.debugPaintLayerBordersEnabled = dev.debugPaintLayerBordersEnabled;
      debug.debugRepaintRainbowEnabled = dev.debugRepaintRainbowEnabled;
      debug.debugRepaintTextRainbowEnabled = dev.debugRepaintTextRainbowEnabled;
      return true;
    }());

    // Which interface design to display
    if (appCon.useMaterial) {
      //
      return _materialView();
    } else {
      //
      return _cupertinoView();
    }
  }

  /// Material
  Widget _materialView() {
    // The selected color scheme
    final colorScheme =
        ColorScheme.fromSeed(seedColor: ColorPickerController().materialColor);

    return MaterialApp(
      debugShowMaterialGrid: dev.debugShowMaterialGrid,
      showPerformanceOverlay: dev.showPerformanceOverlay,
      showSemanticsDebugger: dev.showSemanticsDebugger,
      debugShowCheckedModeBanner: dev.debugShowCheckedModeBanner,
      title: appCon.title,
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: dev.useMaterial3,
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: googleFonts?.font,
            ),
      ),
      locale: const Locale('en', 'CA'),
      localizationsDelegates: const [
        DefaultWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: colorScheme.inversePrimary,
          title: const Text('Flutter Demo Home Page'),
          actions: [appCon.popupMenuButton],
        ),
        drawer: Drawer(child: appCon.drawer),
        body: const MyHomePage(),
        floatingActionButton: FloatingActionButton(
          onPressed: con.onPressed,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  /// Cupertino
  Widget _cupertinoView() {
    //
    return CupertinoApp(
      showPerformanceOverlay: dev.showPerformanceOverlay,
      showSemanticsDebugger: dev.showSemanticsDebugger,
      debugShowCheckedModeBanner: dev.debugShowCheckedModeBanner,
      title: appCon.title,
      theme: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontFamily: googleFonts?.font,
          ),
        ),
      ),
      locale: const Locale('en', 'CA'),
      localizationsDelegates: const [
        DefaultWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      home: CupertinoTabScaffold(
          key: const Key('Scaffold'),
          tabBar: CupertinoTabBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.search_circle_fill),
                label: 'Settings',
              ),
            ],
          ),
          tabBuilder: (BuildContext context, int index) {
            //
            if (index == 0) {
              //
              return CustomScrollView(slivers: <Widget>[
                CupertinoSliverNavigationBar(
                  largeTitle: Text(
                    'Counter Page Demo',
                    style: TextStyle(fontFamily: googleFonts?.font),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Material(child: appCon.popupMenuButton),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(child: MyHomePage()),
              ]);
            } else {
              //
              return Drawer(child: appCon.drawer);
            }
          }),
    );
  }

  @override
  Widget? onSplashScreen(context) => const SplashScreen();
}
