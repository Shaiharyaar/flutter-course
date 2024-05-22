import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadingStateProvider = ChangeNotifierProvider((ref) => LoadingState());

class LoadingState extends ChangeNotifier {
  bool isLoading = false;
  String text = "";

  void startLoader(String? textValue) {
    if (!isLoading) {
      isLoading = true;
      if (textValue != null) {
        text = textValue;
      }
      notifyListeners();
    }
  }

  void stopLoader() {
    if (isLoading) {
      isLoading = false;
      text = "";
      notifyListeners();
    }
  }
}
