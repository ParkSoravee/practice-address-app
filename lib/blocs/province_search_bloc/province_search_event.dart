part of 'province_search_bloc.dart';

abstract class ProvinceSearchEvent extends Equatable {
  const ProvinceSearchEvent();
}

class ProvinceSearchChanged extends ProvinceSearchEvent {
  final String str;

  const ProvinceSearchChanged(this.str);

  @override
  List<Object?> get props => [str];
}
