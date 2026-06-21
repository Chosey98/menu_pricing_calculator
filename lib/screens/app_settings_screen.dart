import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_settings.dart';
import '../providers/localization_provider.dart';
import '../providers/settings_provider.dart';
import '../utils/currency_formatter.dart';
import 'setup_guide_screen.dart';

class AppSettingsScreen extends ConsumerStatefulWidget {
  const AppSettingsScreen({super.key});

  @override
  ConsumerState<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends ConsumerState<AppSettingsScreen> {
  late final TextEditingController _packingController;
  late final TextEditingController _electricController;
  late final TextEditingController _salaryController;
  late final TextEditingController _profitController;
  late final TextEditingController _rentController;
  late final TextEditingController _vatController;
  late final TextEditingController _alternateSalaryController;
  late final TextEditingController _currencyController;

  @override
  void initState() {
    super.initState();
    final settings = ref.read(appSettingsProvider);
    _packingController =
        TextEditingController(text: formatPercentInput(settings.packingPct));
    _electricController =
        TextEditingController(text: formatPercentInput(settings.electricPct));
    _salaryController =
        TextEditingController(text: formatPercentInput(settings.salaryPct));
    _profitController =
        TextEditingController(text: formatPercentInput(settings.profitPct));
    _rentController =
        TextEditingController(text: formatPercentInput(settings.rentPct));
    _vatController =
        TextEditingController(text: formatPercentInput(settings.vatPct));
    _alternateSalaryController = TextEditingController(
      text: formatPercentInput(settings.alternateSalaryPct),
    );
    _currencyController =
        TextEditingController(text: settings.currencyLabel);
  }

  @override
  void dispose() {
    _packingController.dispose();
    _electricController.dispose();
    _salaryController.dispose();
    _profitController.dispose();
    _rentController.dispose();
    _vatController.dispose();
    _alternateSalaryController.dispose();
    _currencyController.dispose();
    super.dispose();
  }

  Future<void> _save(AppSettings Function(AppSettings) updater) async {
    await ref.read(appSettingsProvider.notifier).updateField(updater);
  }

  Widget _percentField({
    required String label,
    required String helper,
    required TextEditingController controller,
    required void Function(double value) onSaved,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          helperText: helper,
          helperMaxLines: 3,
          suffixText: '%',
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: (value) {
          final parsed = parsePercentInput(value);
          if (parsed != null) onSaved(parsed);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(appSettingsProvider);
    final l10n = ref.watch(appLocalizationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appSettings),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          FilledButton.tonalIcon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SetupGuideScreen(),
                ),
              );
            },
            icon: const Icon(Icons.menu_book_outlined),
            label: Text(l10n.openSetupGuide),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.settingsIntro,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Text(l10n.language, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            segments: [
              ButtonSegment(value: 'en', label: Text(l10n.languageEnglish)),
              ButtonSegment(value: 'ar', label: Text(l10n.languageArabic)),
            ],
            selected: {settings.localeCode},
            onSelectionChanged: (selection) {
              _save((s) => s.copyWith(localeCode: selection.first));
            },
          ),
          const SizedBox(height: 24),
          _percentField(
            label: l10n.packing,
            helper: l10n.packingHelper,
            controller: _packingController,
            onSaved: (value) => _save((s) => s.copyWith(packingPct: value)),
          ),
          _percentField(
            label: l10n.electric,
            helper: l10n.electricHelper,
            controller: _electricController,
            onSaved: (value) => _save((s) => s.copyWith(electricPct: value)),
          ),
          _percentField(
            label: l10n.salary,
            helper: l10n.salaryHelper,
            controller: _salaryController,
            onSaved: (value) => _save((s) => s.copyWith(salaryPct: value)),
          ),
          _percentField(
            label: l10n.profit,
            helper: l10n.profitHelper,
            controller: _profitController,
            onSaved: (value) => _save((s) => s.copyWith(profitPct: value)),
          ),
          _percentField(
            label: l10n.rent,
            helper: l10n.rentHelper,
            controller: _rentController,
            onSaved: (value) => _save((s) => s.copyWith(rentPct: value)),
          ),
          _percentField(
            label: l10n.vat,
            helper: l10n.vatHelper,
            controller: _vatController,
            onSaved: (value) => _save((s) => s.copyWith(vatPct: value)),
          ),
          _percentField(
            label: l10n.alternateSalary,
            helper: l10n.alternateSalaryHelper,
            controller: _alternateSalaryController,
            onSaved: (value) =>
                _save((s) => s.copyWith(alternateSalaryPct: value)),
          ),
          TextFormField(
            controller: _currencyController,
            decoration: InputDecoration(
              labelText: l10n.currencyLabel,
              helperText: l10n.currencyLabelHelper,
            ),
            onChanged: (value) =>
                _save((s) => s.copyWith(currencyLabel: value.trim())),
          ),
        ],
      ),
    );
  }
}
