import '../../_controller.dart';

import '../../_model.dart';

import '../../_view.dart';

class MyHomePageController extends StateXController with StateXonErrorMixin {
  factory MyHomePageController({bool? initError}) =>
      _this ??= MyHomePageController._(initError);
  MyHomePageController._([bool? initError]) : dataSource = DataSource() {
    /// Generate an error
    this.initError = initError ?? false;
  }
  static MyHomePageController? _this;

  ///
  @override
  Future<bool> initAsync() async {
    //
    if (initError) {
      // Turn it off now
      initError = false;
      throw Exception('Error in .initAsync() of $runtimeType!');
    }
    return true;
  }

  /// Flag allowing for an error when initializing
  bool initError = false;

  ///
  final DataSource dataSource;

  // Note this controller is concerned with the conversion
  String get data => dataSource.count.toString();

  /// Called by the State object's onPress named parameter
  void onPressed() {
    // No error handler when testing
    if (WidgetsBinding.instance is WidgetsFlutterBinding) {
      // Deliberately throw an error to demonstrate error handling.
      throw Exception('Fake error to demonstrate error handling!');
    }

    // Has access to the State object, _MyHomePageState
    setState(() {
      dataSource.incrementCounter();
    });
  }

  /// A means to handle errors possibly occurring in this controller
  @override
  void onError(details) {
    //
    var message = details.exception.toString();
    final index = message.indexOf(': ');
    if (index > 0) {
      message = message.substring(index + 2);
    }

    // Identify a particular exception
    if (message == 'Fake error to demonstrate error handling!') {
      // In a sense, we've recovered from the error
      // Increment the count like no error occurred
      setState(() {
        dataSource.incrementCounter();
      });
    }
  }
}
