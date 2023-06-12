import 'package:practices/blocs/location_bloc/location_bloc.dart';
import 'package:practices/blocs/province_search_bloc/province_search_bloc.dart';
import 'package:practices/models/amphure.dart';
import 'package:practices/models/province.dart';
import 'package:practices/models/tombon.dart';
import 'package:practices/repositories/location_repository.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('ProvinceSearchBloc', () {
    late ProvinceSearchBloc provinceSearchBloc;

    setUp(() {
      provinceSearchBloc = ProvinceSearchBloc();
    });

    tearDown(() {
      provinceSearchBloc.close();
    });

    blocTest(
      'emits ProvinceSearchState with str when ProvinceSearchChanged event is added',
      build: () => provinceSearchBloc,
      act: (bloc) => bloc.add(const ProvinceSearchChanged('สมุทรปราการ')),
      expect: () => [
        isA<ProvinceSearchState>().having(
          (p) => p.str,
          'str',
          'สมุทรปราการ',
        ),
      ],
    );
  });
}
