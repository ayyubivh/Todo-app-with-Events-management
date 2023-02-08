import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final imagaProvider = StateProvider.autoDispose(((ref) => ''));
final dateProvider = StateProvider<DateTime>(((ref) => DateTime.now()));
final timeProvider = StateProvider<DateTime>((ref) => DateTime.now());
final titleControllers =
    StateProvider.autoDispose<TextEditingController>((ref) {
  return TextEditingController();
});
