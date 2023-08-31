import '../../_controller.dart';

import '../../_view.dart';

class MyAppController extends StateXController with handlesErrors {
  factory MyAppController({bool? errorInBuild}) =>
      _this ??= MyAppController._(errorInBuild);
  MyAppController._([bool? errorInBuild]) : fonts = GoogleFontsController() {
    // Record the current 'Error Widget'
    errorWidgetBuilder = ErrorWidget.builder;
    // Change the widget presented when another widget fails to build.
    ErrorWidget.builder = (details) =>
        AppWidgetErrorDisplayed(handler: this, stackTrace: kDebugMode)
            .builder(details);
    // Don't cause an error
    this.errorInBuild = errorInBuild ?? false;
  }

  static MyAppController? _this;

  ///
  final String title = 'AppStateX Demo App';

  /// Flag indicating the preferred Interface design
  bool useMaterial = true;

  /// Change the app's font
  final GoogleFontsController fonts;

  @override
  Future<bool> initAsync() async {
    // Interface design first displayed
    useMaterial = await Prefs.getBoolF('useMaterial', true);
    return true;
  }

  @override
  void dispose() {
    // Return Error Widget Builder
    ErrorWidget.builder = errorWidgetBuilder;
    super.dispose();
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
        // The Cupertino interface doesn't have the colors to change
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
            useMaterial = false;
            state?.setState(() {}); // As it happens, the 'first' State object
            rootState?.setState(() {}); // rootState is the 'first' State object
            break;
          case 'to Material':
            Prefs.setBool('useMaterial', true);
            useMaterial = true;
            state?.setState(() {}); // As it happens, the 'first' State object
            rootState?.setState(() {}); // rootState is the 'first' State object
            break;
          case changeColor:
            ColorPickerController()
                .changeColor(onChange: (_) => rootState?.setState(() {}));
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
