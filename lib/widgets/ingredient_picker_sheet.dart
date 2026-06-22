import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../l10n/app_localizations.dart';
import '../models/ingredient_line.dart';
import '../providers/ingredient_catalog_provider.dart';
import '../providers/localization_provider.dart';
import '../providers/settings_provider.dart';
import '../utils/currency_formatter.dart';
import '../utils/ingredient_catalog.dart';

const _uuid = Uuid();

Future<IngredientLine?> pickIngredientForRecipe(
  WidgetRef ref,
  BuildContext context,
) async {
  final catalog = ref.read(ingredientCatalogProvider);
  final settings = ref.read(appSettingsProvider);
  final l10n = ref.read(appLocalizationsProvider);

  final picked = await showIngredientPicker(
    context,
    catalog: catalog,
    l10n: l10n,
    currencyLabel: settings.currencyLabel,
  );

  if (picked == null) return null;

  return IngredientLine(
    id: _uuid.v4(),
    name: picked.name,
    unit: picked.unit,
    unitPrice: picked.unitPrice,
    quantityUsed: 0,
  );
}

Future<CatalogIngredient?> showIngredientPicker(
  BuildContext context, {
  required List<CatalogIngredient> catalog,
  required AppLocalizations l10n,
  required String currencyLabel,
}) {
  return showModalBottomSheet<CatalogIngredient>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        minChildSize: 0.35,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          if (catalog.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    l10n.noIngredientsInCatalog,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(l10n.cancel),
                  ),
                ],
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Text(
                  l10n.chooseIngredient,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  l10n.chooseIngredientHint,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: catalog.length,
                  itemBuilder: (context, index) {
                    final entry = catalog[index];
                    final sourceLabel = entry.source ==
                            IngredientCatalogSource.purchase
                        ? l10n.fromPurchases
                        : l10n.fromRecipes;
                    return ListTile(
                      title: Text(entry.name),
                      subtitle: Text(
                        '${entry.unit} · ${formatCurrency(entry.unitPrice, currencyLabel)} · $sourceLabel',
                      ),
                      onTap: () => Navigator.pop(context, entry),
                    );
                  },
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
