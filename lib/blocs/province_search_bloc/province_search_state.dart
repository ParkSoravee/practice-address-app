// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'province_search_bloc.dart';

class ProvinceSearchState extends Equatable {
  final String str;

  const ProvinceSearchState({this.str = ''});

  @override
  List<Object> get props => [str];

  ProvinceSearchState copyWith({
    String? str,
  }) {
    return ProvinceSearchState(
      str: str ?? this.str,
    );
  }
}

// class ProvinceSearchInitial extends ProvinceSearchState {}

// class ProvinceSearching extends ProvinceSearchState {
//   final String str;

//   const ProvinceSearching({this.str = ''});

//   @override
//   List<Object> get props => [str];
// }
