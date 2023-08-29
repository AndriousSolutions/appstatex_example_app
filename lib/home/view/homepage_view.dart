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
      : super(controller: MyHomePageController(), useInherited: true) {
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
}
