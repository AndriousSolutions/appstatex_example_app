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
    //
    final context = state!.context;

    // Get the current colour.
    ColorPicker.color = _materialColor;
//    ColorPicker.color = Color(Theme.of(context).primaryColor.value);
//    ColorPicker.color = Color(Theme.of(context).colorScheme.primary.value);

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
