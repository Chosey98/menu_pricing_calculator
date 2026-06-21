import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/localization_provider.dart';
import '../providers/menu_items_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/shopping_list_provider.dart';
import '../widgets/ingredient_row.dart';
import '../widgets/raw_material_budget_card.dart';

class IngredientsPurchaseScreen extends ConsumerWidget {
  const IngredientsPurchaseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shoppingList = ref.watch(shoppingListProvider);
    final settings = ref.watch(appSettingsProvider);
    final l10n = ref.watch(appLocalizationsProvider);
    final comparison = ref.watch(rawMaterialBudgetComparisonProvider);
    final notifier = ref.read(shoppingListProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.ingredientsPurchase),
        actions: [
          if (shoppingList.items.isNotEmpty)
            IconButton(
              tooltip: l10n.clearPurchases,
              onPressed: () async {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(l10n.clearPurchases),
                    content: Text(l10n.clearPurchasesConfirm),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text(l10n.cancel),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: Text(l10n.delete),
                      ),
                    ],
                  ),
                );
                if (confirmed == true) {
                  await notifier.clearAll();
                }
              },
              icon: const Icon(Icons.delete_sweep_outlined),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          RawMaterialBudgetCard(
            comparison: comparison,
            currencyLabel: settings.currencyLabel,
            l10n: l10n,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final items = ref.read(menuItemsProvider);
                    await notifier.replaceFromMenuItems(items);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.loadedFromMenu)),
                      );
                    }
                  },
                  icon: const Icon(Icons.restaurant_menu),
                  label: Text(l10n.loadFromMenu),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: notifier.addItem,
                  icon: const Icon(Icons.add),
                  label: Text(l10n.addPurchase),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            l10n.ingredientsPurchaseHint,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          if (shoppingList.items.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                l10n.ingredientsPurchaseEmpty,
                textAlign: TextAlign.center,
              ),
            ),
          for (final item in shoppingList.items)
            IngredientRow(
              ingredient: item,
              currencyLabel: settings.currencyLabel,
              l10n: l10n,
              onChanged: notifier.updateItem,
              onDelete: () => notifier.deleteItem(item.id),
            ),
        ],
      ),
    );
  }
}
