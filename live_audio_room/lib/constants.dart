// Dart imports:
import 'dart:math';

// Project imports:

/// Note that the userID needs to be globally unique,
final String localUserID = Random().nextInt(100000).toString();

enum LayoutMode {
  defaultLayout,
  full,
  hostTopCenter,
  hostCenter,
  fourPeoples,
}

extension LayoutModeExtension on LayoutMode {
  String get text {
    final mapValues = {
      LayoutMode.defaultLayout: 'default',
      LayoutMode.full: 'full',
      LayoutMode.hostTopCenter: 'host top center',
      LayoutMode.hostCenter: 'host center',
      LayoutMode.fourPeoples: 'four peoples',
    };

    return mapValues[this]!;
  }
}
