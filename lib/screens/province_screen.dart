import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practices/blocs/location_bloc/location_bloc.dart';
import 'package:practices/screens/screens.dart';

import '../blocs/province_search_bloc/province_search_bloc.dart';
import '../widgets/widgets.dart';

class ProvinceScreen extends StatefulWidget {
  const ProvinceScreen({super.key});

  static const routeName = '/province';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ProvinceScreen(),
    );
  }

  @override
  State<ProvinceScreen> createState() => _ProvinceScreenState();
}

class _ProvinceScreenState extends State<ProvinceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text('จังหวัด'),
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
          // searchbox
          const SearchBox(),
          // list
          Expanded(
            child: BlocBuilder<LocationBloc, LocationState>(
              buildWhen: (previous, current) =>
                  previous.provinceList != current.provinceList,
              builder: (_, state) {
                return BlocBuilder<ProvinceSearchBloc, ProvinceSearchState>(
                  builder: (_, provinceSearchState) {
                    final provinceList = state.provinceList
                        .where((element) =>
                            element.name.contains(provinceSearchState.str))
                        .toList();
                    return provinceList.isNotEmpty
                        ? ListView.separated(
                            itemCount: provinceList.length,
                            // padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemBuilder: (context, index) => ListTile(
                              title: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Text(provinceList[index].name),
                              ),
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                context.read<LocationBloc>().add(
                                      LocationChanged(
                                        selectedProvince: provinceList[index],
                                      ),
                                    );
                                Navigator.pushNamed(
                                    context, AmphureScreen.routeName);
                              },
                            ),
                            separatorBuilder: (context, index) {
                              return const Divider(
                                height: 0,
                                indent: 16,
                              );
                            },
                          )
                        : const Center(
                            child: Text('empty'),
                          );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
