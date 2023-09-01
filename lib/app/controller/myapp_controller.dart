import '../../_controller.dart';

import '../../_view.dart';

class MyAppController extends StateXController with handlesErrors {
  factory MyAppController({bool? errorInBuild}) =>
      _this ??= MyAppController._(errorInBuild);
  // hidden constructor
  MyAppController._([bool? errorInBuild]) {
    // Record the current 'Error Widget'
    errorWidgetBuilder = ErrorWidget.builder;
    // Supply an 'error widget' when the intended widget fails to build.
    ErrorWidget.builder = (details) =>
        AppWidgetErrorDisplayed(handler: this, stackTrace: kDebugMode)
            .builder(details);
    // Don't cause an error in the 'build' function
    this.errorInBuild = errorInBuild ?? false;
  }
  // Only one instance of this controller class
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
            _useMaterialDesign(use: false);
            break;
          case 'to Material':
            _useMaterialDesign(use: true);
            break;
          case changeColor:
            ColorPickerController()
                .changeColor(onChange: (_) => rootState?.setState(() {}));
            break;
          case changeFont:
            GoogleFontsController().changeFont();
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

  // Set the appropriate flag and record the setting.
  void _useMaterialDesign({required bool? use}) {
    useMaterial = use ?? true;
    Prefs.setBool('useMaterial', useMaterial);
    state?.setState(() {}); // As it happens, it's the 'first' State object
    rootState?.setState(() {}); // rootState is the 'first' State object
  }
}
