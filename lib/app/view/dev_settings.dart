///
import '../../_view.dart';

///
import '../../_controller.dart';

///
class DevTools extends StateXController {
  /// Singleton Pattern
  factory DevTools() => _this ??= DevTools._();
  DevTools._();
  static DevTools? _this;

  ///
  bool get debugShowCheckedModeBanner => _debugShowCheckedModeBanner ??=
      Prefs.getBool('debugShowCheckedModeBanner', true);
  set debugShowCheckedModeBanner(bool? v) {
    //
    if (v != null) {
      //
      Prefs.setBool('debugShowCheckedModeBanner', v);
      _debugShowCheckedModeBanner = v;
      setSettingState();
    }
  }

  bool? _debugShowCheckedModeBanner;

  ///
  bool get debugShowMaterialGrid =>
      _debugShowMaterialGrid ??= Prefs.getBool('debugShowMaterialGrid', false);
  set debugShowMaterialGrid(bool? v) {
    //
    if (v != null) {
      //
      Prefs.setBool('debugShowMaterialGrid', v);
      _debugShowMaterialGrid = v;
      setSettingState();
    }
  }

  bool? _debugShowMaterialGrid;

  ///
  bool get debugPaintSizeEnabled =>
      _debugPaintSizeEnabled ??= Prefs.getBool('debugPaintSizeEnabled', false);
  set debugPaintSizeEnabled(bool? v) {
    //
    if (v != null) {
      //
      Prefs.setBool('debugPaintSizeEnabled', v);
      _debugPaintSizeEnabled = v;
      setSettingState();
    }
  }

  bool? _debugPaintSizeEnabled;

  ///
  bool get debugPaintBaselinesEnabled => _debugPaintBaselinesEnabled ??=
      Prefs.getBool('debugPaintBaselinesEnabled', false);
  set debugPaintBaselinesEnabled(bool? v) {
    //
    if (v != null) {
      //
      Prefs.setBool('debugPaintBaselinesEnabled', v);
      _debugPaintBaselinesEnabled = v;
      setSettingState();
    }
  }

  bool? _debugPaintBaselinesEnabled;

  ///
  bool get debugPaintLayerBordersEnabled => _debugPaintLayerBordersEnabled ??=
      Prefs.getBool('debugPaintLayerBordersEnabled', false);
  set debugPaintLayerBordersEnabled(bool? v) {
    //
    if (v != null) {
      //
      Prefs.setBool('debugPaintLayerBordersEnabled', v);
      _debugPaintLayerBordersEnabled = v;
      setSettingState();
    }
  }

  bool? _debugPaintLayerBordersEnabled;

  ///
  bool get debugPaintPointersEnabled => _debugPaintPointersEnabled ??=
      Prefs.getBool('debugPaintPointersEnabled', false);
  set debugPaintPointersEnabled(bool? v) {
    //
    if (v != null) {
      //
      Prefs.setBool('debugPaintPointersEnabled', v);
      _debugPaintPointersEnabled = v;
      setSettingState();
    }
  }

  bool? _debugPaintPointersEnabled;

  ///
  bool get debugRepaintRainbowEnabled => _debugRepaintRainbowEnabled ??=
      Prefs.getBool('debugRepaintRainbowEnabled', false);
  set debugRepaintRainbowEnabled(bool? v) {
    //
    if (v != null) {
      //
      Prefs.setBool('debugRepaintRainbowEnabled', v);
      _debugRepaintRainbowEnabled = v;
      setSettingState();
    }
  }

  bool? _debugRepaintRainbowEnabled;

  ///
  bool get debugRepaintTextRainbowEnabled => _debugRepaintTextRainbowEnabled ??=
      Prefs.getBool('debugRepaintTextRainbowEnabled', false);
  set debugRepaintTextRainbowEnabled(bool? v) {
    //
    if (v != null) {
      //
      Prefs.setBool('debugRepaintTextRainbowEnabled', v);
      _debugRepaintTextRainbowEnabled = v;
      setSettingState();
    }
  }

  bool? _debugRepaintTextRainbowEnabled;

  ///
  bool get showPerformanceOverlay => _showPerformanceOverlay ??=
      Prefs.getBool('showPerformanceOverlay', false);
  set showPerformanceOverlay(bool? v) {
    //
    if (v != null) {
      //
      Prefs.setBool('showPerformanceOverlay', v);
      _showPerformanceOverlay = v;
      setSettingState();
    }
  }

  bool? _showPerformanceOverlay;

  ///
  bool get showSemanticsDebugger =>
      _showSemanticsDebugger ??= Prefs.getBool('showSemanticsDebugger', false);
  set showSemanticsDebugger(bool? v) {
    //
    if (v != null) {
      //
      Prefs.setBool('showSemanticsDebugger', v);
      _showSemanticsDebugger = v;
      setSettingState();
    }
  }

  bool? _showSemanticsDebugger;

  ///
  bool get useMaterial3 =>
      _useMaterial3 ??= Prefs.getBool('useMaterial3', false);
  set useMaterial3(bool? v) {
    //
    if (v != null) {
      //
      Prefs.setBool('useMaterial3', v);
      _useMaterial3 = v;
      setSettingState();
    }
  }

  bool? _useMaterial3;

  /// Call the setState() functions
  void setSettingState() {
    // Update this StatefulWidget
    setState(() {});
    // Update the whole app
    rootState?.setState(() {});
  }
}

///
class DevToolsSettings extends StatefulWidget {
  ///
  DevToolsSettings({super.key}) : con = DevTools();
  final DevTools con;
  @override
  State createState() => _DevToolsSettingsState();

  List<Widget> get devSettings {
    final List<Widget> widgets = <Widget>[
      ListTile(
        leading: const Icon(Icons.bug_report),
        title: const Text('Show DEBUG banner'),
        onTap: () {
          con.debugShowCheckedModeBanner = !con.debugShowCheckedModeBanner;
        },
        trailing: Switch(
          value: con.debugShowCheckedModeBanner,
          onChanged: (bool value) {
            con.debugShowCheckedModeBanner = value;
          },
        ),
      ),
      if (!(con.state?.usingCupertino ?? false))
        ListTile(
          leading: const Icon(Icons.screen_lock_landscape_sharp),
          title: const Text('Use Material 3 Design'),
          onTap: () {
            con.useMaterial3 = !con.useMaterial3;
          },
          trailing: Switch(
            value: con.useMaterial3,
            onChanged: (bool value) {
              con.useMaterial3 = value;
            },
          ),
        ),
      ListTile(
        leading: const Icon(Icons.picture_in_picture),
        title: const Text('Show rendering performance overlay'),
        onTap: () {
          con.showPerformanceOverlay = !con.showPerformanceOverlay;
        },
        trailing: Switch(
          value: con.showPerformanceOverlay,
          onChanged: (bool value) {
            con.showPerformanceOverlay = value;
          },
        ),
      ),
      ListTile(
        leading: const Icon(Icons.accessibility),
        title: const Text('Show accessibility information'),
        onTap: () {
          con.showSemanticsDebugger = !con.showSemanticsDebugger;
        },
        trailing: Switch(
          value: con.showSemanticsDebugger,
          onChanged: (bool value) {
            con.showSemanticsDebugger = value;
          },
        ),
      ),
    ];
    // An approach to determine if running in your IDE or not is the assert()
    // i.e. When your in your Debugger or not.
    // The compiler removes assert functions and their content when in Production.
    assert(() {
      // material grid and size construction lines are only available in checked mode
      widgets.addAll(<Widget>[
        // Don't show the material grid if running in the Cupertino interface
        if (!(con.state?.usingCupertino ?? false))
          ListTile(
            leading: const Icon(Icons.border_clear),
            title: const Text('Show material grid'),
            onTap: () {
              con.debugShowMaterialGrid = !con.debugShowMaterialGrid;
            },
            trailing: Switch(
              value: con.debugShowMaterialGrid,
              onChanged: (bool value) {
                con.debugShowMaterialGrid = value;
              },
            ),
          ),
        ListTile(
          leading: const Icon(Icons.border_all),
          title: const Text('Paint construction lines'),
          onTap: () {
            con.debugPaintSizeEnabled = !con.debugPaintSizeEnabled;
          },
          trailing: Switch(
            value: con.debugPaintSizeEnabled,
            onChanged: (bool value) {
              con.debugPaintSizeEnabled = value;
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.format_color_text),
          title: const Text('Show character baselines'),
          onTap: () {
            con.debugPaintBaselinesEnabled = !con.debugPaintBaselinesEnabled;
          },
          trailing: Switch(
            value: con.debugPaintBaselinesEnabled,
            onChanged: (bool value) {
              con.debugPaintBaselinesEnabled = value;
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.filter_none),
          title: const Text('Highlight layer boundaries'),
          onTap: () {
            con.debugPaintLayerBordersEnabled =
                !con.debugPaintLayerBordersEnabled;
          },
          trailing: Switch(
            value: con.debugPaintLayerBordersEnabled,
            onChanged: (bool value) {
              con.debugPaintLayerBordersEnabled = value;
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.mouse),
          title: const Text('Flash interface taps'),
          onTap: () {
            con.debugPaintPointersEnabled = !con.debugPaintPointersEnabled;
          },
          trailing: Switch(
            value: con.debugPaintPointersEnabled,
            onChanged: (bool value) {
              con.debugPaintPointersEnabled = value;
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.gradient),
          title: const Text('Highlight repainted layers'),
          onTap: () {
            con.debugRepaintRainbowEnabled = !con.debugRepaintRainbowEnabled;
          },
          trailing: Switch(
            value: con.debugRepaintRainbowEnabled,
            onChanged: (bool value) {
              con.debugRepaintRainbowEnabled = value;
            },
          ),
        ),
      ]);
      return true;
    }());

    return widgets;
  }
}

///
class _DevToolsSettingsState extends StateX<DevToolsSettings> {
  @override
  void initState() {
    super.initState();
    // Add the DevTools controller class
    add(widget.con);
  }

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: widget.devSettings,
      );
}
