import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/location_bloc/location_bloc.dart';
import '../screens/screens.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black45),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, ProvinceScreen.routeName);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text('ที่อยู่ที่ติดต่อได้'),
                        Text(
                          ' *',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    BlocBuilder<LocationBloc, LocationState>(
                      builder: (context, state) {
                        final province = state.selectedProvince;
                        final amphure = state.selectedAmphure;
                        final tambon = state.selectedTambon;
                        return province != null &&
                                amphure != null &&
                                tambon != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${amphure.name} ${tambon.name}'),
                                  Text('${province.name} ${tambon.code}'),
                                ],
                              )
                            : const Text('-');
                      },
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.navigate_next,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
