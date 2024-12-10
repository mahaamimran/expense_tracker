class Expense {
  final String id;
  String _title;          // private fields
  String _description;    // private fields
  double _amount;

  Expense({
    required this.id,
    required String title,
    required String description,
    required double amount,
  })  : _title = title,
        _description = description,
        _amount = amount;

  // Encapsulation: Getters/Setters
  String get title => _title;
  set title(String newTitle) => _title = newTitle;

  String get description => _description;
  set description(String newDesc) => _description = newDesc;

  double get amount => _amount;
  set amount(double newAmount) => _amount = newAmount;
}
