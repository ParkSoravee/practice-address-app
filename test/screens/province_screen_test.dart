import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:practices/blocs/location_bloc/location_bloc.dart';
import 'package:practices/blocs/province_search_bloc/province_search_bloc.dart';
import 'package:practices/config/app_route.dart';
import 'package:practices/models/models.dart';
import 'package:practices/repositories/location_repository.dart';
import 'package:practices/screens/screens.dart';

// A Mock LocationRepository class
class MockLocationRepository extends Mock implements LocationRepository {}

// class MockProvinceSearchBloc
//     extends MockBloc<ProvinceSearchEvent, ProvinceSearchState>
//     implements ProvinceSearchBloc {}

// class MockLocationBloc extends MockBloc<LocationEvent, LocationState>
//     implements LocationBloc {}

void main() {
  group('ProvinceScreen', () {
    late LocationRepository locationRepository;
    late ProvinceSearchBloc provinceSearchBloc;
    late LocationBloc locationBloc;

    setUp(() {
      locationRepository = MockLocationRepository();
      provinceSearchBloc = ProvinceSearchBloc();
      locationBloc = LocationBloc(locationRepository: locationRepository)
        ..add(const LocationProvinceLoaded());
      // Set up the desired behavior of the mock
      when(() => locationRepository.getProvince).thenAnswer(
        (_) async => [
          const Province(id: '1', name: 'กรุงเทพมหานคร'),
        ],
      );
      when(() => locationRepository.getAmphureByProvinceId('1')).thenAnswer(
        (_) async => [
          const Amphure(id: '10', name: 'ลาดกระบัง', provinceId: '1'),
        ],
      );
      when(() => locationRepository.getTambonByAmphureId('10')).thenAnswer(
        (_) async => [
          const Tambon(
              id: '100', name: 'ลาดกระบัง', amphureId: '10', code: '10520'),
        ],
      );
    });

    tearDown(() {
      locationBloc.close();
      provinceSearchBloc.close();
    });

    testWidgets('title is "จังหวัด"', (tester) async {
      // Build app
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: locationRepository,
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: provinceSearchBloc,
              ),
              BlocProvider.value(
                value: locationBloc,
              ),
            ],
            child: const MaterialApp(
              home: ProvinceScreen(),
            ),
          ),
        ),
      );
      // verify appbar title
      expect(find.text('จังหวัด'), findsOneWidget);
    });

    testWidgets('display province list', (tester) async {
      // Build app
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: locationRepository,
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: provinceSearchBloc,
              ),
              BlocProvider.value(
                value: locationBloc,
              ),
            ],
            child: const MaterialApp(
              home: ProvinceScreen(),
            ),
          ),
        ),
      );
      expect(find.text('กรุงเทพมหานคร'), findsOneWidget);
    });

    testWidgets('province can select then navigate to amphure screen',
        (tester) async {
      await tester.runAsync(() async {
        // Build app
        await tester.pumpWidget(
          RepositoryProvider.value(
            value: locationRepository,
            child: MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: provinceSearchBloc,
                ),
                BlocProvider.value(
                  value: locationBloc,
                ),
              ],
              child: MaterialApp(
                onGenerateRoute: AppRoute().onGenerateRoute,
                home: const ProvinceScreen(),
              ),
            ),
          ),
        );
        // Tap province
        final provinceButton = find.text('กรุงเทพมหานคร');
        await tester.tap(provinceButton);
        await tester.pumpAndSettle();
        expect(find.text('อำเภอ'), findsOneWidget);
        // expect(find.byType(AmphureScreen), findsOneWidget);
      });
    });

    testWidgets('display search', (tester) async {
      // Build app
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: locationRepository,
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: provinceSearchBloc,
              ),
              BlocProvider.value(
                value: locationBloc,
              ),
            ],
            child: const MaterialApp(
              home: ProvinceScreen(),
            ),
          ),
        ),
      );
      expect(find.byKey(const Key('province_search')), findsOneWidget);
    });

    testWidgets('search valid province', (tester) async {
      // Build app
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: locationRepository,
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: provinceSearchBloc,
              ),
              BlocProvider.value(
                value: locationBloc,
              ),
            ],
            child: MaterialApp(
              onGenerateRoute: AppRoute().onGenerateRoute,
              home: const ProvinceScreen(),
            ),
          ),
        ),
      );

      // verify label in TextFeild text
      final searchBox = find.byType(TextFormField);
      expect(find.text('ค้นหาจังหวัด'), findsOneWidget);

      // search valid province in search box
      await tester.enterText(searchBox, 'กรุงเทพมหานคร');
      await tester.pump();
      expect(find.text('กรุงเทพมหานคร'), findsNWidgets(2));
    });
  });
}
