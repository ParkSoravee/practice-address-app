// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'location_bloc.dart';

class LocationState extends Equatable {
  const LocationState({
    this.selectedProvince,
    this.selectedAmphure,
    this.selectedTambon,
    this.provinceList = const [],
    this.amphureList = const [],
    this.tambonList = const [],
  });

  final Province? selectedProvince;
  final Amphure? selectedAmphure;
  final Tambon? selectedTambon;

  final List<Province> provinceList;
  final List<Amphure> amphureList;
  final List<Tambon> tambonList;

  LocationState copyWith({
    Province? selectedProvince,
    Amphure? selectedAmphure,
    Tambon? selectedTambon,
    List<Province>? provinceList,
    List<Amphure>? amphureList,
    List<Tambon>? tambonList,
  }) {
    return LocationState(
      selectedProvince: selectedProvince ?? this.selectedProvince,
      selectedAmphure: selectedAmphure ?? this.selectedAmphure,
      selectedTambon: selectedTambon ?? this.selectedTambon,
      provinceList: provinceList ?? this.provinceList,
      amphureList: amphureList ?? this.amphureList,
      tambonList: tambonList ?? this.tambonList,
    );
  }

  @override
  List<Object?> get props => [
        selectedProvince,
        selectedAmphure,
        selectedTambon,
        provinceList,
        amphureList,
        tambonList
      ];
}
