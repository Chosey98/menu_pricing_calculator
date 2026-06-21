import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/app_localizations.dart';
import '../models/ingredient_line.dart';
import '../utils/currency_formatter.dart';

class IngredientRow extends StatelessWidget {
  const IngredientRow({
    super.key,
    required this.ingredient,
    required this.currencyLabel,
    required this.l10n,
    required this.onChanged,
    required this.onDelete,
  });

  final IngredientLine ingredient;
  final String currencyLabel;
  final AppLocalizations l10n;
  final ValueChanged<IngredientLine> onChanged;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: ingredient.name,
                    decoration: InputDecoration(
                      labelText: l10n.ingredient,
                      isDense: true,
                    ),
                    onChanged: (value) =>
                        onChanged(ingredient.copyWith(name: value)),
                  ),
                ),
                IconButton(
                  tooltip: l10n.removeIngredient,
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: ingredient.unit,
                    decoration: InputDecoration(
                      labelText: l10n.unit,
                      isDense: true,
                    ),
                    onChanged: (value) =>
                        onChanged(ingredient.copyWith(unit: value)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    initialValue: ingredient.unitPrice == 0
                        ? ''
                        : ingredient.unitPrice.toString(),
                    decoration: InputDecoration(
                      labelText: l10n.unitPrice(currencyLabel),
                      isDense: true,
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                    onChanged: (value) => onChanged(
                      ingredient.copyWith(
                        unitPrice: parseDoubleInput(value) ?? 0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    initialValue: ingredient.quantityUsed == 0
                        ? ''
                        : ingredient.quantityUsed.toString(),
                    decoration: InputDecoration(
                      labelText: l10n.qtyUsed,
                      isDense: true,
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                    onChanged: (value) => onChanged(
                      ingredient.copyWith(
                        quantityUsed: parseDoubleInput(value) ?? 0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                l10n.lineTotal(
                  formatCurrency(ingredient.lineTotal, currencyLabel),
                ),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
