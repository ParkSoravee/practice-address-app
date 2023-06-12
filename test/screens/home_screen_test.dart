import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:practices/main.dart';
import 'package:practices/models/models.dart';
import 'package:practices/repositories/location_repository.dart';
import 'package:practices/screens/screens.dart';
import 'package:practices/widgets/widgets.dart';

// A Mock LocationRepository class
class MockLocationRepository extends Mock implements LocationRepository {}

void main() {
  final mockRepository = MockLocationRepository();

  setUp(() {
    // Set up the desired behavior of the mock
    when(() => mockRepository.getProvince).thenAnswer(
      (_) async => [
        const Province(id: '1', name: 'กรุงเทพมหานคร'),
      ],
    );
    when(() => mockRepository.getAmphureByProvinceId('1')).thenAnswer(
      (_) async => [
        const Amphure(id: '10', name: 'ลาดกระบัง', provinceId: '1'),
      ],
    );
    when(() => mockRepository.getTambonByAmphureId('10')).thenAnswer(
      (_) async => [
        const Tambon(
            id: '100', name: 'ลาดกระบัง', amphureId: '10', code: '10520'),
      ],
    );
  });

  testWidgets('title is "ที่อยู่"', (tester) async {
    // Build app
    await tester.pumpWidget(
      MyApp(
        locationRepository: mockRepository,
      ),
    );
    // verify appbar title
    expect(find.text('ที่อยู่'), findsOneWidget);
  });

  testWidgets('address box exist and start with no address', (tester) async {
    // Build app
    await tester.pumpWidget(
      MyApp(
        locationRepository: mockRepository,
      ),
    );
    // verify appbar title
    expect(find.text('ที่อยู่'), findsOneWidget);
    expect(find.text('ที่อยู่ที่ติดต่อได้'), findsOneWidget);
    expect(find.text('-'), findsOneWidget);
  });

  testWidgets('address box can tap and navigate', (tester) async {
    // Build app
    await tester.pumpWidget(
      MyApp(
        locationRepository: mockRepository,
      ),
    );
    // Tap '>' icon to select address, start with province
    await tester.tap(find.byIcon(Icons.navigate_next));
    await tester.pumpAndSettle();
    expect(find.text('จังหวัด'), findsOneWidget);
  });
}
