///
import '../../_view.dart';

///
import 'package:google_fonts/google_fonts.dart';

///
class GoogleFontsController extends StateXController {
  @override
  Future<bool> initAsync() async {
    bool init = true;
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
    List<void> list = await GoogleFonts.pendingFonts();
    return init;
  }

  /// List of available fonts
  List<String> get fonts => _fonts;
  final List<String> _fonts = [];

  ///
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

  @override
  void onAsyncError(FlutterErrorDetails details) {}
}
