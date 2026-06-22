import 'package:hive/hive.dart';

part 'app_settings.g.dart';

@HiveType(typeId: 3)
class AppSettings {
  @HiveField(0)
  final double packingPct;

  @HiveField(1)
  final double electricPct;

  @HiveField(2)
  final double salaryPct;

  @HiveField(3)
  final double profitPct;

  @HiveField(4)
  final double rentPct;

  @HiveField(5)
  final double vatPct;

  @HiveField(6)
  final double alternateSalaryPct;

  @HiveField(7)
  final String currencyLabel;

  @HiveField(8, defaultValue: 'en')
  final String localeCode;

  @HiveField(9, defaultValue: false)
  final bool hasSeenSetupGuide;

  const AppSettings({
    this.packingPct = 0.05,
    this.electricPct = 0.05,
    this.salaryPct = 0.50,
    this.profitPct = 0.75,
    this.rentPct = 0.15,
    this.vatPct = 0.14,
    this.alternateSalaryPct = 0.20,
    this.currencyLabel = 'LE',
    this.localeCode = 'en',
    this.hasSeenSetupGuide = false,
  });

  static const defaults = AppSettings();

  AppSettings copyWith({
    double? packingPct,
    double? electricPct,
    double? salaryPct,
    double? profitPct,
    double? rentPct,
    double? vatPct,
    double? alternateSalaryPct,
    String? currencyLabel,
    String? localeCode,
    bool? hasSeenSetupGuide,
  }) {
    return AppSettings(
      packingPct: packingPct ?? this.packingPct,
      electricPct: electricPct ?? this.electricPct,
      salaryPct: salaryPct ?? this.salaryPct,
      profitPct: profitPct ?? this.profitPct,
      rentPct: rentPct ?? this.rentPct,
      vatPct: vatPct ?? this.vatPct,
      alternateSalaryPct: alternateSalaryPct ?? this.alternateSalaryPct,
      currencyLabel: currencyLabel ?? this.currencyLabel,
      localeCode: localeCode ?? this.localeCode,
      hasSeenSetupGuide: hasSeenSetupGuide ?? this.hasSeenSetupGuide,
    );
  }
}
