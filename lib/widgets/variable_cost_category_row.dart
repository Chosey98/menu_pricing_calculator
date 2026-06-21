import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/app_localizations.dart';
import '../models/variable_cost_category.dart';
import '../utils/currency_formatter.dart';

class VariableCostCategoryRow extends StatelessWidget {
  const VariableCostCategoryRow({
    super.key,
    required this.category,
    required this.currencyLabel,
    required this.l10n,
    required this.onChanged,
    required this.onDelete,
  });

  final VariableCostCategory category;
  final String currencyLabel;
  final AppLocalizations l10n;
  final ValueChanged<VariableCostCategory> onChanged;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: TextFormField(
                initialValue: category.name,
                decoration: InputDecoration(
                  labelText: l10n.category,
                  isDense: true,
                ),
                onChanged: (value) =>
                    onChanged(category.copyWith(name: value)),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                initialValue:
                    category.amount == 0 ? '' : category.amount.toString(),
                decoration: InputDecoration(
                  labelText: l10n.costLabel(currencyLabel),
                  helperText: l10n.fixedAmountNotPercent,
                  isDense: true,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                ],
                onChanged: (value) => onChanged(
                  category.copyWith(
                    amount: parseDoubleInput(value) ?? 0,
                  ),
                ),
              ),
            ),
            IconButton(
              tooltip: l10n.removeCategory,
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
      ),
    );
  }
}
