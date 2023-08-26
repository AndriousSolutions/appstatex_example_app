///
import '../../_controller.dart';

///
import '../../_view.dart';

///
import 'package:google_fonts/google_fonts.dart';

///
class GoogleFontsController extends StateXController {
  factory GoogleFontsController() => _this ??= GoogleFontsController._();
  GoogleFontsController._();
  static GoogleFontsController? _this;

  @override
  Future<bool> initAsync() async {
    // Ensure this is called once
    if (init) {
      return init;
    }
    init = true;

    // Determine the 'current' font
    _font = await Prefs.getStringF('font', GoogleFonts.roboto().fontFamily);

    _initFont(GoogleFonts.roboto);
    _initFont(GoogleFonts.openSans);
    _initFont(GoogleFonts.lato);
    _initFont(GoogleFonts.oswald);
    _initFont(GoogleFonts.slabo27px);
    _initFont(GoogleFonts.robotoCondensed);
    _initFont(GoogleFonts.montserrat);
    _initFont(GoogleFonts.sourceSansPro);
    _initFont(GoogleFonts.raleway);
    _initFont(GoogleFonts.ptSans);
    //ignore: unused_local_variable
    List<void> list = await GoogleFonts.pendingFonts();
    return init;
  }

  // Flag the init routine
  bool init = false;

  /// List of available fonts
  List<String> get fonts => _fonts;
  final List<String> _fonts = [];

  /// Add the font family name to a List
  bool _initFont(TextStyle Function() fontFunc) {
    bool init;
    try {
      TextStyle style = fontFunc();
      _fonts.add(style.fontFamily!);
      init = true;
    } catch (e) {
      init = false;
    }
    return init;
  }

  String get font => _font;
  String _font = '';

  /// Supply a means to change the font
  Future<void> changeFont() async {
    //
    List<String> fontNames = [];

    // Determine the 'current' font
    _font = Prefs.getString('font', GoogleFonts.roboto().fontFamily);

    //ignore: avoid_function_literals_in_foreach_calls
    fonts.forEach((font) {
      fontNames.add(font.replaceFirst('_regular', ''));
    });

    final initialItem = fontNames.indexOf(_font.replaceFirst('_regular', ''));

    int selectedIndex = -1;

    final spinner = GenericSpinner(
      initialItem: initialItem,
      items: fontNames,
      onSelectedItemChanged: (int index) {
        selectedIndex = index;
      },
      itemBuilder: (BuildContext context, int index) {
        return Text(fontNames[index]);
      },
    );

    await showFonts(
      onOK: () async {
        if (selectedIndex > 0 && selectedIndex < fontNames.length) {
          _font = fonts[selectedIndex];
          await Prefs.setString('font', _font);
          rootState?.setState(() {});
        }
      },
      child: spinner,
    );
  }

  ///
  Future<void> showFonts(
      {VoidCallback? onOK,
      VoidCallback? onCancel,
      required Widget child}) async {
    //
    final context = state?.lastContext;
    if (context == null) {
      return;
    }
    await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Font'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [child],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                onOK?.call();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                onCancel?.call();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void onAsyncError(FlutterErrorDetails details) {}
}
