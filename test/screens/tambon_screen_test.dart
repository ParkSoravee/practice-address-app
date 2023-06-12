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
  group('TambonScreen', () {
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
        )
        ..add(
          const LocationChanged(
            selectedAmphure:
                Amphure(id: '10', name: 'เขตลาดกระบัง', provinceId: '1'),
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

    testWidgets('title is "ตำบล"', (tester) async {
      // Build app
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: locationRepository,
          child: BlocProvider.value(
            value: locationBloc,
            child: const MaterialApp(
              home: TambonScreen(),
            ),
          ),
        ),
      );
      // verify appbar title
      expect(find.text('ตำบล'), findsOneWidget);
    });

    testWidgets('display tambon list', (tester) async {
      await tester.runAsync(() async {
        // Build app
        await tester.pumpWidget(
          RepositoryProvider.value(
            value: locationRepository,
            child: BlocProvider.value(
              value: locationBloc,
              child: const MaterialApp(
                home: TambonScreen(),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text('แขวงลาดกระบัง'), findsOneWidget);
      });
    });

    testWidgets('tambon can select then navigate to home screen',
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
                home: const TambonScreen(),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        // Tap tambon
        final tambonButton = find.text('แขวงลาดกระบัง');
        await tester.tap(tambonButton);
        await tester.pumpAndSettle();
        expect(find.text('ที่อยู่'), findsOneWidget);
      });
    });
  });
}
