import 'package:flutter/material.dart';

class Logger {
  static void print(
    String message, {
    String tag = '⚔️ Game Log',
    String level = 'INFO',
  }) {
    debugPrint('[$tag] [$level] $message');
  }
}
