/// Copyright 2019 Andrious Solutions Ltd. All rights reserved.
/// Use of this source code is governed by a 2-clause BSD License.
/// The main directory contains that LICENSE file.
import 'package:flutter/cupertino.dart';

import 'package:flutter/gestures.dart' show PointerDeviceKind;

// Medium article one day.
/// A Spinner listing the available items.
class GenericSpinner extends StatelessWidget {
  /// Supply the supported Locales and Item Changed Routine.
  const GenericSpinner({
    super.key,
    this.initialItem,
    required this.items,
    required this.itemBuilder,
    required this.onSelectedItemChanged,
    this.diameterRatio,
    this.backgroundColor,
    this.offAxisFraction,
    this.useMagnifier,
    this.magnification,
    this.itemExtent,
    this.squeeze,
    this.selectionOverlay,
  });

  /// The currently 'selected' Locale item on the Spinner.
  final int? initialItem;

  /// The List of supported Locales.
  final List<String> items;

  /// Supply how the items are to be listed.
  final Widget Function(BuildContext context, int index) itemBuilder;

  /// The routine called when a new Locale is selected.
  final void Function(int index) onSelectedItemChanged;

  /// Must not be null and defaults to `1.1` to visually mimic iOS.
  final double? diameterRatio;

  /// Any alpha value less 255 (fully opaque) will cause the removal of the
  /// wheel list edge fade gradient from rendering of the widget.
  final Color? backgroundColor;

  /// This property creates the visual effect of looking at a vertical wheel from
  /// its side where its vanishing points at the edge curves to one side instead
  /// of looking at the wheel head-on.
  final double? offAxisFraction;

  /// Whether to use the magnifier for the center item of the wheel.
  final bool? useMagnifier;

  /// The zoomed-in rate of the magnifier, if it is used.
  final double? magnification;

  /// All children will be given the [BoxConstraints] to match this exact
  /// height. Must be a positive value.
  final double? itemExtent;

  /// This denotes a ratio of the number of children on the wheel vs the number
  /// of children that would fit on a flat list of equivalent size, assuming
  /// [diameterRatio] of 1.
  final double? squeeze;

  /// If unspecified, it defaults to a [CupertinoPickerDefaultSelectionOverlay]
  /// which is a gray rounded rectangle overlay in iOS 14 style.
  /// This property can be set to null to remove the overlay.
  final Widget? selectionOverlay;

  @override
  Widget build(BuildContext context) {
    int? index;

    if (initialItem != null && initialItem! > -1) {
      index = initialItem!;
    }

    if (index == null || index < 0) {
      index = 0;
    }

    /// A [FixedExtentScrollController] to read and control the current item, and
    /// to set the initial item.
    FixedExtentScrollController? scrollController =
        FixedExtentScrollController(initialItem: index);

    Widget picker = CupertinoPicker.builder(
      diameterRatio: diameterRatio ?? 1.07,
      backgroundColor: backgroundColor,
      offAxisFraction: offAxisFraction ?? 0.0,
      useMagnifier: useMagnifier ?? false,
      magnification: magnification ?? 1.0,
      squeeze: squeeze ?? 1.45,
      scrollController: scrollController,
      selectionOverlay:
          selectionOverlay ?? const CupertinoPickerDefaultSelectionOverlay(),
      itemExtent: itemExtent ?? 25, //height of each item
      childCount: items.length,
      onSelectedItemChanged: onSelectedItemChanged,
      itemBuilder: (BuildContext context, int index) =>
          itemBuilder(context, index),
    );

    //
    picker = ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      child: picker,
    );

    return SizedBox(
      height: 100,
      child: picker,
    );
  }
}
