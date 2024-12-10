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

  // CRUD operations
  void addExpense(String title, String description, double amount) {
    final newExpense = Expense(
      id: Random().nextDouble().toString(),
      title: title,
      description: description,
      amount: amount,
    );
    _expenses.add(newExpense);
    notifyListeners();
  }

  void updateExpense(String id, String newTitle, String newDescription, double newAmount) {
    final idx = _expenses.indexWhere((exp) => exp.id == id);
    if (idx >= 0) {
      _expenses[idx].title = newTitle;
      _expenses[idx].description = newDescription;
      _expenses[idx].amount = newAmount;
      notifyListeners();
    }
  }

  void deleteExpense(String id) {
    _expenses.removeWhere((exp) => exp.id == id);
    notifyListeners();
  }
}
