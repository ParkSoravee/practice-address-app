import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/bloc_observer.dart';
import 'blocs/location_bloc/location_bloc.dart';
import 'blocs/province_search_bloc/province_search_bloc.dart';
import 'blocs/select_province/select_province_bloc.dart';
import 'config/app_route.dart';
import 'config/theme.dart';
import 'repositories/location_repository.dart';
import 'screens/screens.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp(
    locationRepository: LocationRepository(),
  ));
}

class MyApp extends StatelessWidget {
  final LocationRepository locationRepository;
  const MyApp({required this.locationRepository, super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: (_) => locationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => LocationBloc(locationRepository: locationRepository)
              ..add(const LocationProvinceLoaded()),
          ),
          BlocProvider(
            create: (_) => SelectProvinceBloc(locationRepository),
          ),
        ],
        child: const MyAppView(),
      ),
    );
  }
}

class MyAppView extends StatelessWidget {
  const MyAppView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppRoute().onGenerateRoute,
      title: 'Address App',
      theme: theme(),
      home: const HomeScreen(),
    );
  }
}
