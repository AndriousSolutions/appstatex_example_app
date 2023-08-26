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
        colorPicker = ColorPickerController(),
        con = MyHomePageController(),
        super(controller: MyAppController(), controllers: [
          Prefs(),
          GoogleFontsController(),
        ]) {
    app = controller as MyAppController;
  }

  late MyAppController app;
  final DevTools dev;
  final ColorPickerController colorPicker;
  late MyHomePageController con;
  late GoogleFontsController? fonts;

  @override
  void initState() {
    super.initState();
    fonts = controllerByType<GoogleFontsController>();
  }

  // This widget is the root of your application
  // The buildIn() is only called once ever.
  @override
  Widget buildIn(BuildContext context) {
    //
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
    if (app.useMaterial) {
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
        ColorScheme.fromSeed(seedColor: colorPicker.materialColor);

    return MaterialApp(
      debugShowMaterialGrid: dev.debugShowMaterialGrid,
      showPerformanceOverlay: dev.showPerformanceOverlay,
      showSemanticsDebugger: dev.showSemanticsDebugger,
      debugShowCheckedModeBanner: dev.debugShowCheckedModeBanner,
      title: app.title,
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: dev.useMaterial3,
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: fonts?.font,
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
          actions: [con.popupMenuButton],
        ),
        drawer: Drawer(child: con.drawer),
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
      title: app.title,
      theme: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontFamily: fonts?.font,
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
                    style: TextStyle(fontFamily: fonts?.font),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Material(child: con.popupMenuButton),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(child: MyHomePage()),
              ]);
            } else {
              //
              return Drawer(child: con.drawer);
            }
          }),
    );
  }
}
