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
    add(ColorPickerController());
    con = controller as MyHomePageController;
  }

  late MyHomePageController con;

  @override
  Widget buildIn(BuildContext context) {
    //
    Widget widget;

    if (con.useMaterial) {
      //
      widget = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
              style: TextStyle(
                fontSize: 18,
              ),
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
            const Padding(
              padding: EdgeInsets.only(top: 0, bottom: 0),
              child: Text('You have pushed the button this many times:',
                  style: TextStyle(fontSize: 13)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 0),
              child: state(
                (context) => Text(
                  con.data,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: CupertinoButton.filled(
                onPressed: () {
                  // This code is greyed out by the IDE because it can never bt reached.
                  setState(con.onPressed);
                },
                child: const Text('Add'),
              ),
            ),
          ],
        ),
      );
    }
    return widget;
  }
}
