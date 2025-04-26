import 'dart:developer';

class RxBenchmark {
  static bool enabled = false;
  static final Map<String, int> updateCount = {};
  static final Map<String, int> rebuildCount = {};

  static void trackUpdate(String label, Duration duration) {
    if (!enabled) return;

    updateCount[label] = (updateCount[label] ?? 0) + 1;

    final seconds = duration.inMicroseconds / 1_000_000;
    log("📦 [$label] updated in ${seconds.toStringAsFixed(6)} s");
  }

  static void trackRebuild(String label) {
    if (!enabled) return;
    rebuildCount[label] = (rebuildCount[label] ?? 0) + 1;
  }

  static void summary() {
    log("\n📊 RxBenchmark Summary:");
    if (updateCount.isNotEmpty) {
      log("🔹 Updates:");
      updateCount.forEach((k, v) => log(" - $k: $v times"));
    }
    if (rebuildCount.isNotEmpty) {
      log("🔹 Rebuilds:");
      rebuildCount.forEach((k, v) => log(" - $k: $v times"));
    }
  }

  static void clear() {
    updateCount.clear();
    rebuildCount.clear();
  }
}
