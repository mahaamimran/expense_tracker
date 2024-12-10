import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expenses_provider.dart';

class AddExpenseScreen extends StatefulWidget {
  static const routeName = '/add-expense';

  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _amountController = TextEditingController();
  final _customCategoryController = TextEditingController();

  final List<String> _categories = [
    'Food',
    'Transport',
    'Utilities',
    'Entertainment',
    'Other'
  ];

  String _selectedCategory = 'Food';

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _amountController.dispose();
    _customCategoryController.dispose();
    super.dispose();
  }

  void _save() {
    final title = _titleController.text.trim();
    final desc = _descController.text.trim();
    final amount = double.tryParse(_amountController.text) ?? 0.0;

    // Determine category
    String category;
    if (_selectedCategory == 'Other') {
      final customCat = _customCategoryController.text.trim();
      category = customCat.isNotEmpty ? customCat : 'Other';
    } else {
      category = _selectedCategory;
    }

    if (title.isEmpty || amount <= 0) {
      return;
    }

    Provider.of<ExpensesProvider>(context, listen: false)
        .addExpense(title, desc, amount, category);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.number,
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Category Dropdown
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
              items: _categories
                  .map((cat) => DropdownMenuItem(
                        value: cat,
                        child: Text(cat),
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  _selectedCategory = val ?? 'Food';
                });
              },
            ),
            const SizedBox(height: 10),
            if (_selectedCategory == 'Other')
              TextField(
                controller: _customCategoryController,
                decoration: const InputDecoration(
                  labelText: 'Custom Category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
              ),
              child: const Text('Save', style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
