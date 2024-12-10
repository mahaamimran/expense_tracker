import 'package:flutter/foundation.dart';
import '../models/expense.dart';
import 'dart:math';

class ExpensesProvider extends ChangeNotifier {
  double _salary = 0.0;
  final List<Expense> _expenses = [];

  double get salary => _salary;

  set salary(double value) {
    _salary = value;
    notifyListeners();
  }

  List<Expense> get expenses => [..._expenses];

  double get remainingSalary {
    double totalSpent = _expenses.fold(0.0, (sum, item) => sum + item.amount);
    return _salary - totalSpent;
  }

void addExpense(String title, String description, double amount, String category) {
  final newExpense = Expense(
    id: DateTime.now().toString(),
    title: title,
    description: description,
    amount: amount,
    category: category,
  );
  _expenses.add(newExpense);
  notifyListeners();
}


void updateExpense(String id, String newTitle, String newDescription, double newAmount, String newCategory) {
  final idx = _expenses.indexWhere((exp) => exp.id == id);
  if (idx >= 0) {
    _expenses[idx].title = newTitle;
    _expenses[idx].description = newDescription;
    _expenses[idx].amount = newAmount;
    _expenses[idx].category = newCategory;
    notifyListeners();
  }
}


  void deleteExpense(String id) {
    _expenses.removeWhere((exp) => exp.id == id);
    notifyListeners();
  }
}
