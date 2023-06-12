import 'package:practices/blocs/location_bloc/location_bloc.dart';
import 'package:practices/blocs/province_search_bloc/province_search_bloc.dart';
import 'package:practices/models/amphure.dart';
import 'package:practices/models/province.dart';
import 'package:practices/models/tombon.dart';
import 'package:practices/repositories/location_repository.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('LocationBloc', () {
    late LocationBloc locationBloc;
    late LocationRepository locationRepository;

    setUp(() {
      locationRepository = LocationRepository();
      locationBloc = LocationBloc(locationRepository: locationRepository);
    });

    tearDown(() {
      locationBloc.close();
    });

    test('initial state is empty province list', () {
      expect(locationBloc.state.provinceList, []);
    });

    blocTest(
      'emits LocationState with non-empty provinceList when LocationProvinceLoaded event is added',
      build: () => locationBloc,
      act: (bloc) => bloc.add(const LocationProvinceLoaded()),
      wait: const Duration(seconds: 1),
      expect: () => [
        // Check that the emitted LocationState has a non-empty provinceList
        isA<LocationState>()
            .having(
              (state) => state.provinceList,
              'provinceList',
              // isNot(isEmpty),
              hasLength(77),
            )
            .having(
              (state) => state.amphureList,
              'amphureList',
              isEmpty,
            )
            .having(
              (state) => state.tambonList,
              'tambonList',
              isEmpty,
            )
            .having(
              (state) => state.selectedProvince,
              'selectedProvince',
              isNull,
            )
            .having(
              (state) => state.selectedAmphure,
              'selectedAmphure',
              isNull,
            )
            .having(
              (state) => state.selectedTambon,
              'selectedTambon',
              isNull,
            ),
      ],
    );

    blocTest(
      'emits LocationState with selectProvinces and amphureList when LocationChanged event is added with selectProvince',
      build: () => locationBloc,
      act: (bloc) => bloc.add(
        const LocationChanged(
          selectedProvince: Province(id: '2', name: 'สมุทรปราการ'),
        ),
      ),
      wait: const Duration(seconds: 1),
      expect: () => [
        isA<LocationState>()
            .having(
              (state) => state.selectedProvince,
              'selectedProvince',
              isNot(isNull),
            )
            .having(
              (state) => state.amphureList,
              'amphureList',
              isNot(isEmpty),
            )
      ],
    );

    blocTest(
      'emits LocationState with selectAmphure and tambonList when LocationChanged event is added with selectAmphure',
      build: () => locationBloc,
      act: (bloc) => bloc.add(
        const LocationChanged(
          selectedAmphure: Amphure(provinceId: '2', id: '1103', name: 'บางพลี'),
        ),
      ),
      wait: const Duration(seconds: 1),
      expect: () => [
        isA<LocationState>()
            .having(
              (state) => state.selectedAmphure,
              'selectedAmphure',
              isNot(isNull),
            )
            .having(
              (state) => state.tambonList,
              'tambonList',
              isNot(isEmpty),
            )
      ],
    );

    blocTest(
      'emits LocationState with selectTambon when LocationChanged event is added with selectTambon',
      build: () => locationBloc,
      act: (bloc) => bloc.add(
        const LocationChanged(
          selectedTambon:
              Tambon(amphureId: '1103', id: '9309', name: 'บางแก้ว', code: '1'),
        ),
      ),
      wait: const Duration(seconds: 1),
      expect: () => [
        isA<LocationState>().having(
          (state) => state.selectedTambon,
          'selectedTambon',
          isNot(isNull),
        )
      ],
    );

    blocTest(
      'emits LocationState with selectProvince, selectAmphure, SelectTambon and eachList when LocationChanged event is added with all 3 select',
      build: () => locationBloc,
      act: (bloc) async {
        bloc.add(const LocationProvinceLoaded());
        await Future.delayed(const Duration(seconds: 1));
        bloc.add(
          const LocationChanged(
            selectedProvince: Province(id: '2', name: 'สมุทรปราการ'),
          ),
        );
        await Future.delayed(const Duration(seconds: 1));
        bloc.add(
          const LocationChanged(
            selectedAmphure:
                Amphure(provinceId: '2', id: '1103', name: 'บางพลี'),
          ),
        );
        await Future.delayed(const Duration(seconds: 1));
        bloc.add(
          const LocationChanged(
            selectedTambon: Tambon(
                amphureId: '1103', id: '9309', name: 'บางแก้ว', code: '1'),
          ),
        );
      },
      wait: const Duration(seconds: 1),
      skip: 3,
      expect: () => [
        isA<LocationState>()
            .having(
              (state) => state.selectedProvince,
              'selectedProvince',
              isNot(isNull),
            )
            .having(
              (state) => state.selectedAmphure,
              'selectedAmphure',
              isNot(isNull),
            )
            .having(
              (state) => state.selectedTambon,
              'selectedTambon',
              isNot(isNull),
            )
      ],
    );
  });
}
