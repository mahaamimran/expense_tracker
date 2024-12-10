import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expenses_provider.dart';
import '../widgets/salary_input.dart';
import '../widgets/expense_card.dart';
import 'add_expense_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final expensesData = Provider.of<ExpensesProvider>(context);
    final expenses = expensesData.expenses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Salary input section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SalaryInput(
              initialSalary: expensesData.salary,
              onSalaryChanged: (val) {
                expensesData.salary = val;
              },
              remainingSalary: expensesData.remainingSalary,
            ),
          ),
          const SizedBox(height: 20),
          
          // List of expenses
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: expenses.length,
              itemBuilder: (ctx, i) {
                return ExpenseCard(
                  expense: expenses[i],
                  onDelete: () => expensesData.deleteExpense(expenses[i].id),
                  onUpdate: (newTitle, newDesc, newAmount, newCategory) {
  expensesData.updateExpense(expenses[i].id, newTitle, newDesc, newAmount, newCategory);
},

                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.pushNamed(context, AddExpenseScreen.routeName);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
