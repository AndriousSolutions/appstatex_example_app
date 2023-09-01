import 'dart:ui' as i;

import 'package:flutter/rendering.dart';

import '../../_controller.dart';

import '../../_view.dart';

/// A simply 'Widget Error' Screen if an app's widget fails to display
class AppWidgetErrorDisplayed {
  ///
  AppWidgetErrorDisplayed({
    this.key,
    required this.handler,
    this.paragraphStyle,
    this.textStyle,
    this.padding,
    this.minimumWidth,
    this.backgroundColor,
    this.customPainter,
    this.stackTrace = false,
  });

  ///
  final Key? key;

  ///
  final handlesErrors handler;

  ///
  final i.ParagraphStyle? paragraphStyle;

  ///
  final i.TextStyle? textStyle;

  ///
  final EdgeInsets? padding;

  ///
  final double? minimumWidth;

  ///
  final Color? backgroundColor;

  ///
  final CustomPainter? customPainter;

  ///
  final bool? stackTrace;

  ///
  Widget builder(
    FlutterErrorDetails details, {
    i.ParagraphStyle? paragraphStyle,
    i.TextStyle? textStyle,
    EdgeInsets? padding,
    double? minimumWidth,
    Color? backgroundColor,
    CustomPainter? customPainter,
  }) {
    String? message;
    try {
      //
      message = '\n\n${details.exception}\n\n';

      if (details.stack != null && stackTrace != null && stackTrace!) {
        //
        final stack = details.stack.toString().split('\n');

        final length = stack.length > 5 ? 5 : stack.length;

        final buffer = StringBuffer()..write(message);

        for (var i = 0; i < length; i++) {
          buffer.write('${stack[i]}\n');
        }
        message = buffer.toString();
      }
    } catch (e) {
      message = null;
    }
    Widget builder;
    try {
      builder = _ErrorRenderObjectWidget(
        key: key,
        details: details,
        message: message,
        error: details.exception,
        paragraphStyle: paragraphStyle ?? this.paragraphStyle,
        textStyle: textStyle ?? this.textStyle,
        padding: padding ?? this.padding,
        minimumWidth: minimumWidth ?? this.minimumWidth,
        backgroundColor:
            backgroundColor ?? this.backgroundColor ?? const Color(0xFFFFFFFF),
      );
    } catch (_) {
      builder = handler.errorWidgetBuilder(details);
    }
    return builder;
  }
}

/// A low-level widget to present instead of the failed widget.
class _ErrorRenderObjectWidget extends LeafRenderObjectWidget {
  /// Supply an error message to display an Error object.
  const _ErrorRenderObjectWidget({
    super.key,
    required this.details,
    this.message,
    this.error,
    this.paragraphStyle,
    this.textStyle,
    this.padding,
    this.minimumWidth,
    this.backgroundColor,
  });

  ///
  final FlutterErrorDetails? details;

  /// The message to display.
  final String? message;

  ///
  final Object? error;

  ///
  final i.ParagraphStyle? paragraphStyle;

  ///
  final i.TextStyle? textStyle;

  ///
  final EdgeInsets? padding;

  ///
  final double? minimumWidth;

  ///
  final Color? backgroundColor;

  @override
  RenderBox createRenderObject(BuildContext context) => _ErrorBox(
        details: details,
        paragraphStyle: paragraphStyle,
        textStyle: textStyle,
        padding: padding,
        minimumWidth: minimumWidth,
        backgroundColor: backgroundColor,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final value = details?.exception.toString() ?? '';
    if (error == null || error is! FlutterError) {
      properties.add(StringProperty('message', value, quoted: false));
    } else {
      final FlutterError flutterError = error as FlutterError;
      properties.add(flutterError.toDiagnosticsNode(
          style: DiagnosticsTreeStyle.whitespace));
    }
  }
}

class _ErrorBox extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  ///
  /// A message can optionally be provided. If a message is provided, an attempt
  /// will be made to render the message when the box paints.
  _ErrorBox({
    required this.details,
    i.ParagraphStyle? paragraphStyle,
    // ignore: avoid_unused_constructor_parameters
    i.TextStyle? textStyle,
    EdgeInsets? padding,
    double? minimumWidth,
    Color? backgroundColor,
  }) {
    // Supply a style if not explicitly provided.
    _paragraphStyle = paragraphStyle ??
        i.ParagraphStyle(
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.left,
        );

//    _textStyle = textStyle ?? _initTextStyle();  // Not used??

    _padding = padding ?? const EdgeInsets.fromLTRB(34, 96, 34, 12);

    _minimumWidth = minimumWidth ?? 200;

    _backgroundColor = backgroundColor ?? _initBackgroundColor();

    String? message;

    if (details != null) {
      message = details!.exception.toString();
    }
    _message =
        message == null || message.isEmpty ? 'Unknown Error!' : message.trim();
  }

  ///
  FlutterErrorDetails? details;

  @override
  void paint(PaintingContext context, Offset offset) {
    try {
      //
      context.canvas.drawRect(offset & size, Paint()..color = _backgroundColor);

      _drawWordERROR(context, 0, text: 'Oops!');

      _drawIcon(context, 50);

      _drawAppName(context, 100);

      _drawMessage(context, 150);

      _drawErrorMessage(context, 200, offset);

      // Draw a rectangle around the screen
      _drawRect(context);
    } catch (ex) {
      // If an error happens here we're in a terrible state, so we really should
      // just forget about it and let the developer deal with the already-reported
      // errors. It's unlikely that these errors are going to help with that.
    }
  }

  /// The message to attempt to display at paint time.
  late String? _message;

//  late i.Paragraph _paragraph;  // Not used??

  /// The paragraph style to use when painting [RenderBox] objects.
  late i.ParagraphStyle _paragraphStyle;

  /// The text style to use when painting [RenderBox] objects.
  /// a dark gray sans-serif font.
//  late i.TextStyle _textStyle;  // Not used??

  /// The distance to place around the text.
  ///
  /// This is intended to ensure that if the [RenderBox] is placed at the top left
  /// of the screen, under the system's status bar, the error text is still visible in
  /// the area below the status bar.
  ///
  /// The padding is ignored if the error box is smaller than the padding.
  ///
  /// See also:
  ///
  ///  * [_minimumWidth], which controls how wide the box must be before the
  //     horizontal padding is applied.
  late EdgeInsets _padding;

  /// The width below which the horizontal padding is not applied.
  ///
  /// If the left and right padding would reduce the available width to less than
  /// this value, then the text is rendered flush with the left edge.
  late double _minimumWidth;

  /// The color to use when painting the background of [RenderBox] objects.
  /// a red from a light gray.
  late Color _backgroundColor;

  @override
  double computeMaxIntrinsicWidth(double height) => 100000;

  @override
  double computeMaxIntrinsicHeight(double width) => 100000;

  @override
  bool get sizedByParent => true;

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void performResize() {
    size = constraints.constrain(const Size(100000, 100000));
  }

  /// Light gray in production; Red in development.
  Color _initBackgroundColor() {
    var result = const Color(0xF0C0C0C0);
    assert(() {
      result = const Color(0xF0900000);
      return true;
    }());
    return result;
  }

  // /// Black text in production; Yellow in development.
  // i.TextStyle _initTextStyle() {
  //   var result = i.TextStyle(
  //     color: const Color(0xFF303030),
  //     fontFamily: 'sans-serif',
  //     fontSize: 18,
  //   );
  //   assert(() {
  //     result = i.TextStyle(
  //       color: const Color(0xFFFFFF66),
  //       fontFamily: 'monospace',
  //       fontSize: 14,
  //       fontWeight: FontWeight.bold,
  //     );
  //     return true;
  //   }());
  //   return result;
  // }

  void _drawWordERROR(PaintingContext context, double top, {String? text}) {
    text ??= 'ERROR';
    final builder = i.ParagraphBuilder(i.ParagraphStyle(
      textAlign: TextAlign.center,
    ))
      ..pushStyle(i.TextStyle(
        color: Colors.red,
        fontSize: 30,
        fontWeight: FontWeight.w700,
        textBaseline: TextBaseline.alphabetic,
      ))
      ..addText(text);
    final paragraph = builder.build();
    paragraph.layout(i.ParagraphConstraints(width: _minimumWidth));
    context.canvas.drawParagraph(
      paragraph,
      Offset(
        (size.width - paragraph.width) * 0.5,
        _padding.top + top, //(size.height - paragraph.height) * 0.5,
      ),
    );
  }

  void _drawIcon(PaintingContext context, double top) {
    const icon = Icons.error;
    final builder = i.ParagraphBuilder(i.ParagraphStyle(
      fontFamily: icon.fontFamily,
    ))
      ..addText(String.fromCharCode(icon.codePoint));
    final paragraph = builder.build();
    paragraph.layout(i.ParagraphConstraints(width: size.width * 0.5));
    context.canvas.drawParagraph(
      paragraph,
      Offset(
        (size.width - paragraph.width) * 0.5,
        _padding.top + top,
      ),
    );
  }

  void _drawAppName(PaintingContext context, double top) {
    var value = details?.context?.toDescription() ?? '';
    final index = value.indexOf('-');
    if (index > 0) {
      value = value.substring(0, index);
    }
    final builder = i.ParagraphBuilder(i.ParagraphStyle(
      textAlign: TextAlign.center,
    ))
      ..pushStyle(i.TextStyle(
        color: Colors.black,
        fontSize: 18,
        textBaseline: TextBaseline.alphabetic,
      ))
      ..addText(value);
    final paragraph = builder.build();
    paragraph.layout(
        i.ParagraphConstraints(width: (size.width - paragraph.width) * 0.5));
    context.canvas.drawParagraph(
      paragraph,
      Offset(
        (size.width - paragraph.width) * 0.5,
        _padding.top + top,
      ),
    );
  }

  void _drawMessage(PaintingContext context, double top) {
    const text = 'An error has occurred in this app.\n';
    final builder = i.ParagraphBuilder(i.ParagraphStyle(
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    ))
      ..pushStyle(i.TextStyle(
        color: Colors.black,
        fontSize: 24,
        textBaseline: TextBaseline.alphabetic,
      ))
      ..addText(text);
    final paragraph = builder.build();
    paragraph
        .layout(i.ParagraphConstraints(width: size.width - _padding.right));
    context.canvas.drawParagraph(
      paragraph,
      Offset(
        _padding.left,
        _padding.top + top,
      ),
    );
  }

  void _drawErrorMessage(PaintingContext context, double top, Offset offset) {
    //
    final builder = i.ParagraphBuilder(_paragraphStyle)
      ..pushStyle(i.TextStyle(color: Colors.black, fontSize: 18))
      ..addText(_message!);

    final paragraph = builder.build();

    //
    var width = size.width;
    if (width > _padding.left + _minimumWidth + _padding.right) {
      width -= _padding.left + _padding.right;
    }

    paragraph.layout(i.ParagraphConstraints(width: width));

    context.canvas.drawParagraph(
        paragraph, offset + Offset(_padding.left, _padding.top + top));
  }

  // Draw a rectangle around the screen
  void _drawRect(PaintingContext context) {
    final right = size.width - _padding.right / 2;
    final bottom = size.height - _padding.bottom;
    final rect =
        Rect.fromLTRB(_padding.left / 2, _padding.top / 2, right, bottom);
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    context.canvas.drawRect(rect, paint);
  }
}
