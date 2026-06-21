import 'package:flutter/material.dart';

class GuideSection {
  const GuideSection({
    required this.title,
    required this.body,
    this.icon,
    this.isQuickStep = false,
    this.stepNumber,
  });

  final String title;
  final String body;
  final IconData? icon;
  final bool isQuickStep;
  final int? stepNumber;
}

class SetupGuideContent {
  static String intro(String localeCode) {
    return localeCode == 'ar' ? _introAr : _introEn;
  }

  static String quickStartTitle(String localeCode) {
    return localeCode == 'ar' ? _quickStartTitleAr : _quickStartTitleEn;
  }

  static String detailsTitle(String localeCode) {
    return localeCode == 'ar' ? _detailsTitleAr : _detailsTitleEn;
  }

  static List<GuideSection> quickSteps(String localeCode) {
    return localeCode == 'ar' ? _quickStepsAr : _quickStepsEn;
  }

  static List<GuideSection> detailSections(String localeCode) {
    return localeCode == 'ar' ? _detailSectionsAr : _detailSectionsEn;
  }

  static const _introEn =
      'This app helps you price menu items from recipes, plan monthly targets using the rule of thirds, track ingredient purchases, and compare actual sales to your goals. Everything is saved on your device.';
  static const _introAr =
      'يساعدك هذا التطبيق على تسعير أصناف القائمة من الوصفات، وتخطيط الأهداف الشهرية بقاعدة الأثلاث، وتتبع مشتريات المواد، ومقارنة المبيعات الفعلية بأهدافك. كل شيء يُحفظ على جهازك.';

  static const _quickStartTitleEn = 'Quick setup (do this first)';
  static const _quickStartTitleAr = 'الإعداد السريع (ابدأ بهذا)';

  static const _detailsTitleEn = 'How to use each screen';
  static const _detailsTitleAr = 'كيفية استخدام كل شاشة';

  static const _quickStepsEn = [
    GuideSection(
      stepNumber: 1,
      isQuickStep: true,
      icon: Icons.settings_outlined,
      title: 'Open Settings',
      body:
          'Confirm your currency label (default: LE) and cost percentages. Switch to Arabic here if you prefer. These percentages apply to every menu item.',
    ),
    GuideSection(
      stepNumber: 2,
      isQuickStep: true,
      icon: Icons.account_balance_outlined,
      title: 'Fill in Business Plan',
      body:
          'Enter your monthly variable costs as fixed amounts — wages, electricity, rent, etc. The app calculates your revenue target (3× costs), raw material budget, and profit target.',
    ),
    GuideSection(
      stepNumber: 3,
      isQuickStep: true,
      icon: Icons.restaurant_menu_outlined,
      title: 'Add menu items & recipes',
      body:
          'Tap + on the home screen. For each item, add ingredients (name, unit, price, quantity per serving) and optionally your actual selling price.',
    ),
    GuideSection(
      stepNumber: 4,
      isQuickStep: true,
      icon: Icons.track_changes_outlined,
      title: 'Review Sales Targets',
      body:
          'Open Sales Targets from the top bar. Check recommended monthly quantities and totals. Override target quantity on any item if needed.',
    ),
    GuideSection(
      stepNumber: 5,
      isQuickStep: true,
      icon: Icons.shopping_cart_outlined,
      title: 'Log ingredient purchases',
      body:
          'When you shop, add what you buy in Ingredient Purchases. Compare your spending to the raw material budget from your business plan.',
    ),
    GuideSection(
      stepNumber: 6,
      isQuickStep: true,
      icon: Icons.bar_chart_outlined,
      title: 'Record monthly sales',
      body:
          'At month end, open Monthly Sales, pick the month, and enter how many of each item you sold. See actual vs target for revenue, raw cost, and profit.',
    ),
  ];

  static const _quickStepsAr = [
    GuideSection(
      stepNumber: 1,
      isQuickStep: true,
      icon: Icons.settings_outlined,
      title: 'افتح الإعدادات',
      body:
          'تأكد من عملة العرض (افتراضياً: LE) ونسب التكلفة. يمكنك التبديل إلى العربية من هنا. هذه النسب تُطبَّق على كل صنف.',
    ),
    GuideSection(
      stepNumber: 2,
      isQuickStep: true,
      icon: Icons.account_balance_outlined,
      title: 'أكمل الخطة التشغيلية',
      body:
          'أدخل تكاليفك المتغيرة الشهرية كمبالغ ثابتة — أجور، كهرباء، إيجار، إلخ. يحسب التطبيق هدف الإيراد (3× التكاليف) وميزانية المواد وهدف الربح.',
    ),
    GuideSection(
      stepNumber: 3,
      isQuickStep: true,
      icon: Icons.restaurant_menu_outlined,
      title: 'أضف أصناف القائمة والوصفات',
      body:
          'اضغط + في الشاشة الرئيسية. لكل صنف، أضف المكونات (الاسم، الوحدة، السعر، الكمية للحصة) واختيارياً سعر البيع الفعلي.',
    ),
    GuideSection(
      stepNumber: 4,
      isQuickStep: true,
      icon: Icons.track_changes_outlined,
      title: 'راجع أهداف المبيعات',
      body:
          'افتح أهداف المبيعات من الشريط العلوي. تحقق من الكميات والإجماليات الموصى بها. يمكنك تعديل الكمية المستهدفة لأي صنف.',
    ),
    GuideSection(
      stepNumber: 5,
      isQuickStep: true,
      icon: Icons.shopping_cart_outlined,
      title: 'سجّل مشتريات المواد',
      body:
          'عند التسوق، أضف ما تشتريه في مشتريات المواد. قارن إنفاقك بميزانية المواد من الخطة التشغيلية.',
    ),
    GuideSection(
      stepNumber: 6,
      isQuickStep: true,
      icon: Icons.bar_chart_outlined,
      title: 'سجّل مبيعات الشهر',
      body:
          'في نهاية الشهر، افتح مبيعات الشهر، اختر الشهر، وأدخل كم بعت من كل صنف. قارن الفعلي بالمستهدف للإيراد والمواد والربح.',
    ),
  ];

  static const _detailSectionsEn = [
    GuideSection(
      icon: Icons.home_outlined,
      title: 'Home — Menu Pricing',
      body:
          'Your menu list lives here. Tap an item to edit its recipe. Top bar icons:\n\n'
          '• Bar chart — Monthly Sales\n'
          '• Track changes — Sales Targets\n'
          '• Cart — Ingredient Purchases\n'
          '• Bank — Business Plan\n'
          '• Gear — Settings\n\n'
          'Swipe left on an item to delete. Use the menu on a card to duplicate.',
    ),
    GuideSection(
      icon: Icons.tune_outlined,
      title: 'Settings — cost percentages',
      body:
          'Packing → Electric → Salary → Profit → Rent → VAT stack on each item\'s ingredient cost. Rent applies only to overhead layers, not raw ingredients.\n\n'
          'Defaults: Packing 5%, Electric 5%, Salary 50%, Profit 75%, Rent 15%, VAT 14%.',
    ),
    GuideSection(
      icon: Icons.account_balance_outlined,
      title: 'Business Plan — rule of thirds',
      body:
          'Sum of variable costs = V.\n'
          'Revenue target = 3V\n'
          'Raw material budget = V\n'
          'Profit target = V\n\n'
          'Each third of revenue should cover raw materials, variable costs, and profit equally.',
    ),
    GuideSection(
      icon: Icons.receipt_long_outlined,
      title: 'Menu item — recipe & pricing',
      body:
          'Ingredient line total = unit price × quantity used.\n\n'
          'The pricing card shows the full cascade to final price.\n\n'
          'Rule of thirds per item: target raw cost = selling price ÷ 3.\n\n'
          'Actual sales price: use if you charge differently from the calculated price.\n\n'
          'Target monthly quantity: override the recommended sales volume for this item.',
    ),
    GuideSection(
      icon: Icons.shopping_bag_outlined,
      title: 'Ingredient Purchases',
      body:
          'Load from menu to pull all recipe ingredients, or add lines manually.\n\n'
          'The budget card compares your purchase total to the raw material budget from Business Plan.\n\n'
          'Set up Business Plan first — otherwise there is no budget to compare.',
    ),
    GuideSection(
      icon: Icons.insights_outlined,
      title: 'Sales Targets',
      body:
          'Shows monthly targets for all items with recipes: revenue, raw cost, and profit.\n\n'
          'Recommended quantity splits your business revenue target evenly across priced items.\n\n'
          'Compare menu totals to your Business Plan targets.',
    ),
    GuideSection(
      icon: Icons.calendar_month_outlined,
      title: 'Monthly Sales',
      body:
          'Use ◀ ▶ to change month. Each month is saved separately.\n\n'
          'Enter quantity sold per item. The summary compares actual revenue, raw cost, and profit to your menu targets.\n\n'
          'Review at month end to decide price or recipe changes for next month.',
    ),
    GuideSection(
      icon: Icons.lightbulb_outline,
      title: 'Monthly routine',
      body:
          'Start of month: update Business Plan if costs changed.\n'
          'Planning: check Sales Targets.\n'
          'Shopping: log Ingredient Purchases.\n'
          'End of month: enter sales in Monthly Sales and review variances.\n\n'
          'Data stays on this device only. Uninstalling the app deletes everything.',
    ),
  ];

  static const _detailSectionsAr = [
    GuideSection(
      icon: Icons.home_outlined,
      title: 'الرئيسية — تسعير القائمة',
      body:
          'قائمة أصنافك هنا. اضغط على صنف لتعديل وصفته. أيقونات الشريط العلوي:\n\n'
          '• الرسم البياني — مبيعات الشهر\n'
          '• تتبع — أهداف المبيعات\n'
          '• السلة — مشتريات المواد\n'
          '• البنك — الخطة التشغيلية\n'
          '• الترس — الإعدادات\n\n'
          'اسحب يساراً للحذف. استخدم قائمة البطاقة للنسخ.',
    ),
    GuideSection(
      icon: Icons.tune_outlined,
      title: 'الإعدادات — نسب التكلفة',
      body:
          'التعبئة ← الكهرباء ← الأجور ← الربح ← الإيجار ← ض.ق.م تتراكم على تكلفة المكونات. الإيجار على الطبقات غير المواد فقط.\n\n'
          'الافتراضي: تعبئة 5%، كهرباء 5%، أجور 50%، ربح 75%، إيجار 15%، ض.ق.م 14%.',
    ),
    GuideSection(
      icon: Icons.account_balance_outlined,
      title: 'الخطة التشغيلية — قاعدة الأثلاث',
      body:
          'مجموع التكاليف المتغيرة = V\n'
          'هدف الإيراد = 3V\n'
          'ميزانية المواد = V\n'
          'هدف الربح = V\n\n'
          'كل ثلث من الإيراد يغطي المواد والتكاليف المتغيرة والربح بالتساوي.',
    ),
    GuideSection(
      icon: Icons.receipt_long_outlined,
      title: 'صنف القائمة — الوصفة والتسعير',
      body:
          'إجمالي المكون = سعر الوحدة × الكمية المستخدمة.\n\n'
          'بطاقة التسعير تعرض سلسلة الحساب حتى السعر النهائي.\n\n'
          'قاعدة الأثلاث: تكلفة المواد المستهدفة = سعر البيع ÷ 3.\n\n'
          'سعر البيع الفعلي: إذا كان مختلفاً عن السعر المحسوب.\n\n'
          'الكمية الشهرية المستهدفة: لتجاوز الكمية الموصى بها.',
    ),
    GuideSection(
      icon: Icons.shopping_bag_outlined,
      title: 'مشتريات المواد',
      body:
          'حمّل من القائمة لسحب مكونات الوصفات، أو أضف يدوياً.\n\n'
          'بطاقة الميزانية تقارن مشترياتك بميزانية المواد من الخطة التشغيلية.\n\n'
          'أكمل الخطة التشغيلية أولاً.',
    ),
    GuideSection(
      icon: Icons.insights_outlined,
      title: 'أهداف المبيعات',
      body:
          'تعرض الأهداف الشهرية: الإيراد وتكلفة المواد والربح.\n\n'
          'الكمية الموصى بها تقسم هدف الإيراد بالتساوي على الأصناف ذات السعر.\n\n'
          'قارن إجماليات القائمة بأهداف الخطة التشغيلية.',
    ),
    GuideSection(
      icon: Icons.calendar_month_outlined,
      title: 'مبيعات الشهر',
      body:
          'استخدم ◀ ▶ لتغيير الشهر. كل شهر يُحفظ منفصلاً.\n\n'
          'أدخل الكمية المباعة. الملخص يقارن الفعلي بالمستهدف.\n\n'
          'راجع في نهاية الشهر لتعديل الأسعار أو الوصفات.',
    ),
    GuideSection(
      icon: Icons.lightbulb_outline,
      title: 'روتين شهري',
      body:
          'بداية الشهر: حدّث الخطة التشغيلية.\n'
          'التخطيط: راجع أهداف المبيعات.\n'
          'التسوق: سجّل مشتريات المواد.\n'
          'نهاية الشهر: أدخل المبيعات وراجع الفروقات.\n\n'
          'البيانات على هذا الجهاز فقط. حذف التطبيق يمسح كل شيء.',
    ),
  ];
}
