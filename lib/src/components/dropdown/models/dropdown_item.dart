import 'package:equatable/equatable.dart';

class ExpenseDropdownItem extends Equatable {
  final String value;
  final String label;

  const ExpenseDropdownItem(this.value, this.label);

  @override
  List<Object?> get props => [value, label];
}
