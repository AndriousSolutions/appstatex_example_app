import '../../_controller.dart';

import '../../_model.dart';

import '../../_view.dart';

class MyHomePageController extends StateXController {
  factory MyHomePageController() => _this ??= MyHomePageController._();
  MyHomePageController._() : dataSource = DataSource();
  static MyHomePageController? _this;

  ///
  final DataSource dataSource;

  // Note this controller is concerned with the conversion
  String get data => dataSource.count.toString();

  void onPressed() {
    // Has access to the State object, _MyHomePageState
    setState(() {
      dataSource.incrementCounter();
    });
  }
}
