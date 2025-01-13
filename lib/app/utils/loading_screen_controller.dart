import 'package:flutter/foundation.dart' show immutable;

typedef UpdateLoadingScreen = bool Function(String text);
typedef CloseLoadingScreen = bool Function();

@immutable
class LoadingScreenController {
  final UpdateLoadingScreen updateLoadingScreen;
  final CloseLoadingScreen closeLoadingScreen;

  const LoadingScreenController({
    required this.updateLoadingScreen,
    required this.closeLoadingScreen,
  });
}
