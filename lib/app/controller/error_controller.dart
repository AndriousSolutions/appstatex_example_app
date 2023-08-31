import '../../_view.dart';

mixin handlesErrors {
  /// Record the current Error widget builder
  late ErrorWidgetBuilder errorWidgetBuilder;

  late bool errorInBuild;
}
