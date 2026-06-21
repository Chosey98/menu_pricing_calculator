# Menu Pricing Calculator

A Flutter app for food and beverage businesses. It helps you:

- Price menu items from recipes (Excel-style cost cascade)
- Plan monthly targets using the **rule of thirds**
- Track ingredient purchases against your raw-material budget
- Record monthly sales and compare **actual vs target**

All data is stored **locally on your device** (no account or internet required).

Supports **English** and **Arabic** (RTL).

---

## Table of contents

1. [Install the app](#1-install-the-app)
2. [First-time setup (recommended order)](#2-first-time-setup-recommended-order)
3. [Home screen — Menu Pricing](#3-home-screen--menu-pricing)
4. [Settings — cost percentages & language](#4-settings--cost-percentages--language)
5. [Business Plan — monthly variable costs](#5-business-plan--monthly-variable-costs)
6. [Menu items — recipes & pricing](#6-menu-items--recipes--pricing)
7. [Ingredient Purchases — shopping vs budget](#7-ingredient-purchases--shopping-vs-budget)
8. [Sales Targets — recommended monthly goals](#8-sales-targets--recommended-monthly-goals)
9. [Monthly Sales — record results & compare](#9-monthly-sales--record-results--compare)
10. [How the math works](#10-how-the-math-works)
11. [Tips & monthly workflow](#11-tips--monthly-workflow)

---

## 1. Install the app

### On your phone (Android)

1. Enable **Developer options** and **USB debugging** on your device.
2. Connect the phone to your computer with USB.
3. From the project folder, run:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

4. Pick your device when prompted (e.g. Samsung SM S928B).

The app stays installed after the first run. You can open it from your app drawer like any other app.

### Build a release APK (optional)

```bash
flutter build apk --release
```

The APK is at `build/app/outputs/flutter-apk/app-release.apk`.

### Requirements for development

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable channel)
- Android Studio or Android SDK (for Android builds)

---

## 2. First-time setup (recommended order)

Follow these steps once when you start using the app:

| Step | Where | What to do |
|------|--------|------------|
| 1 | **Settings** (gear icon) | Confirm currency label (default: **LE**) and cost percentages. Switch language if needed. |
| 2 | **Business Plan** (bank icon) | Enter your **monthly variable costs** (wages, electricity, rent, etc.) as fixed amounts — not percentages. |
| 3 | **Menu Pricing** (home) | Tap **+** to add menu items. For each item, add **ingredients** (recipe) and optionally an **actual sales price**. |
| 4 | **Sales Targets** (track-changes icon) | Review recommended monthly quantities and totals. Adjust **target monthly quantity** on any item if needed. |
| 5 | **Ingredient Purchases** (cart icon) | When you shop, log what you buy and check if you are over your raw-material budget. |
| 6 | **Monthly Sales** (bar chart icon) | At month end, enter how many of each item you sold and review actual vs target. |

---

## 3. Home screen — Menu Pricing

This is the main screen when you open the app.

### Top bar icons (left to right)

| Icon | Screen | Purpose |
|------|--------|---------|
| Bar chart | **Monthly Sales** | Enter quantities sold and compare to targets |
| Track changes | **Sales Targets** | See recommended monthly goals for all items |
| Shopping cart | **Ingredient Purchases** | Log purchases vs raw-material budget |
| Bank | **Business Plan** | Enter monthly variable costs |
| Gear | **Settings** | Cost percentages, currency, language |

### Menu list

- Tap a item to open its **recipe and pricing** detail.
- Tap **+** (floating button) to create a new menu item.
- Swipe an item left to delete (you will be asked to confirm).
- Use the menu on an item card to **duplicate** it.

### Business plan banner

If you have entered variable costs in Business Plan, a banner shows:

- Total raw cost of all menu recipes **if each item is sold once**
- Compared to your **raw material budget** (1/3 of business revenue target)

This is a quick sanity check — not the same as weighted monthly targets (see [Sales Targets](#8-sales-targets--recommended-monthly-goals)).

---

## 4. Settings — cost percentages & language

Open via the **gear icon** on the home screen.

### Cost cascade percentages

These apply to **every menu item**. They stack in order (like Excel):

1. **Packing** — on total direct (ingredient) cost  
2. **Electric** — on direct + packing  
3. **Salary** — on direct + packing + electric  
4. **Profit** — on direct + packing + electric + salary  
5. **Rent** — on packing + electric + salary + profit only (**not** on raw ingredients)  
6. **VAT** — on total cost and profit  

**Defaults:**

| Setting | Default |
|---------|---------|
| Packing | 5% |
| Electric | 5% |
| Salary | 50% |
| Profit | 75% |
| Rent | 15% |
| VAT | 14% |
| Alternate salary (Scenario B) | 20% |

Changes recalculate all menu prices immediately.

### Other settings

- **Currency label** — shown next to amounts (e.g. LE, EGP, SAR). This is display only; it does not convert currencies.
- **Language** — English or Arabic. The whole app layout flips to RTL for Arabic.

---

## 5. Business Plan — monthly variable costs

Open via the **bank icon**.

### Variable costs

Add categories with a **name** and a **fixed monthly amount** (not a percentage).

Default categories: Wages, Electricity, Water. You can:

- Rename categories
- Change amounts
- Add new categories
- Remove categories

### Rule of thirds targets

When you enter variable costs, the app calculates:

```
Total variable costs = V  (sum of all categories)

Total revenue target   = 3 × V
Raw material budget    = V      (one third)
Profit target          = V      (one third)
Revenue per third      = V
```

Each third of your revenue should cover: raw materials, variable/overhead costs, and profit — all equal to **V**.

From Business Plan you can also jump to **Ingredient Purchases** and **Monthly Sales** when relevant data exists.

---

## 6. Menu items — recipes & pricing

Tap any item on the home screen to edit it.

### Item name

The name shown on your menu and in reports.

### Ingredients (recipe)

Each ingredient line has:

| Field | Meaning |
|-------|---------|
| Name | e.g. Beef, Flour |
| Unit | e.g. kg, L, piece |
| Unit price | Cost per unit |
| Quantity used | Amount used in **one serving** of this item |

**Line total** = unit price × quantity used.

Tap **Add Ingredient** to add lines. Use the delete control on a row to remove one.

### Pricing summary (top of screen)

Shows the full **cost cascade** from ingredients to **final price**, using your Settings percentages.

### Rule of thirds — per item

If the item has a selling price, you see:

- Target raw cost = selling price ÷ 3  
- Actual raw cost = sum of ingredients  
- Gap and guidance (raise price, reduce ingredients, etc.)

### Monthly targets — per item

After you add ingredients and a price:

- **Recommended monthly quantity** — calculated from your Business Plan (revenue target split evenly across priced items)
- **Target revenue / raw cost / profit** for the month

### Actual sales price

Optional. If set, it is used instead of the cascade **final price** for:

- Cost % checks  
- Rule of thirds analysis  
- Monthly targets and sales comparison  

Leave empty to use the calculated cascade price.

### Target monthly quantity

Optional override. If you enter a number, it replaces the recommended quantity for that item in Sales Targets and Monthly Sales.

Leave empty to use the auto-recommended value from Business Plan.

### Compare salary scenarios

Toggle to show **Scenario A** (Settings salary %) vs **Scenario B** (alternate salary %) side by side.

### Add-ons

Optional variants (e.g. “Large”, “Extra cheese”) with their own ingredient lists and pricing.

### Notes

Free text for your own reference.

---

## 7. Ingredient Purchases — shopping vs budget

Open via the **shopping cart icon**.

Use this when you **buy ingredients** for the month.

### Budget card

Compares:

- **Raw material budget** — from Business Plan (1/3 of revenue target)  
- **Your purchases total** — sum of all lines you enter  

Shows **remaining budget** or **over budget by** with a progress bar.

> Set up Business Plan first — otherwise there is no budget to compare against.

### Add purchases

**Load from menu** — pulls ingredients from all menu recipes and merges duplicates (same name + unit).

**Add item** — enter purchases manually: name, unit, unit price, quantity.

**Clear all** — removes every purchase line (with confirmation).

Purchases are saved on your device as one running list (not split by month).

---

## 8. Sales Targets — recommended monthly goals

Open via the **track-changes icon**.

Shows a **summary** for all menu items that have recipes:

| Metric | Meaning |
|--------|---------|
| Target revenue | Sum of (selling price × target quantity) per item |
| Target raw cost | Sum of (ingredient cost × target quantity) |
| Target profit | Sum of profit share (revenue ÷ 3 per item) |

### Compared to business plan

If Business Plan is filled in, you also see how menu totals compare to:

- Total revenue target (3× variable costs)  
- Raw material budget  
- Profit target  

Green/on-target, over, or under indicators help you adjust quantities or prices.

### Per-item list

Each item shows target quantity, revenue, raw cost, and profit.

**Recommended quantity** comes from splitting your business revenue target evenly across all priced items. Override on the item detail screen with **Target monthly quantity** if you want different mix (e.g. sell more burgers than salads).

---

## 9. Monthly Sales — record results & compare

Open via the **bar chart icon**.

Use this **at the end of each month** (or anytime to track progress).

### Pick a month

Use **◀** and **▶** to move between months. Each month is saved separately.

### Summary card — Actual vs target

For the selected month:

| Metric | Comparison |
|--------|------------|
| Revenue | Actual vs menu target total |
| Raw material cost | Actual vs menu target total |
| Profit share | Actual vs menu target total |

### Per item

For each menu item with a target:

1. See **target monthly quantity**  
2. Enter **quantity sold this month**  
3. View actual revenue and **units vs target** (above/below)

Data saves automatically as you type.

From here you can also open **Sales Targets** via the top bar icon.

---

## 10. How the math works

### A. Item pricing (cascade)

```
Direct cost     = sum of ingredient line totals
+ Packing       = direct × packing %
+ Electric      = (direct + packing) × electric %
+ Salary        = (direct + packing + electric) × salary %
+ Profit        = (direct + packing + electric + salary) × profit %
+ Rent          = (packing + electric + salary + profit) × rent %   ← not on direct cost
= Total cost & profit
+ VAT           = total × VAT %
= Final price
```

### B. Rule of thirds — business level

```
V = total monthly variable costs (Business Plan)

Revenue target     = 3V
Raw budget         = V
Profit target      = V
```

### C. Rule of thirds — per item (per serving)

```
Selling price = actual sales price OR cascade final price

Target raw cost per serving = selling price ÷ 3
Actual raw cost             = sum of ingredients
```

### D. Recommended monthly quantity (auto)

```
Revenue share per item = total revenue target ÷ number of priced items
Recommended units      = revenue share ÷ item selling price (rounded)
```

### E. Monthly comparison

```
Target revenue  = Σ (selling price × target units)
Actual revenue  = Σ (selling price × units sold)

(same pattern for raw cost and profit share)
```

---

## 11. Tips & monthly workflow

### Suggested monthly routine

1. **Start of month** — Review Business Plan costs; update if wages or rent changed.  
2. **Planning** — Check **Sales Targets**; adjust target quantities on key items.  
3. **Shopping** — Log purchases in **Ingredient Purchases**; stay within raw budget.  
4. **During the month** — Optionally enter partial sales in **Monthly Sales**.  
5. **End of month** — Enter final quantities sold; review actual vs target; adjust next month’s prices or recipes.

### Good practices

- Enter **actual sales price** if what you charge differs from the calculated cascade price.  
- Add **all ingredients** for accurate raw cost — the rule of thirds and budgets depend on it.  
- Use **duplicate** on the menu list to create similar items faster.  
- Set Business Plan **before** relying on budget or recommended quantities.

### Data & privacy

- Everything is stored locally using Hive (on-device database).  
- Uninstalling the app removes all data.  
- There is no cloud sync or backup built in — export or note critical figures separately if needed.

---

## Development commands

```bash
# Install dependencies
flutter pub get

# Regenerate Hive adapters after model changes
dart run build_runner build --delete-conflicting-outputs

# Run tests
flutter test

# Static analysis
flutter analyze

# Run on connected device
flutter run
```

---

## Project structure (for developers)

```
lib/
  models/          Hive data models (menu items, business plan, sales, etc.)
  providers/       Riverpod state and persistence
  screens/         UI screens
  widgets/         Reusable cards and rows
  utils/           Pricing, thirds, and sales calculators
  l10n/            English and Arabic strings
test/              Unit tests for calculators
```
