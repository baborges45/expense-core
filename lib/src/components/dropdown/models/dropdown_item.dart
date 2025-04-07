import 'package:equatable/equatable.dart';

class MudeDropdownItem extends Equatable {
  final String value;
  final String label;

  const MudeDropdownItem(this.value, this.label);

  @override
  List<Object?> get props => [value, label];
}
