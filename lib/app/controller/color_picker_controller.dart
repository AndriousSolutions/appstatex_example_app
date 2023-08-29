///
import '../../_view.dart';

class ColorPickerController extends StateXController {
  factory ColorPickerController() => _this ??= ColorPickerController._();
  ColorPickerController._();
  static ColorPickerController? _this;

  ///
  MaterialColor get materialColor => _materialColor;
  MaterialColor _materialColor = Colors.deepPurple;

  /// Change the app's colour theme
  Future<void> changeColor({
    ValueChanged<Color>? onColorChange,
    ValueChanged<ColorSwatch<int?>>? onChange,
  }) async {
    // controllers have access to the 'latest' context
    var context = lastContext!;

    // Get the current colour.
    ColorPicker.color = _materialColor;

    await ColorPicker.showColorPicker(
      context: context,
      onColorChange: (Color value) {
        /// Implement to take in a color change.
        if (onColorChange != null) {
          onColorChange(value);
        }
      },
      onChange: ([ColorSwatch<int?>? value]) {
        //
        if (value != null) {
          _materialColor = value as MaterialColor;
          if (onChange != null) {
            onChange(value);
          }
        }
      },
      shrinkWrap: true,
    );
  }
}
