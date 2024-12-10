class Expense {
  final String id;
  String _title;          
  String _description;    
  double _amount;
  String _category;

  Expense({
    required this.id,
    required String title,
    required String description,
    required double amount,
    required String category,
  })  : _title = title,
        _description = description,
        _amount = amount,
        _category = category;

  // Encapsulation: Getters/Setters
  String get title => _title;
  set title(String newTitle) => _title = newTitle;

  String get description => _description;
  set description(String newDesc) => _description = newDesc;

  double get amount => _amount;
  set amount(double newAmount) => _amount = newAmount;

  String get category => _category;
  set category(String newCategory) => _category = newCategory;
}
