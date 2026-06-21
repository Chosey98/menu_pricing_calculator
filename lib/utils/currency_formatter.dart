String formatCurrency(double value, String currencyLabel) {
  final rounded = (value * 100).roundToDouble() / 100;
  return '${rounded.toStringAsFixed(2)} $currencyLabel';
}

String formatPercent(double value) {
  final rounded = (value * 10000).roundToDouble() / 100;
  return '${rounded.toStringAsFixed(2)}%';
}

String formatPercentInput(double storedValue) {
  final display = storedValue * 100;
  if (display == display.roundToDouble()) {
    return display.toInt().toString();
  }
  return display.toStringAsFixed(2);
}

double? parsePercentInput(String text) {
  final trimmed = text.trim();
  if (trimmed.isEmpty) return null;
  final parsed = double.tryParse(trimmed);
  if (parsed == null) return null;
  return parsed / 100;
}

double? parseDoubleInput(String text) {
  final trimmed = text.trim();
  if (trimmed.isEmpty) return null;
  return double.tryParse(trimmed);
}
