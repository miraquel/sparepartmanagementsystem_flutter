import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'snackbar_message.g.dart';

@riverpod
class SnackbarMessage extends _$SnackbarMessage {
  @override
  String build() {
    return '';
  }

  void show(String message) {
    state = message;
  }
}