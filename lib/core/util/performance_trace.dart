import 'package:firebase_performance/firebase_performance.dart';
import 'package:who_boogles_it/core/di/locator.dart';

class PerformanceTrace {
  Trace? trace;

  PerformanceTrace({required String traceName}) {
    if (isMobile) {
      trace = FirebasePerformance.instance.newTrace(traceName);
      trace!.start();
    }
  }

  Future<void> stop({Map<String, String>? attributes}) async {
    attributes?.forEach((key, value) {
      trace?.putAttribute(key, value);
    });
    trace?.stop();
  }
}
