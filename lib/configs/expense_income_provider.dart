import 'dart:convert';
import 'package:finend/expenses/models/expense.dart';
import 'package:finend/incomes/models/income.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseIncomeManager extends ChangeNotifier {
  static const String _keyExpenses = 'expenses';
  static const String _keyIncomes = 'incomes';
  static const String _keyUser = 'user';

  SharedPreferences? _prefs;
  List<Expense> _expenses = [];
  List<Income> _incomes = [];
  List<Expense> get expenses => _expenses;
  List<Income> get incomes => _incomes;

  Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> clearAllData() async {
    await _initPrefs();
    _expenses = [];
    _incomes = [];
    await _prefs!.remove(_keyExpenses);
    await _prefs!.remove(_keyIncomes);
    notifyListeners();
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

  List<dynamic> filterTransactions(String searchQuery) {
    List<Expense> expenses = _expenses;
    List<Income> incomes = _incomes;
    List<dynamic> allTransactions = [];

    allTransactions.addAll(expenses);
    allTransactions.addAll(incomes);
    allTransactions.shuffle();

    if (searchQuery.isNotEmpty) {
      searchQuery = searchQuery.toLowerCase();
      allTransactions = allTransactions.where((transaction) {
        String transactionName = transaction.name.toLowerCase();
        return transactionName.contains(searchQuery);
      }).toList();
    }

    return allTransactions;
  }

  Future<void> editExpense(String expenseId, Expense editedExpense) async {
    await _initPrefs();

    final index = _expenses.indexWhere((expense) => expense.id == expenseId);
    if (index != -1) {
      _expenses[index] = editedExpense;
      final expensesJson =
          jsonEncode(_expenses.map((expense) => expense.toJson()).toList());
      _prefs!.setString(_keyExpenses, expensesJson);
    }

    notifyListeners();
  }

  Future<void> editIncome(String incomeId, Income editedIncome) async {
    await _initPrefs();

    final index = _incomes.indexWhere((income) => income.id == incomeId);
    if (index != -1) {
      _incomes[index] = editedIncome;
      final incomesJson =
          jsonEncode(_incomes.map((income) => income.toJson()).toList());
      _prefs!.setString(_keyIncomes, incomesJson);
    }

    notifyListeners();
  }

  Future<void> saveUserName(String name) async {
    await _initPrefs();
    await _prefs!.setString(_keyUser, name);
    notifyListeners();
  }

  String getUserName() {
    return _prefs?.getString(_keyUser) ?? 'Usuário Finend';
  }
}
