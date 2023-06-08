import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practices/blocs/location_bloc/location_bloc.dart';
import 'package:practices/blocs/province_search_bloc/province_search_bloc.dart';
import 'package:practices/config/app_route.dart';
import 'package:practices/config/theme.dart';

import 'blocs/bloc_observer.dart';
import 'repositories/location_repository.dart';
import 'screens/screens.dart';
import 'widgets/widgets.dart';

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
            create: (_) => ProvinceSearchBloc(),
          ),
        ],
        child: MaterialApp(
          onGenerateRoute: AppRoute().onGenerateRoute,
          title: 'Address App',
          theme: theme(),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
