import '../../_controller.dart';

import '../../_model.dart';

import '../../_view.dart';

class MyHomePageController extends StateXController {
  factory MyHomePageController() => _this ??= MyHomePageController._();
  MyHomePageController._()
      : dataSource = DataSource(),
        devTools = DevTools(),
        color = ColorPickerController(),
        fonts = GoogleFontsController();
  static MyHomePageController? _this;

  ///
  final DataSource dataSource;

  /// Display the appropriate development tools
  final DevTools devTools;

  /// Pick the app's color
  final ColorPickerController color;

  /// Change the app's font
  final GoogleFontsController fonts;

  @override
  void initState() {
    super.initState();
    // A list of ways to get the StateXController, MyAppController
    app = rootState?.controllerByType<MyAppController>();
    app = state?.rootCon as MyAppController;
    app = rootState?.controller as MyAppController;
  }

  MyAppController? app;

  // Use Material design
  bool get useMaterial => app?.useMaterial ?? true;

  // Note this controller is concerned with the conversion
  String get data => dataSource.count.toString();

  void onPressed() {
    setState(() {
      dataSource.incrementCounter();
    });
  }

  /// Dictate what is displayed in the Drawer
  Widget get drawer => DevToolsSettings();

  /// Provide a menu to this simple app.
  PopupMenuButton<String> get popupMenuButton {
    //
    const changeColor = 'Change Color';
    const changeFont = 'Change Font';
    var design = useMaterial ? 'to Cupertino' : 'to Material';

    final popupMenuButton = PopupMenuButton<String>(
      itemBuilder: (context) => [
        if (!(state?.usingCupertino ?? false))
          const PopupMenuItem(
            value: changeColor,
            child: Text(changeColor),
          ),
        const PopupMenuItem(
          value: changeFont,
          child: Text(changeFont),
        ),
        PopupMenuItem(
          value: design,
          child: Text(design),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 'to Cupertino':
            Prefs.setBool('useMaterial', false);
            app?.useMaterial = false;
            rootState?.setState(() {});
            break;
          case 'to Material':
            Prefs.setBool('useMaterial', true);
            app?.useMaterial = true;
            rootState?.setState(() {});
            break;
          case changeColor:
            color.changeColor(onChange: (_) => rootState?.setState(() {}));
            break;
          case changeFont:
            fonts.changeFont();
            break;
          default:
        }
      },
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 14,
    );
    return popupMenuButton;
  }
}
