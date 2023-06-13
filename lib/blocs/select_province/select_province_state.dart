part of 'select_province_bloc.dart';

abstract class SelectProvinceState extends Equatable {
  const SelectProvinceState();
}

class SelectProvinceInitial extends SelectProvinceState {
  @override
  List<Object> get props => [];
}

class SelectProvinceSearchResultState extends SelectProvinceState {
  final List<Province> results;
  const SelectProvinceSearchResultState(this.results);

  @override
  List<Object> get props => [results];
}
