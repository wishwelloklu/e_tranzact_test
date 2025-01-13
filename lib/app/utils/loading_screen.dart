import 'dart:async';

import 'package:etranzazct_test/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'loading_screen_controller.dart';

class LoadingScreen {
  LoadingScreen._sharedInstance();
  static final LoadingScreen _instance = LoadingScreen._sharedInstance();
  factory LoadingScreen.instance() => _instance;

  LoadingScreenController? _controller;

  void show({
    required String text,
    required BuildContext context,
  }) {
    if (_controller?.updateLoadingScreen(text) ?? false) {
      return;
    } else {
      _controller = _showOverlay(
        context: context,
        text: text,
      );
    }
  }

  void hide() {
    _controller?.closeLoadingScreen();
    _controller = null;
  }

  LoadingScreenController _showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final text0 = StreamController<String>();
    text0.add(text);

    final state = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              constraints: BoxConstraints(
                maxHeight: size.height * .8,
                maxWidth: size.width * .8,
                minWidth: size.width * .5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  const CircularProgressIndicator(color: AppColors.blueColor),
                  const SizedBox(height: 10),
                  StreamBuilder<String>(
                    stream: text0.stream,
                    initialData: text,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data!);
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    state.insert(overlay);

    return LoadingScreenController(
      updateLoadingScreen: (text) {
        text0.add(text);
        return true;
      },
      closeLoadingScreen: () {
        text0.close();
        overlay.remove();
        return true;
      },
    );
  }
}
