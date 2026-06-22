import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'l10n/app_localizations.dart';
import 'models/add_on.dart';
import 'models/app_settings.dart';
import 'models/business_plan.dart';
import 'models/ingredient_line.dart';
import 'models/menu_item.dart';
import 'models/monthly_sales_line.dart';
import 'models/monthly_sales_record.dart';
import 'models/variable_cost_category.dart';
import 'models/shopping_list.dart';
import 'providers/business_plan_provider.dart';
import 'providers/menu_items_provider.dart';
import 'providers/monthly_sales_provider.dart';
import 'providers/settings_provider.dart';
import 'providers/shopping_list_provider.dart';
import 'screens/menu_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Hive.initFlutter();

    Hive.registerAdapter(IngredientLineAdapter());
    Hive.registerAdapter(AddOnAdapter());
    Hive.registerAdapter(MenuItemAdapter());
    Hive.registerAdapter(AppSettingsAdapter());
    Hive.registerAdapter(VariableCostCategoryAdapter());
    Hive.registerAdapter(BusinessPlanAdapter());
    Hive.registerAdapter(ShoppingListAdapter());
    Hive.registerAdapter(MonthlySalesLineAdapter());
    Hive.registerAdapter(MonthlySalesRecordAdapter());

    await Hive.openBox<AppSettings>(settingsBoxName);
    await Hive.openBox<MenuItem>(menuItemsBoxName);
    await Hive.openBox<BusinessPlan>(businessPlanBoxName);
    await Hive.openBox<ShoppingList>(shoppingListBoxName);
    await Hive.openBox<MonthlySalesRecord>(monthlySalesBoxName);

    final settingsBox = Hive.box<AppSettings>(settingsBoxName);
    if (!settingsBox.containsKey(settingsKey)) {
      await settingsBox.put(settingsKey, AppSettings.defaults);
    } else {
      try {
        final existing = settingsBox.get(settingsKey);
        if (existing != null) {
          var migrated = existing;
          if (existing.localeCode.isEmpty) {
            migrated = migrated.copyWith(localeCode: 'en');
          }
          final menuItemsBox = Hive.box<MenuItem>(menuItemsBoxName);
          if (menuItemsBox.isNotEmpty && !migrated.hasSeenSetupGuide) {
            migrated = migrated.copyWith(hasSeenSetupGuide: true);
          }
          if (migrated != existing) {
            await settingsBox.put(settingsKey, migrated);
          }
        }
      } catch (_) {
        await settingsBox.put(settingsKey, AppSettings.defaults);
      }
    }

    final businessPlanBox = Hive.box<BusinessPlan>(businessPlanBoxName);
    if (!businessPlanBox.containsKey(businessPlanKey)) {
      await businessPlanBox.put(businessPlanKey, defaultBusinessPlan());
    }
  } catch (error, stackTrace) {
    debugPrint('Startup failed: $error\n$stackTrace');
  }

  runApp(const ProviderScope(child: MenuPricingApp()));
}

class MenuPricingApp extends ConsumerWidget {
  const MenuPricingApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(appSettingsProvider);
    final seedColor = Colors.teal;
    final locale = Locale(settings.localeCode);

    return MaterialApp(
      title: AppLocalizations.of(settings.localeCode).appTitle,
      locale: locale,
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const MenuListScreen(),
    );
  }
}
