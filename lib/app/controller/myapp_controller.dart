///
import '../../_controller.dart';

import '../../_view.dart';

class MyAppController extends StateXController {
  factory MyAppController() => _this ??= MyAppController._();
  MyAppController._();
  static MyAppController? _this;

  ///
  final String title = 'AppStateX Demo App';

  /// Flag indicating the preferred Interface design
  bool useMaterial = true;

  @override
  Future<bool> initAsync() async {
    // Interface design first displayed
    useMaterial = await Prefs.getBoolF('useMaterial', true);
    return true;
  }
}
