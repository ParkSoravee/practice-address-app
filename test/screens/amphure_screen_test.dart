import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:practices/blocs/location_bloc/location_bloc.dart';
import 'package:practices/config/app_route.dart';
import 'package:practices/models/models.dart';
import 'package:practices/repositories/location_repository.dart';
import 'package:practices/screens/screens.dart';

import 'home_screen_test.dart';

void main() {
  group('AmphureScreen', () {
    late LocationRepository locationRepository;
    late LocationBloc locationBloc;

    setUp(() {
      locationRepository = MockLocationRepository();
      locationBloc = LocationBloc(locationRepository: locationRepository)
        ..add(const LocationProvinceLoaded())
        ..add(
          const LocationChanged(
            selectedProvince: Province(id: '1', name: 'กรุงเทพมหานคร'),
          ),
        );
      // Set up the desired behavior of the mock
      when(() => locationRepository.getProvince).thenAnswer(
        (_) async => [
          const Province(id: '1', name: 'กรุงเทพมหานคร'),
        ],
      );
      when(() => locationRepository.getAmphureByProvinceId('1')).thenAnswer(
        (_) async => [
          const Amphure(id: '10', name: 'เขตลาดกระบัง', provinceId: '1'),
        ],
      );
      when(() => locationRepository.getTambonByAmphureId('10')).thenAnswer(
        (_) async => [
          const Tambon(
              id: '100', name: 'แขวงลาดกระบัง', amphureId: '10', code: '10520'),
        ],
      );
    });

    tearDown(() {
      locationBloc.close();
    });

    testWidgets('title is "อำเภอ"', (tester) async {
      // Build app
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: locationRepository,
          child: BlocProvider.value(
            value: locationBloc,
            child: const MaterialApp(
              home: AmphureScreen(),
            ),
          ),
        ),
      );
      // verify appbar title
      expect(find.text('อำเภอ'), findsOneWidget);
    });

    testWidgets('display amphure list', (tester) async {
      await tester.runAsync(() async {
        // Build app
        await tester.pumpWidget(
          RepositoryProvider.value(
            value: locationRepository,
            child: BlocProvider.value(
              value: locationBloc,
              child: const MaterialApp(
                home: AmphureScreen(),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text('เขตลาดกระบัง'), findsOneWidget);
      });
    });

    testWidgets('amphure can select then navigate to tambon screen',
        (tester) async {
      await tester.runAsync(() async {
        // Build app
        await tester.pumpWidget(
          RepositoryProvider.value(
            value: locationRepository,
            child: BlocProvider.value(
              value: locationBloc,
              child: MaterialApp(
                onGenerateRoute: AppRoute().onGenerateRoute,
                home: const AmphureScreen(),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        // Tap amphure
        final amphureButton = find.text('เขตลาดกระบัง');
        await tester.tap(amphureButton);
        await tester.pumpAndSettle();
        expect(find.text('ตำบล'), findsOneWidget);
      });
    });
  });
}
