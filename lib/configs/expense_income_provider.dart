import 'dart:convert';
import 'package:finend/expenses/models/expense.dart';
import 'package:finend/incomes/models/income.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseIncomeManager extends ChangeNotifier {
  static const String _keyExpenses = 'expenses';
  static const String _keyIncomes = 'incomes';

  SharedPreferences? _prefs;
  List<Expense> _expenses = [];
  List<Income> _incomes = [];
  List<Expense> get expenses => _expenses;
  List<Income> get incomes => _incomes;

  Future<void> _initPrefs() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  Future<void> getExpenses() async {
    await _initPrefs();

    final expensesJson = _prefs!.getString(_keyExpenses);
    if (expensesJson != null) {
      final expensesList = jsonDecode(expensesJson) as List<dynamic>;
      _expenses = expensesList
          .map((expenseJson) => Expense.fromJson(expenseJson))
          .toList();
    } else {
      _expenses = [];
    }

    notifyListeners();
  }

  Future<void> getIncomes() async {
    await _initPrefs();

    final incomesJson = _prefs!.getString(_keyIncomes);
    if (incomesJson != null) {
      final incomesList = jsonDecode(incomesJson) as List<dynamic>;
      _incomes = incomesList
          .map((incomesJson) => Income.fromJson(incomesJson))
          .toList();
    } else {
      _incomes = [];
    }

    notifyListeners();
  }

  Future<void> addExpense(Expense expense) async {
    await _initPrefs();

    _expenses.add(expense);
    final expensesJson =
        jsonEncode(_expenses.map((expense) => expense.toJson()).toList());
    _prefs!.setString(_keyExpenses, expensesJson);

    notifyListeners();
  }

  Future<void> addIncome(Income income) async {
    await _initPrefs();

    _incomes.add(income);
    final incomesJson =
        jsonEncode(_incomes.map((income) => income.toJson()).toList());
    _prefs!.setString(_keyIncomes, incomesJson);

    notifyListeners();
  }

  Future<void> removeExpense(Expense expense) async {
    await _initPrefs();

    _expenses.remove(expense);
    final expensesJson =
        jsonEncode(_expenses.map((expense) => expense.toJson()).toList());
    _prefs!.setString(_keyExpenses, expensesJson);

    notifyListeners();
  }

  Future<void> removeIncome(Income income) async {
    await _initPrefs();

    _incomes.remove(income);
    final incomesJson =
        jsonEncode(_incomes.map((income) => income.toJson()).toList());
    _prefs!.setString(_keyIncomes, incomesJson);

    notifyListeners();
  }

  Future<void> getExpensesAndIncomes() async {
    await getExpenses();
    await getIncomes();
  }

  /*Future<void> updateExpense(Expense oldExpense, Expense newExpense) async {
    await _initPrefs();

    final expenses = await getExpenses();
    final index = expenses.indexOf(oldExpense);
    if (index != -1) {
      expenses[index] = newExpense;
      _prefs!.setString(_keyExpenses, jsonEncode(expenses));
    }
  }

  Future<void> updateIncome(Income oldIncome, Income newIncome) async {
    await _initPrefs();

    final incomes = await getIncomes();
    final index = incomes.indexOf(oldIncome);
    if (index != -1) {
      incomes[index] = newIncome;
      _prefs!.setString(_keyIncomes, jsonEncode(incomes));
    }
  }*/
}
