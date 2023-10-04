///
import 'package:flutter/cupertino.dart';

///
import '../../_controller.dart';

///
import '../../_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends StateX<MyHomePage> {
  _MyHomePageState()
      : super(controller: MyHomePageController(), useInherited: false) {
    con = controller as MyHomePageController;
  }

  late MyHomePageController con;

  @override
  void initState() {
    super.initState();
    // A list of ways to get the StateXController object, MyAppController
    app = rootState?.controllerByType<MyAppController>();
    app = rootCon as MyAppController;
    app = rootState?.controller as MyAppController;
    app = MyAppController();
  }

  // The app's controller
  MyAppController? app;

  /// Supply an 'error handler' routine if something goes wrong
  /// in the corresponding runAsync() or initAsync() routine.
  @override
  void onAsyncError(FlutterErrorDetails details) {
    if (inDebugMode) {
      //ignore: avoid_print
      print('############ Event: Error in onAsyncError for $state');
    }
  }

  @override
  void onError(details) {
    // Have the controller handle the error
    con.onError(details);
  }

  // Place a breakpoint here and step through to see what's going on.
  @override
  //ignore: unnecessary_overrides
  Widget build(context) => super.build(context);

  @override
  Widget buildIn(BuildContext context) {
    //
    Widget widget;

    final theme = Theme.of(context);

    if (app?.useMaterial ?? true) {
      //
      widget = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
              style: TextStyle(fontSize: 18),
            ),
            state(
              (context) => Text(
                con.data,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      );
    } else {
      //
      widget = SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 150.0, bottom: 50.0),
              child: Text(
                'You have pushed the button this many times:',
                style: theme.textTheme.bodyLarge,
              ),
            ),
            state(
              (_) => Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 50.0),
                child: Text(
                  con.data,
                  style: theme.textTheme.headlineMedium,
                ),
              ),
            ),
            CupertinoButton.filled(
              onPressed: con.onPressed,
              child: const Text('Add'),
            ),
          ],
        ),
      );
    }
    return widget;
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when this object is reinserted into the tree after having been
  /// removed via [deactivate].
  @override
  //ignore: unnecessary_overrides
  void activate() {
    super.activate();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// The framework calls this method whenever it removes this [State] object
  /// from the tree.
  @override
  void deactivate() {
    super.deactivate();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// The framework calls this method when this [State] object will never
  /// build again.
  /// Note: THERE IS NO GUARANTEE THIS METHOD WILL RUN in the Framework.
  @override
  void dispose() {
    super.dispose();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Calls setState((){});
  void refresh() {
    super.setState(() {});
  }

  // Merely for demonstration purposes. Erase if not using.
  // ignore: comment_references
  /// Override this method to respond when the [widget] changes (e.g., to start
  /// implicit animations).
  @override
  void didUpdateWidget(StatefulWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when a dependency of this [State] object changes.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called whenever the application is reassembled during debugging, for
  /// example during hot reload.
  @override
  void reassemble() {
    super.reassemble();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the system tells the app to pop the current route.
  /// For example, on Android, this is called when the user presses
  /// the back button.
  /// Observers are notified in registration order until one returns
  /// true. If none return true, the application quits.
  @override
  Future<bool> didPopRoute() async {
    return super.didPopRoute();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the host tells the app to push a new route onto the
  /// navigator.
  ///
  /// Observers are expected to return true if they were able to
  /// handle the notification. Observers are notified in registration
  /// order until one returns true.
  ///
  /// This method exposes the `pushRoute` notification from
  // ignore: comment_references
  @override
  Future<bool> didPushRoute(String route) async {
    return super.didPushRoute(route);
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the application's dimensions change. For example,
  /// when a phone is rotated.
  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the platform's text scale factor changes.
  @override
  void didChangeTextScaleFactor() {
    super.didChangeTextScaleFactor();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Brightness changed.
  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the system tells the app that the user's locale has changed.
  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the system puts the app in the background or returns the app to the foreground.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    /// Passing these possible values:
    /// AppLifecycleState.paused (may enter the suspending state at any time)
    /// AppLifecycleState.resumed
    /// AppLifecycleState.inactive (may be paused at any time)
    /// AppLifecycleState.suspending (Android only)
    super.didChangeAppLifecycleState(state);
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the system is running low on memory.
  @override
  void didHaveMemoryPressure() {
    super.didHaveMemoryPressure();
  }

  // Merely for demonstration purposes. Erase if not using.
  /// Called when the system changes the set of active accessibility features.
  @override
  void didChangeAccessibilityFeatures() {
    super.didChangeAccessibilityFeatures();
  }
}
