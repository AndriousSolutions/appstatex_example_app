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

class _MyAppState extends AppStateX<MyApp> {
  _MyAppState()
      : dev = DevTools(),
        colorPicker = ColorPickerController(),
        con = MyHomePageController(),
        super(
          controllers: [
            GoogleFontsController(),
          ],
        );

  final DevTools dev;
  final ColorPickerController colorPicker;
  final MyHomePageController con;

  // This widget is the root of your application.
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

    if (con.useMaterial) {
      //
      return _materialView();
    } else {
      //
      return _cupertinoView();
    }
  }

  Widget _cupertinoView() {
    //
    return CupertinoApp(
      showPerformanceOverlay: dev.showPerformanceOverlay,
      // checkerboardRasterCacheImages: dev.checkerboardRasterCacheImages,
      // checkerboardOffscreenLayers: dev.checkerboardOffscreenLayers,
      showSemanticsDebugger: dev.showSemanticsDebugger,
      debugShowCheckedModeBanner: dev.debugShowCheckedModeBanner,
      title: 'Flutter Demo',
      theme: const CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(fontFamily: 'MaShanZheng'),
        ),
      ),
      locale: const Locale('en', 'CA'),
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      home: CupertinoPageScaffold(
        key: const Key('Scaffold'),
        child: CustomScrollView(slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Counter Page Demo'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Material(child: con.popupMenuButton),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: MyHomePage()),
        ]),
      ),
    );
  }

  Widget _materialView() {
    // The selected color scheme
    final colorScheme =
        ColorScheme.fromSeed(seedColor: colorPicker.materialColor);

    return MaterialApp(
      debugShowMaterialGrid: dev.debugShowMaterialGrid,
      showPerformanceOverlay: dev.showPerformanceOverlay,
      // checkerboardRasterCacheImages: dev.checkerboardRasterCacheImages,
      // checkerboardOffscreenLayers: dev.checkerboardOffscreenLayers,
      showSemanticsDebugger: dev.showSemanticsDebugger,
      debugShowCheckedModeBanner: dev.debugShowCheckedModeBanner,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: dev.useMaterial3,
        // textTheme: Theme.of(context).textTheme.apply(
        //       fontFamily: 'MaShanZheng',
        //     ),
      ),
      locale: const Locale('en', 'CA'),
      localizationsDelegates: const [
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
}
