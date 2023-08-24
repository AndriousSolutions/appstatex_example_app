import '../../_controller.dart';

import '../../_model.dart';

import '../../_view.dart';

class MyHomePageController extends StateXController {
  factory MyHomePageController() => _this ??= MyHomePageController._();

  MyHomePageController._()
      : dataSource = DataSource(),
        devTools = DevTools(),
        color = ColorPickerController();
  static MyHomePageController? _this;

  ///
  final DataSource dataSource;

  ///
  final DevTools devTools;

  ///
  final ColorPickerController color;

  String get data => dataSource.count.toString();

  void onPressed() {
    setState(() {
      dataSource.incrementCounter();
    });
  }

  /// Dictate what is displayed in the Drawer
  Widget get drawer => DevToolsSettings();

  /// Flag indicating the preferred Interface design
  bool useMaterial = true;

  /// Provide a menu to this simple app.
  PopupMenuButton get popupMenuButton {
    //
    const changeColor = 'Change Color';
    var design = useMaterial ? 'to Cupertino' : 'to Material';

    final popupMenuButton = PopupMenuButton<String>(
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: changeColor,
          child: Text(changeColor),
        ),
        PopupMenuItem(
          value: design,
          child: Text(design),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 'to Cupertino':
            useMaterial = false;
            break;
          case 'to Material':
            useMaterial = true;
            break;
          case changeColor:
            color.changeColor();
            break;
          default:
        }
        rootState?.setState(() {});
      },
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 14,
    );
    return popupMenuButton;
  }
}
