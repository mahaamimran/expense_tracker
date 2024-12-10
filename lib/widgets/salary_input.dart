import 'package:flutter/material.dart';

class SalaryInput extends StatelessWidget {
  final double initialSalary;
  final double remainingSalary;
  final ValueChanged<double> onSalaryChanged;

  const SalaryInput({
    super.key,
    required this.initialSalary,
    required this.remainingSalary,
    required this.onSalaryChanged,
  });

  @override
  Widget build(BuildContext context) {
    final salaryController = TextEditingController(text: initialSalary.toString());
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: salaryController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Monthly Salary',
              ),
              onSubmitted: (val) {
                final newVal = double.tryParse(val) ?? 0.0;
                onSalaryChanged(newVal);
              },
            ),
            const SizedBox(height: 10),
            Text(
              'Remaining: \$${remainingSalary.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
