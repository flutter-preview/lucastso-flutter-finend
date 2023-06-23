import 'package:finend/expenses/models/expense.dart';
import 'package:finend/incomes/models/income.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseIncomeProvider with ChangeNotifier {
  List<Expense> _expenses = [];
  List<Income> _incomes = [];

  List<Expense> get expenses => _expenses;
  List<Income> get incomes => _incomes;

  SharedPreferences? _preferences;

  ExpenseIncomeProvider() {
    init();
  }

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    loadExpenses();
    loadIncomes();
  }

  void loadExpenses() {
    final expenseList = _preferences?.getStringList('expenses') ?? [];
    _expenses = expenseList.map((e) => Expense.fromString(e)).toList();
    notifyListeners();
  }

  void loadIncomes() {
    final incomeList = _preferences?.getStringList('incomes') ?? [];
    _incomes = incomeList.map((e) => Income.fromString(e)).toList();
    notifyListeners();
  }

  Future<void> addExpense(Expense expense) async {
    _expenses.add(expense);
    await _preferences?.setStringList(
      'expenses',
      _expenses.map((e) => e.toString()).toList(),
    );
    notifyListeners();
  }

  Future<void> addIncome(Income income) async {
    _incomes.add(income);
    await _preferences?.setStringList(
      'incomes',
      _incomes.map((e) => e.toString()).toList(),
    );
    notifyListeners();
  }
}
