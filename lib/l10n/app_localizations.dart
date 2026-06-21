import 'package:flutter/material.dart';

class AppLocalizations {
  const AppLocalizations._(this._t);

  final _Strings _t;

  static AppLocalizations of(String localeCode) {
    return AppLocalizations._(
      localeCode == 'ar' ? _Strings.ar : _Strings.en,
    );
  }

  static AppLocalizations fromContext(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  String get appTitle => _t.appTitle;
  String get menuPricing => _t.menuPricing;
  String get businessPlan => _t.businessPlan;
  String get ingredientsPurchase => _t.ingredientsPurchase;
  String get settings => _t.settings;
  String get appSettings => _t.appSettings;
  String get cancel => _t.cancel;
  String get delete => _t.delete;
  String get duplicate => _t.duplicate;
  String get deleteMenuItemTitle => _t.deleteMenuItemTitle;
  String deleteMenuItemBody(String name) =>
      _t.deleteMenuItemBody.replaceAll('{name}', name);
  String get noMenuItemsYet => _t.noMenuItemsYet;
  String get emptyMenuHint => _t.emptyMenuHint;
  String get openSettings => _t.openSettings;
  String get newMenuItem => _t.newMenuItem;
  String get overThirdsRaw => _t.overThirdsRaw;
  String addOnCount(int count) =>
      count == 1 ? _t.addOnOne : _t.addOnMany.replaceAll('{n}', '$count');
  String dCost(String amount) => _t.dCost.replaceAll('{amount}', amount);
  String get businessPlanBannerTitle => _t.businessPlanBannerTitle;
  String menuRawTotal(String raw, String budget) =>
      _t.menuRawTotal.replaceAll('{raw}', raw).replaceAll('{budget}', budget);
  String overBudgetBy(String amount) =>
      _t.overBudgetBy.replaceAll('{amount}', amount);
  String get itemNotFound => _t.itemNotFound;
  String get itemNoLongerExists => _t.itemNoLongerExists;
  String get menuItem => _t.menuItem;
  String get itemName => _t.itemName;
  String get ingredients => _t.ingredients;
  String get addIngredient => _t.addIngredient;
  String get actualSalesPrice => _t.actualSalesPrice;
  String get actualSalesPriceHelper => _t.actualSalesPriceHelper;
  String get compareSalaryScenarios => _t.compareSalaryScenarios;
  String get compareSalaryScenariosHelper => _t.compareSalaryScenariosHelper;
  String get addOns => _t.addOns;
  String get addAddOn => _t.addAddOn;
  String get addOnsEmptyHint => _t.addOnsEmptyHint;
  String get notesOptional => _t.notesOptional;
  String get settingsIntro => _t.settingsIntro;
  String get packing => _t.packing;
  String get packingHelper => _t.packingHelper;
  String get electric => _t.electric;
  String get electricHelper => _t.electricHelper;
  String get salary => _t.salary;
  String get salaryHelper => _t.salaryHelper;
  String get profit => _t.profit;
  String get profitHelper => _t.profitHelper;
  String get rent => _t.rent;
  String get rentHelper => _t.rentHelper;
  String get vat => _t.vat;
  String get vatHelper => _t.vatHelper;
  String get alternateSalary => _t.alternateSalary;
  String get alternateSalaryHelper => _t.alternateSalaryHelper;
  String get currencyLabel => _t.currencyLabel;
  String get currencyLabelHelper => _t.currencyLabelHelper;
  String get language => _t.language;
  String get languageEnglish => _t.languageEnglish;
  String get languageArabic => _t.languageArabic;
  String get variableCosts => _t.variableCosts;
  String get addCategory => _t.addCategory;
  String get variableCostsEmptyHint => _t.variableCostsEmptyHint;
  String variableCostsIntro(String currency) =>
      _t.variableCostsIntro.replaceAll('{currency}', currency);
  String get variableCostsIntroSecondary => _t.variableCostsIntroSecondary;
  String get ruleOfThirdsTargets => _t.ruleOfThirdsTargets;
  String targetsIntro(String currency) =>
      _t.targetsIntro.replaceAll('{currency}', currency);
  String get totalVariableCostsEntered => _t.totalVariableCostsEntered;
  String get totalRevenueTarget => _t.totalRevenueTarget;
  String get revenuePerThird => _t.revenuePerThird;
  String get eachThirdEqual => _t.eachThirdEqual;
  String get rawMaterialBudget => _t.rawMaterialBudget;
  String get rawMaterialPurchases => _t.rawMaterialPurchases;
  String get purchasesTotal => _t.purchasesTotal;
  String remainingBudget(String amount) =>
      _t.remainingBudget.replaceAll('{amount}', amount);
  String get setVariableCostsForBudget => _t.setVariableCostsForBudget;
  String get loadFromMenu => _t.loadFromMenu;
  String get loadedFromMenu => _t.loadedFromMenu;
  String get addPurchase => _t.addPurchase;
  String get ingredientsPurchaseHint => _t.ingredientsPurchaseHint;
  String get ingredientsPurchaseEmpty => _t.ingredientsPurchaseEmpty;
  String get clearPurchases => _t.clearPurchases;
  String get clearPurchasesConfirm => _t.clearPurchasesConfirm;
  String get profitTarget => _t.profitTarget;
  String get category => _t.category;
  String costLabel(String currency) => _t.costLabel.replaceAll('{currency}', currency);
  String get fixedAmountNotPercent => _t.fixedAmountNotPercent;
  String get removeCategory => _t.removeCategory;
  String get ruleOfThirdsRecipe => _t.ruleOfThirdsRecipe;
  String get ruleOfThirdsRecipeHint => _t.ruleOfThirdsRecipeHint;
  String get sellingPriceUsed => _t.sellingPriceUsed;
  String get targetRawCost => _t.targetRawCost;
  String get actualRawCost => _t.actualRawCost;
  String get gap => _t.gap;
  String get variableShareAtPrice => _t.variableShareAtPrice;
  String get profitShareAtPrice => _t.profitShareAtPrice;
  String get businessRawMaterialBudget => _t.businessRawMaterialBudget;
  String get totalDirectCost => _t.totalDirectCost;
  String packingPct(String pct) => _t.packingPct.replaceAll('{pct}', pct);
  String electricPct(String pct) => _t.electricPct.replaceAll('{pct}', pct);
  String salaryPct(String pct) => _t.salaryPct.replaceAll('{pct}', pct);
  String profitPct(String pct) => _t.profitPct.replaceAll('{pct}', pct);
  String rentPct(String pct) => _t.rentPct.replaceAll('{pct}', pct);
  String get rentSubtitle => _t.rentSubtitle;
  String get totalCostAndProfit => _t.totalCostAndProfit;
  String vatPct(String pct) => _t.vatPct.replaceAll('{pct}', pct);
  String get finalPrice => _t.finalPrice;
  String get actualSalesPriceLabel => _t.actualSalesPriceLabel;
  String get costPercent => _t.costPercent;
  String get varianceVsFinalPrice => _t.varianceVsFinalPrice;
  String get ingredient => _t.ingredient;
  String get unit => _t.unit;
  String unitPrice(String currency) =>
      _t.unitPrice.replaceAll('{currency}', currency);
  String get qtyUsed => _t.qtyUsed;
  String lineTotal(String amount) => _t.lineTotal.replaceAll('{amount}', amount);
  String get removeIngredient => _t.removeIngredient;
  String get salaryScenarioComparison => _t.salaryScenarioComparison;
  String scenarioA(String pct) => _t.scenarioA.replaceAll('{pct}', pct);
  String scenarioB(String pct) => _t.scenarioB.replaceAll('{pct}', pct);
  String difference(String amount) => _t.difference.replaceAll('{amount}', amount);
  String get addOnName => _t.addOnName;
  String get removeAddOn => _t.removeAddOn;
  String get expand => _t.expand;
  String get collapse => _t.collapse;
  String get newMenuItemDefault => _t.newMenuItemDefault;
  String get newAddOnDefault => _t.newAddOnDefault;
  String copySuffix(String name) => _t.copySuffix.replaceAll('{name}', name);
  String thirdsGuidanceNoPriceWithRaw(String price) =>
      _t.thirdsGuidanceNoPriceWithRaw.replaceAll('{price}', price);
  String get thirdsGuidanceNoData => _t.thirdsGuidanceNoData;
  String get thirdsGuidanceOnTarget => _t.thirdsGuidanceOnTarget;
  String thirdsGuidanceOver(String gap, String priceHint) =>
      _t.thirdsGuidanceOver
          .replaceAll('{gap}', gap)
          .replaceAll('{hint}', priceHint);
  String thirdsGuidanceOverReduce(String gap) =>
      _t.thirdsGuidanceOverReduce.replaceAll('{gap}', gap);
  String thirdsGuidanceUnder(String gap) =>
      _t.thirdsGuidanceUnder.replaceAll('{gap}', gap);
  String thirdsMinPrice(String price) =>
      _t.thirdsMinPrice.replaceAll('{price}', price);
  String get thirdsRaiseOrReduce => _t.thirdsRaiseOrReduce;
  String get thirdsReduceOnly => _t.thirdsReduceOnly;
  String get salesTargets => _t.salesTargets;
  String get monthlySales => _t.monthlySales;
  String get recipeMonthlyTargets => _t.recipeMonthlyTargets;
  String get recipeMonthlyTargetsHint => _t.recipeMonthlyTargetsHint;
  String get expectedMonthlyUnits => _t.expectedMonthlyUnits;
  String get expectedMonthlyUnitsHelper => _t.expectedMonthlyUnitsHelper;
  String get recommendedMonthlyUnits => _t.recommendedMonthlyUnits;
  String get targetMonthlyUnits => _t.targetMonthlyUnits;
  String get targetMonthlyRevenue => _t.targetMonthlyRevenue;
  String get targetMonthlyRawCost => _t.targetMonthlyRawCost;
  String get targetMonthlyProfit => _t.targetMonthlyProfit;
  String get qtySold => _t.qtySold;
  String get actualMonthlyRevenue => _t.actualMonthlyRevenue;
  String get vsTarget => _t.vsTarget;
  String aboveTargetBy(String amount) =>
      _t.aboveTargetBy.replaceAll('{amount}', amount);
  String belowTargetBy(String amount) =>
      _t.belowTargetBy.replaceAll('{amount}', amount);
  String get onTargetStatus => _t.onTargetStatus;
  String get businessPlanComparison => _t.businessPlanComparison;
  String get menuTargetsTotal => _t.menuTargetsTotal;
  String get addRecipeForTargets => _t.addRecipeForTargets;
  String get previousMonth => _t.previousMonth;
  String get nextMonth => _t.nextMonth;
  String get noMenuItemsForSales => _t.noMenuItemsForSales;
  String get varianceUnits => _t.varianceUnits;
  String get salesComparisonTitle => _t.salesComparisonTitle;
  String get setBusinessPlanForRecommendations =>
      _t.setBusinessPlanForRecommendations;
  String get monthlySalesHint => _t.monthlySalesHint;
  String get setupGuide => _t.setupGuide;
  String get openSetupGuide => _t.openSetupGuide;
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      locale.languageCode == 'en' || locale.languageCode == 'ar';

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations.of(locale.languageCode);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}

class _Strings {
  const _Strings({
    required this.appTitle,
    required this.menuPricing,
    required this.businessPlan,
    required this.ingredientsPurchase,
    required this.settings,
    required this.appSettings,
    required this.cancel,
    required this.delete,
    required this.duplicate,
    required this.deleteMenuItemTitle,
    required this.deleteMenuItemBody,
    required this.noMenuItemsYet,
    required this.emptyMenuHint,
    required this.openSettings,
    required this.newMenuItem,
    required this.overThirdsRaw,
    required this.addOnOne,
    required this.addOnMany,
    required this.dCost,
    required this.businessPlanBannerTitle,
    required this.menuRawTotal,
    required this.overBudgetBy,
    required this.itemNotFound,
    required this.itemNoLongerExists,
    required this.menuItem,
    required this.itemName,
    required this.ingredients,
    required this.addIngredient,
    required this.actualSalesPrice,
    required this.actualSalesPriceHelper,
    required this.compareSalaryScenarios,
    required this.compareSalaryScenariosHelper,
    required this.addOns,
    required this.addAddOn,
    required this.addOnsEmptyHint,
    required this.notesOptional,
    required this.settingsIntro,
    required this.packing,
    required this.packingHelper,
    required this.electric,
    required this.electricHelper,
    required this.salary,
    required this.salaryHelper,
    required this.profit,
    required this.profitHelper,
    required this.rent,
    required this.rentHelper,
    required this.vat,
    required this.vatHelper,
    required this.alternateSalary,
    required this.alternateSalaryHelper,
    required this.currencyLabel,
    required this.currencyLabelHelper,
    required this.language,
    required this.languageEnglish,
    required this.languageArabic,
    required this.variableCosts,
    required this.addCategory,
    required this.variableCostsEmptyHint,
    required this.variableCostsIntro,
    required this.variableCostsIntroSecondary,
    required this.ruleOfThirdsTargets,
    required this.targetsIntro,
    required this.totalVariableCostsEntered,
    required this.totalRevenueTarget,
    required this.revenuePerThird,
    required this.eachThirdEqual,
    required this.rawMaterialBudget,
    required this.rawMaterialPurchases,
    required this.purchasesTotal,
    required this.remainingBudget,
    required this.setVariableCostsForBudget,
    required this.loadFromMenu,
    required this.loadedFromMenu,
    required this.addPurchase,
    required this.ingredientsPurchaseHint,
    required this.ingredientsPurchaseEmpty,
    required this.clearPurchases,
    required this.clearPurchasesConfirm,
    required this.profitTarget,
    required this.category,
    required this.costLabel,
    required this.fixedAmountNotPercent,
    required this.removeCategory,
    required this.ruleOfThirdsRecipe,
    required this.ruleOfThirdsRecipeHint,
    required this.sellingPriceUsed,
    required this.targetRawCost,
    required this.actualRawCost,
    required this.gap,
    required this.variableShareAtPrice,
    required this.profitShareAtPrice,
    required this.businessRawMaterialBudget,
    required this.totalDirectCost,
    required this.packingPct,
    required this.electricPct,
    required this.salaryPct,
    required this.profitPct,
    required this.rentPct,
    required this.rentSubtitle,
    required this.totalCostAndProfit,
    required this.vatPct,
    required this.finalPrice,
    required this.actualSalesPriceLabel,
    required this.costPercent,
    required this.varianceVsFinalPrice,
    required this.ingredient,
    required this.unit,
    required this.unitPrice,
    required this.qtyUsed,
    required this.lineTotal,
    required this.removeIngredient,
    required this.salaryScenarioComparison,
    required this.scenarioA,
    required this.scenarioB,
    required this.difference,
    required this.addOnName,
    required this.removeAddOn,
    required this.expand,
    required this.collapse,
    required this.newMenuItemDefault,
    required this.newAddOnDefault,
    required this.copySuffix,
    required this.thirdsGuidanceNoPriceWithRaw,
    required this.thirdsGuidanceNoData,
    required this.thirdsGuidanceOnTarget,
    required this.thirdsGuidanceOver,
    required this.thirdsGuidanceOverReduce,
    required this.thirdsGuidanceUnder,
    required this.thirdsMinPrice,
    required this.thirdsRaiseOrReduce,
    required this.thirdsReduceOnly,
    required this.salesTargets,
    required this.monthlySales,
    required this.recipeMonthlyTargets,
    required this.recipeMonthlyTargetsHint,
    required this.expectedMonthlyUnits,
    required this.expectedMonthlyUnitsHelper,
    required this.recommendedMonthlyUnits,
    required this.targetMonthlyUnits,
    required this.targetMonthlyRevenue,
    required this.targetMonthlyRawCost,
    required this.targetMonthlyProfit,
    required this.qtySold,
    required this.actualMonthlyRevenue,
    required this.vsTarget,
    required this.aboveTargetBy,
    required this.belowTargetBy,
    required this.onTargetStatus,
    required this.businessPlanComparison,
    required this.menuTargetsTotal,
    required this.addRecipeForTargets,
    required this.previousMonth,
    required this.nextMonth,
    required this.noMenuItemsForSales,
    required this.varianceUnits,
    required this.salesComparisonTitle,
    required this.setBusinessPlanForRecommendations,
    required this.monthlySalesHint,
    required this.setupGuide,
    required this.openSetupGuide,
  });

  final String appTitle;
  final String menuPricing;
  final String businessPlan;
  final String ingredientsPurchase;
  final String settings;
  final String appSettings;
  final String cancel;
  final String delete;
  final String duplicate;
  final String deleteMenuItemTitle;
  final String deleteMenuItemBody;
  final String noMenuItemsYet;
  final String emptyMenuHint;
  final String openSettings;
  final String newMenuItem;
  final String overThirdsRaw;
  final String addOnOne;
  final String addOnMany;
  final String dCost;
  final String businessPlanBannerTitle;
  final String menuRawTotal;
  final String overBudgetBy;
  final String itemNotFound;
  final String itemNoLongerExists;
  final String menuItem;
  final String itemName;
  final String ingredients;
  final String addIngredient;
  final String actualSalesPrice;
  final String actualSalesPriceHelper;
  final String compareSalaryScenarios;
  final String compareSalaryScenariosHelper;
  final String addOns;
  final String addAddOn;
  final String addOnsEmptyHint;
  final String notesOptional;
  final String settingsIntro;
  final String packing;
  final String packingHelper;
  final String electric;
  final String electricHelper;
  final String salary;
  final String salaryHelper;
  final String profit;
  final String profitHelper;
  final String rent;
  final String rentHelper;
  final String vat;
  final String vatHelper;
  final String alternateSalary;
  final String alternateSalaryHelper;
  final String currencyLabel;
  final String currencyLabelHelper;
  final String language;
  final String languageEnglish;
  final String languageArabic;
  final String variableCosts;
  final String addCategory;
  final String variableCostsEmptyHint;
  final String variableCostsIntro;
  final String variableCostsIntroSecondary;
  final String ruleOfThirdsTargets;
  final String targetsIntro;
  final String totalVariableCostsEntered;
  final String totalRevenueTarget;
  final String revenuePerThird;
  final String eachThirdEqual;
  final String rawMaterialBudget;
  final String rawMaterialPurchases;
  final String purchasesTotal;
  final String remainingBudget;
  final String setVariableCostsForBudget;
  final String loadFromMenu;
  final String loadedFromMenu;
  final String addPurchase;
  final String ingredientsPurchaseHint;
  final String ingredientsPurchaseEmpty;
  final String clearPurchases;
  final String clearPurchasesConfirm;
  final String profitTarget;
  final String category;
  final String costLabel;
  final String fixedAmountNotPercent;
  final String removeCategory;
  final String ruleOfThirdsRecipe;
  final String ruleOfThirdsRecipeHint;
  final String sellingPriceUsed;
  final String targetRawCost;
  final String actualRawCost;
  final String gap;
  final String variableShareAtPrice;
  final String profitShareAtPrice;
  final String businessRawMaterialBudget;
  final String totalDirectCost;
  final String packingPct;
  final String electricPct;
  final String salaryPct;
  final String profitPct;
  final String rentPct;
  final String rentSubtitle;
  final String totalCostAndProfit;
  final String vatPct;
  final String finalPrice;
  final String actualSalesPriceLabel;
  final String costPercent;
  final String varianceVsFinalPrice;
  final String ingredient;
  final String unit;
  final String unitPrice;
  final String qtyUsed;
  final String lineTotal;
  final String removeIngredient;
  final String salaryScenarioComparison;
  final String scenarioA;
  final String scenarioB;
  final String difference;
  final String addOnName;
  final String removeAddOn;
  final String expand;
  final String collapse;
  final String newMenuItemDefault;
  final String newAddOnDefault;
  final String copySuffix;
  final String thirdsGuidanceNoPriceWithRaw;
  final String thirdsGuidanceNoData;
  final String thirdsGuidanceOnTarget;
  final String thirdsGuidanceOver;
  final String thirdsGuidanceOverReduce;
  final String thirdsGuidanceUnder;
  final String thirdsMinPrice;
  final String thirdsRaiseOrReduce;
  final String thirdsReduceOnly;
  final String salesTargets;
  final String monthlySales;
  final String recipeMonthlyTargets;
  final String recipeMonthlyTargetsHint;
  final String expectedMonthlyUnits;
  final String expectedMonthlyUnitsHelper;
  final String recommendedMonthlyUnits;
  final String targetMonthlyUnits;
  final String targetMonthlyRevenue;
  final String targetMonthlyRawCost;
  final String targetMonthlyProfit;
  final String qtySold;
  final String actualMonthlyRevenue;
  final String vsTarget;
  final String aboveTargetBy;
  final String belowTargetBy;
  final String onTargetStatus;
  final String businessPlanComparison;
  final String menuTargetsTotal;
  final String addRecipeForTargets;
  final String previousMonth;
  final String nextMonth;
  final String noMenuItemsForSales;
  final String varianceUnits;
  final String salesComparisonTitle;
  final String setBusinessPlanForRecommendations;
  final String monthlySalesHint;
  final String setupGuide;
  final String openSetupGuide;

  static const en = _Strings(
    appTitle: 'Menu Pricing Calculator',
    menuPricing: 'Menu Pricing',
    businessPlan: 'Business Plan',
    ingredientsPurchase: 'Ingredient Purchases',
    settings: 'Settings',
    appSettings: 'App Settings',
    cancel: 'Cancel',
    delete: 'Delete',
    duplicate: 'Duplicate',
    deleteMenuItemTitle: 'Delete menu item?',
    deleteMenuItemBody: 'Delete "{name}"? This cannot be undone.',
    noMenuItemsYet: 'No menu items yet',
    emptyMenuHint:
        'Add your first item, or open Settings to confirm the default cost percentages.',
    openSettings: 'Open Settings',
    newMenuItem: 'New Menu Item',
    overThirdsRaw: 'Over 1/3 raw',
    addOnOne: '1 add-on',
    addOnMany: '{n} add-ons',
    dCost: 'D.Cost: {amount}',
    businessPlanBannerTitle: 'Business plan (if sold once each)',
    menuRawTotal: 'Menu raw total: {raw} | Budget: {budget}',
    overBudgetBy: 'Over budget by {amount}',
    itemNotFound: 'Item not found',
    itemNoLongerExists: 'This menu item no longer exists.',
    menuItem: 'Menu Item',
    itemName: 'Item name',
    ingredients: 'Ingredients',
    addIngredient: 'Add Ingredient',
    actualSalesPrice: 'Actual Sales Price',
    actualSalesPriceHelper:
        'Optional. Used for Cost % check against your real menu price.',
    compareSalaryScenarios: 'Compare Salary Scenarios',
    compareSalaryScenariosHelper:
        'Show Scenario A vs Scenario B final prices side by side.',
    addOns: 'Add-ons',
    addAddOn: 'Add Add-on',
    addOnsEmptyHint:
        'Optional variants with their own ingredient lists and pricing.',
    notesOptional: 'Notes (optional)',
    settingsIntro:
        'These percentages apply to every menu item. Changes recalculate all prices immediately.',
    packing: 'Packing',
    packingHelper: 'Applied to Total D.Cost.',
    electric: 'Electric',
    electricHelper: 'Applied to Total D.Cost + Packing.',
    salary: 'Salary',
    salaryHelper: 'Applied to Total D.Cost + Packing + Electric.',
    profit: 'Profit',
    profitHelper: 'Applied to Total D.Cost + Packing + Electric + Salary.',
    rent: 'Rent',
    rentHelper:
        'Applied to Packing + Electric + Salary + Profit only — not on raw ingredient cost.',
    vat: 'VAT',
    vatHelper: 'Applied to Total Cost & Profit.',
    alternateSalary: 'Alternate Salary (Scenario B)',
    alternateSalaryHelper:
        'Used when comparing salary scenarios on an item detail screen.',
    currencyLabel: 'Currency label',
    currencyLabelHelper: 'Shown after all prices, e.g. LE.',
    language: 'Language',
    languageEnglish: 'English',
    languageArabic: 'Arabic',
    variableCosts: 'Variable Costs',
    addCategory: 'Add Category',
    variableCostsEmptyHint:
        'Add categories for wages, electricity, water, or any custom cost.',
    variableCostsIntro:
        'Enter fixed cost amounts in {currency} — not percentages. Examples: monthly wages 15,000 LE, electricity 2,000 LE.',
    variableCostsIntroSecondary:
        'Each third is equal to your variable-cost total. Total revenue is 3× that amount.',
    ruleOfThirdsTargets: 'Rule of Thirds Targets',
    targetsIntro:
        'Totals below are in {currency}. Each third is equal; total revenue is three times the variable-cost total.',
    totalVariableCostsEntered: 'Total Variable Costs (entered)',
    totalRevenueTarget: 'Total Revenue Target (3× variable)',
    revenuePerThird: 'Revenue per third (1/3)',
    eachThirdEqual: 'Each third (equal)',
    rawMaterialBudget: 'Raw Material Budget (1/3)',
    rawMaterialPurchases: 'Purchases vs Budget',
    purchasesTotal: 'Your purchases total',
    remainingBudget: 'Remaining budget: {amount}',
    setVariableCostsForBudget:
        'Enter variable costs in Business Plan to set your raw material budget.',
    loadFromMenu: 'Load from menu',
    loadedFromMenu: 'Ingredients loaded from your menu recipes.',
    addPurchase: 'Add item',
    ingredientsPurchaseHint:
        'Enter what you are buying: name, unit, price per unit, and quantity.',
    ingredientsPurchaseEmpty:
        'Add purchases manually or load ingredients from your menu recipes.',
    clearPurchases: 'Clear all purchases',
    clearPurchasesConfirm: 'Remove all ingredient purchases?',
    profitTarget: 'Profit Target (1/3)',
    category: 'Category',
    costLabel: 'Cost ({currency})',
    fixedAmountNotPercent: 'Fixed amount, not %',
    removeCategory: 'Remove category',
    ruleOfThirdsRecipe: 'Rule of Thirds (Recipe Target)',
    ruleOfThirdsRecipeHint: 'At this selling price, each third should be equal.',
    sellingPriceUsed: 'Selling price used',
    targetRawCost: 'Target raw cost',
    actualRawCost: 'Actual raw cost',
    gap: 'Gap',
    variableShareAtPrice: 'Variable share at this price',
    profitShareAtPrice: 'Profit share at this price',
    businessRawMaterialBudget: 'Business raw material budget',
    totalDirectCost: 'Total D.Cost',
    packingPct: 'Packing ({pct}%)',
    electricPct: 'Electric ({pct}%)',
    salaryPct: 'Salary ({pct}%)',
    profitPct: 'Profit ({pct}%)',
    rentPct: 'Rent ({pct}%)',
    rentSubtitle: 'On Packing + Electric + Salary + Profit',
    totalCostAndProfit: 'Total Cost & Profit',
    vatPct: 'VAT ({pct}%)',
    finalPrice: 'Final Price',
    actualSalesPriceLabel: 'Actual Sales Price',
    costPercent: 'Cost %',
    varianceVsFinalPrice: 'Variance vs Final Price',
    ingredient: 'Ingredient',
    unit: 'Unit',
    unitPrice: 'Unit price ({currency})',
    qtyUsed: 'Qty used',
    lineTotal: 'Line total: {amount}',
    removeIngredient: 'Remove ingredient',
    salaryScenarioComparison: 'Salary Scenario Comparison',
    scenarioA: 'Scenario A ({pct}%)',
    scenarioB: 'Scenario B ({pct}%)',
    difference: 'Difference: {amount}',
    addOnName: 'Add-on name',
    removeAddOn: 'Remove add-on',
    expand: 'Expand',
    collapse: 'Collapse',
    newMenuItemDefault: 'New Menu Item',
    newAddOnDefault: 'New Add-on',
    copySuffix: '{name} (Copy)',
    thirdsGuidanceNoPriceWithRaw:
        'Set a selling price of at least {price} (3× raw cost) to satisfy the rule of thirds.',
    thirdsGuidanceNoData:
        'Add ingredients and a selling price to see rule-of-thirds guidance.',
    thirdsGuidanceOnTarget:
        'Recipe raw cost matches the 1/3 target at this price.',
    thirdsGuidanceOver:
        'Raw cost is {gap} above the 1/3 target —{hint}',
    thirdsGuidanceOverReduce:
        'Raw cost is {gap} above the 1/3 target — Reduce ingredient costs.',
    thirdsGuidanceUnder:
        'Raw cost is {gap} below the 1/3 target — room to improve quality/portion, or you are beating the thirds rule.',
    thirdsMinPrice: ' Raise price to at least {price}',
    thirdsRaiseOrReduce: ' or reduce ingredient costs.',
    thirdsReduceOnly: ' Reduce ingredient costs.',
    salesTargets: 'Sales Targets',
    monthlySales: 'Monthly Sales',
    recipeMonthlyTargets: 'Monthly Targets (from recipe)',
    recipeMonthlyTargetsHint:
        'Based on your recipe and business plan. Override with your own target quantity below.',
    expectedMonthlyUnits: 'Target monthly quantity',
    expectedMonthlyUnitsHelper:
        'Optional. Leave empty to use the recommended quantity from your business plan.',
    recommendedMonthlyUnits: 'Recommended monthly quantity',
    targetMonthlyUnits: 'Target monthly quantity',
    targetMonthlyRevenue: 'Target revenue',
    targetMonthlyRawCost: 'Target raw material cost',
    targetMonthlyProfit: 'Target profit share',
    qtySold: 'Quantity sold this month',
    actualMonthlyRevenue: 'Actual revenue',
    vsTarget: 'Target',
    aboveTargetBy: 'Above target by {amount}',
    belowTargetBy: 'Below target by {amount}',
    onTargetStatus: 'On target',
    businessPlanComparison: 'Compared to business plan',
    menuTargetsTotal: 'Menu targets total',
    addRecipeForTargets:
        'Add ingredients and a selling price to see recommended monthly targets.',
    previousMonth: 'Previous month',
    nextMonth: 'Next month',
    noMenuItemsForSales:
        'Add menu items with recipes to set targets and record sales.',
    varianceUnits: 'Units vs target',
    salesComparisonTitle: 'Actual vs target this month',
    setBusinessPlanForRecommendations:
        'Enter variable costs in Business Plan to get recommended monthly quantities.',
    monthlySalesHint:
        'Enter how many of each item you sold. Compare results to your monthly targets.',
    setupGuide: 'Setup & Usage Guide',
    openSetupGuide: 'Open setup guide',
  );

  static const ar = _Strings(
    appTitle: 'حاسبة تسعير القائمة',
    menuPricing: 'تسعير القائمة',
    businessPlan: 'الخطة التشغيلية',
    ingredientsPurchase: 'مشتريات المواد',
    settings: 'الإعدادات',
    appSettings: 'إعدادات التطبيق',
    cancel: 'إلغاء',
    delete: 'حذف',
    duplicate: 'نسخ',
    deleteMenuItemTitle: 'حذف صنف من القائمة؟',
    deleteMenuItemBody: 'حذف "{name}"؟ لا يمكن التراجع عن هذا الإجراء.',
    noMenuItemsYet: 'لا توجد أصناف بعد',
    emptyMenuHint:
        'أضف أول صنف، أو افتح الإعدادات للتحقق من نسب التكلفة الافتراضية.',
    openSettings: 'فتح الإعدادات',
    newMenuItem: 'صنف جديد',
    overThirdsRaw: 'تجاوز ثلث المواد',
    addOnOne: 'إضافة واحدة',
    addOnMany: '{n} إضافات',
    dCost: 'ت.مباشرة: {amount}',
    businessPlanBannerTitle: 'الخطة التشغيلية (إذا بيع كل صنف مرة واحدة)',
    menuRawTotal: 'إجمالي المواد: {raw} | الميزانية: {budget}',
    overBudgetBy: 'تجاوز الميزانية بـ {amount}',
    itemNotFound: 'الصنف غير موجود',
    itemNoLongerExists: 'هذا الصنف لم يعد موجوداً.',
    menuItem: 'صنف',
    itemName: 'اسم الصنف',
    ingredients: 'المكونات',
    addIngredient: 'إضافة مكون',
    actualSalesPrice: 'سعر البيع الفعلي',
    actualSalesPriceHelper:
        'اختياري. يُستخدم للتحقق من نسبة التكلفة مقابل سعر البيع الحقيقي.',
    compareSalaryScenarios: 'مقارنة سيناريوهات المرتبات',
    compareSalaryScenariosHelper:
        'عرض السعر النهائي للسيناريو أ مقابل السيناريو ب جنباً إلى جنب.',
    addOns: 'الإضافات',
    addAddOn: 'إضافة إضافة',
    addOnsEmptyHint: 'متغيرات اختيارية بقائمة مكونات وتسعير مستقل.',
    notesOptional: 'ملاحظات (اختياري)',
    settingsIntro:
        'هذه النسب تُطبق على كل صنف. أي تغيير يُعيد حساب جميع الأسعار فوراً.',
    packing: 'التعبئة',
    packingHelper: 'تُطبق على إجمالي التكلفة المباشرة.',
    electric: 'الكهرباء',
    electricHelper: 'تُطبق على التكلفة المباشرة + التعبئة.',
    salary: 'المرتبات',
    salaryHelper: 'تُطبق على التكلفة المباشرة + التعبئة + الكهرباء.',
    profit: 'الربح',
    profitHelper: 'تُطبق على التكلفة المباشرة + التعبئة + الكهرباء + المرتبات.',
    rent: 'الإيجار',
    rentHelper:
        'يُحسب على التعبئة + الكهرباء + المرتبات + الربح فقط — وليس على تكلفة المواد الخام.',
    vat: 'ض.ق.م',
    vatHelper: 'تُطبق على إجمالي التكلفة والربح.',
    alternateSalary: 'مرتبات بديلة (السيناريو ب)',
    alternateSalaryHelper: 'تُستخدم عند مقارنة سيناريوهات المرتبات في تفاصيل الصنف.',
    currencyLabel: 'رمز العملة',
    currencyLabelHelper: 'يظهر بعد جميع الأسعار، مثل جنيه.',
    language: 'اللغة',
    languageEnglish: 'English',
    languageArabic: 'العربية',
    variableCosts: 'التكاليف المتغيرة',
    addCategory: 'إضافة فئة',
    variableCostsEmptyHint:
        'أضف فئات للمرتبات والكهرباء والمياه أو أي تكلفة مخصصة.',
    variableCostsIntro:
        'أدخل مبالغ ثابتة بـ {currency} — وليس نسباً مئوية. مثال: مرتبات شهرية 15000 جنيه، كهرباء 2000 جنيه.',
    variableCostsIntroSecondary:
        'كل ثلث يساوي إجمالي التكاليف المتغيرة. إجمالي الإيراد = 3× ذلك المبلغ.',
    ruleOfThirdsTargets: 'أهداف قاعدة الأثلاث',
    targetsIntro:
        'الإجماليات أدناه بـ {currency}. كل ثلث متساوٍ؛ إجمالي الإيراد = 3× التكاليف المتغيرة.',
    totalVariableCostsEntered: 'إجمالي التكاليف المتغيرة (مدخل)',
    totalRevenueTarget: 'إجمالي الإيراد المستهدف (3× المتغير)',
    revenuePerThird: 'الإيراد لكل ثلث (1/3)',
    eachThirdEqual: 'كل ثلث (متساوٍ)',
    rawMaterialBudget: 'ميزانية المواد الخام (1/3)',
    rawMaterialPurchases: 'المشتريات مقابل الميزانية',
    purchasesTotal: 'إجمالي مشترياتك',
    remainingBudget: 'الميزانية المتبقية: {amount}',
    setVariableCostsForBudget:
        'أدخل التكاليف المتغيرة في الخطة التشغيلية لتحديد ميزانية المواد.',
    loadFromMenu: 'تحميل من القائمة',
    loadedFromMenu: 'تم تحميل المكونات من وصفات قائمتك.',
    addPurchase: 'إضافة صنف',
    ingredientsPurchaseHint:
        'أدخل ما تشتريه: الاسم، الوحدة، سعر الوحدة، والكمية.',
    ingredientsPurchaseEmpty:
        'أضف مشتريات يدوياً أو حمّل المكونات من وصفات القائمة.',
    clearPurchases: 'مسح كل المشتريات',
    clearPurchasesConfirm: 'إزالة جميع مشتريات المواد؟',
    profitTarget: 'هدف الربح (1/3)',
    category: 'الفئة',
    costLabel: 'التكلفة ({currency})',
    fixedAmountNotPercent: 'مبلغ ثابت، وليس %',
    removeCategory: 'إزالة الفئة',
    ruleOfThirdsRecipe: 'قاعدة الأثلاث (هدف الوصفة)',
    ruleOfThirdsRecipeHint: 'عند هذا سعر البيع، يجب أن يكون كل ثلث متساوياً.',
    sellingPriceUsed: 'سعر البيع المستخدم',
    targetRawCost: 'هدف تكلفة المواد',
    actualRawCost: 'تكلفة المواد الفعلية',
    gap: 'الفرق',
    variableShareAtPrice: 'حصة المتغير عند هذا السعر',
    profitShareAtPrice: 'حصة الربح عند هذا السعر',
    businessRawMaterialBudget: 'ميزانية المواد الخام للنشاط',
    totalDirectCost: 'إجمالي الت. المباشرة',
    packingPct: 'التعبئة ({pct}%)',
    electricPct: 'الكهرباء ({pct}%)',
    salaryPct: 'المرتبات ({pct}%)',
    profitPct: 'الربح ({pct}%)',
    rentPct: 'الإيجار ({pct}%)',
    rentSubtitle: 'على التعبئة + الكهرباء + المرتبات + الربح',
    totalCostAndProfit: 'إجمالي التكلفة والربح',
    vatPct: 'ض.ق.م ({pct}%)',
    finalPrice: 'السعر النهائي',
    actualSalesPriceLabel: 'سعر البيع الفعلي',
    costPercent: 'نسبة التكلفة',
    varianceVsFinalPrice: 'الفرق عن السعر النهائي',
    ingredient: 'المكون',
    unit: 'الوحدة',
    unitPrice: 'سعر الوحدة ({currency})',
    qtyUsed: 'الكمية المستخدمة',
    lineTotal: 'إجمالي السطر: {amount}',
    removeIngredient: 'إزالة المكون',
    salaryScenarioComparison: 'مقارنة سيناريوهات المرتبات',
    scenarioA: 'السيناريو أ ({pct}%)',
    scenarioB: 'السيناريو ب ({pct}%)',
    difference: 'الفرق: {amount}',
    addOnName: 'اسم الإضافة',
    removeAddOn: 'إزالة الإضافة',
    expand: 'توسيع',
    collapse: 'طي',
    newMenuItemDefault: 'صنف جديد',
    newAddOnDefault: 'إضافة جديدة',
    copySuffix: '{name} (نسخة)',
    thirdsGuidanceNoPriceWithRaw:
        'حدد سعر بيع لا يقل عن {price} (3× تكلفة المواد) لتحقيق قاعدة الأثلاث.',
    thirdsGuidanceNoData: 'أضف المكونات وسعر البيع لعرض إرشادات قاعدة الأثلاث.',
    thirdsGuidanceOnTarget: 'تكلفة المواد تطابق هدف الثلث عند هذا السعر.',
    thirdsGuidanceOver: 'تكلفة المواد أعلى من هدف الثلث بـ {gap} —{hint}',
    thirdsGuidanceOverReduce:
        'تكلفة المواد أعلى من هدف الثلث بـ {gap} — قلّل تكلفة المكونات.',
    thirdsGuidanceUnder:
        'تكلفة المواد أقل من هدف الثلث بـ {gap} — مساحة لتحسين الجودة/الحصة، أو أنت أفضل من قاعدة الأثلاث.',
    thirdsMinPrice: ' ارفع السعر إلى {price} على الأقل',
    thirdsRaiseOrReduce: ' أو قلّل تكلفة المكونات.',
    thirdsReduceOnly: ' قلّل تكلفة المكونات.',
    salesTargets: 'أهداف المبيعات',
    monthlySales: 'مبيعات الشهر',
    recipeMonthlyTargets: 'الأهداف الشهرية (من الوصفة)',
    recipeMonthlyTargetsHint:
        'بناءً على الوصفة والخطة التشغيلية. يمكنك تجاوز الكمية الموصى بها أدناه.',
    expectedMonthlyUnits: 'الكمية الشهرية المستهدفة',
    expectedMonthlyUnitsHelper:
        'اختياري. اتركه فارغاً لاستخدام الكمية الموصى بها من الخطة التشغيلية.',
    recommendedMonthlyUnits: 'الكمية الشهرية الموصى بها',
    targetMonthlyUnits: 'الكمية الشهرية المستهدفة',
    targetMonthlyRevenue: 'الإيراد المستهدف',
    targetMonthlyRawCost: 'تكلفة المواد المستهدفة',
    targetMonthlyProfit: 'حصة الربح المستهدفة',
    qtySold: 'الكمية المباعة هذا الشهر',
    actualMonthlyRevenue: 'الإيراد الفعلي',
    vsTarget: 'المستهدف',
    aboveTargetBy: 'أعلى من المستهدف بـ {amount}',
    belowTargetBy: 'أقل من المستهدف بـ {amount}',
    onTargetStatus: 'على المستهدف',
    businessPlanComparison: 'مقارنة بالخطة التشغيلية',
    menuTargetsTotal: 'إجمالي أهداف القائمة',
    addRecipeForTargets:
        'أضف المكونات وسعر البيع لرؤية الأهداف الشهرية الموصى بها.',
    previousMonth: 'الشهر السابق',
    nextMonth: 'الشهر التالي',
    noMenuItemsForSales:
        'أضف أصنافاً بوصفات لتحديد الأهداف وتسجيل المبيعات.',
    varianceUnits: 'الوحدات مقابل المستهدف',
    salesComparisonTitle: 'الفعلي مقابل المستهدف هذا الشهر',
    setBusinessPlanForRecommendations:
        'أدخل التكاليف المتغيرة في الخطة التشغيلية للحصول على كميات شهرية موصى بها.',
    monthlySalesHint:
        'أدخل عدد كل صنف مباع. قارن النتائج بأهدافك الشهرية.',
    setupGuide: 'دليل الإعداد والاستخدام',
    openSetupGuide: 'افتح دليل الإعداد',
  );
}
