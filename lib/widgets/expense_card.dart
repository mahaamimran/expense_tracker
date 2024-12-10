import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  final VoidCallback onDelete;
  // Updated the onUpdate function signature to include category
  final Function(String, String, double, String) onUpdate;

  const ExpenseCard({
    super.key,
    required this.expense,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: expense.title);
    final descController = TextEditingController(text: expense.description);
    final amountController = TextEditingController(text: expense.amount.toString());
    final categoryController = TextEditingController(); // For custom category when 'Other' is selected

    final List<String> categories = [
      'Food',
      'Transport',
      'Utilities',
      'Entertainment',
      'Other'
    ];

    // Determine the initial selected category
    String selectedCategory = categories.contains(expense.category) 
        ? expense.category 
        : 'Other';

    if (selectedCategory == 'Other') {
      // If current category isn't in the predefined list, assume it's custom and fill the controller
      categoryController.text = expense.category;
    }

    void editExpense() {
      showDialog(
        context: context,
        builder: (ctx) => StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Edit Expense'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: descController,
                      decoration: const InputDecoration(labelText: 'Description'),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: amountController,
                      decoration: const InputDecoration(labelText: 'Amount'),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: selectedCategory,
                      decoration: const InputDecoration(labelText: 'Category'),
                      items: categories
                          .map((cat) => DropdownMenuItem(
                                value: cat,
                                child: Text(cat),
                              ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedCategory = val ?? 'Food';
                        });
                      },
                    ),
                    if (selectedCategory == 'Other') ...[
                      const SizedBox(height: 8),
                      TextField(
                        controller: categoryController,
                        decoration: const InputDecoration(labelText: 'Custom Category'),
                      ),
                    ]
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel')
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    final newTitle = titleController.text.trim();
                    final newDesc = descController.text.trim();
                    final newAmount = double.tryParse(amountController.text) ?? 0.0;

                    // Determine final category
                    String finalCategory;
                    if (selectedCategory == 'Other') {
                      final customCat = categoryController.text.trim();
                      finalCategory = customCat.isNotEmpty ? customCat : 'Other';
                    } else {
                      finalCategory = selectedCategory;
                    }

                    onUpdate(newTitle, newDesc, newAmount, finalCategory);
                    Navigator.pop(context);
                  },
                  child: const Text('Save', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        ),
      );
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          title: Text(
            expense.title, 
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${expense.description}\n\$${expense.amount.toStringAsFixed(2)}'),
              const SizedBox(height: 6),
              // Category Chip
              Wrap(
                children: [
                  Chip(
                    label: Text(
                      expense.category, 
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Theme.of(context).primaryColor.withOpacity(0.6),
                  ),
                ],
              ),
            ],
          ),
          isThreeLine: true,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blueGrey),
                onPressed: editExpense,
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
