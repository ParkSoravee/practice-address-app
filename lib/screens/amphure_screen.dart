import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/location_bloc/location_bloc.dart';
import 'screens.dart';

class AmphureScreen extends StatelessWidget {
  const AmphureScreen({super.key});

  static const routeName = '/amphure';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const AmphureScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text('อำเภอ'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 28,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // list
          Expanded(
            child: BlocBuilder<LocationBloc, LocationState>(
              builder: (context, state) {
                
                return state.amphureList.isNotEmpty
                    ? ListView.separated(
                        itemCount: state.amphureList.length,
                        // padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemBuilder: (context, index) => ListTile(
                          title: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(state.amphureList[index].name),
                          ),
                          onTap: () {
                            context.read<LocationBloc>().add(
                                  LocationChanged(
                                    selectedAmphure: state.amphureList[index],
                                  ),
                                );
                            Navigator.pushNamed(
                                context, TambonScreen.routeName);
                          },
                        ),
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 0,
                            indent: 16,
                          );
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
