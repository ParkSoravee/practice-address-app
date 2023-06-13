part of 'select_province_bloc.dart';

abstract class SelectProvinceEvent extends Equatable {
  const SelectProvinceEvent();

  @override
  List<Object> get props => [];
}

class SelectProvinceSearch extends SelectProvinceEvent {
  final String text;
  const SelectProvinceSearch(this.text);
}
