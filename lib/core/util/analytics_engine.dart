import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:who_boogles_it/core/util/logger.dart';

class AnalyticsEngine {
  static final bool _isAvailable =
      !kIsWeb && (Platform.isAndroid || Platform.isIOS); // Windows is not supported
  static final FirebaseAnalytics _engine = FirebaseAnalytics.instance;
  static const String _tag = '📈 Analytics';

  static Future<void> logAppOpen() async {
    if (_isAvailable) _engine.logAppOpen();
    Logger.print('logAppOpen', tag: _tag);
  }

  static Future<void> logLevelStart({required String levelName}) async {
    if (_isAvailable) _engine.logLevelStart(levelName: levelName);
    Logger.print('logLevelStart(levelName: $levelName)', tag: _tag);
  }

  static Future<void> logLevelEnd({required String levelName, int? success}) async {
    if (_isAvailable) _engine.logLevelEnd(levelName: levelName, success: success);
    Logger.print('logLevelEnd(levelName: $levelName, success: $success)', tag: _tag);
  }

  static Future<void> logLevelUp({required int level}) async {
    if (_isAvailable) _engine.logLevelUp(level: level);
    Logger.print('logLevelUp(level: $level)', tag: _tag);
  }

  static Future<void> logEvent({required String name, Map<String, Object?>? parameters}) async {
    if (_isAvailable) _engine.logEvent(name: name, parameters: parameters);
    Logger.print('logEvent(name: $name, parameters: $parameters)', tag: _tag);
  }
}
