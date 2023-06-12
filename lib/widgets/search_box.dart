import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practices/blocs/province_search_bloc/province_search_bloc.dart';

import '../blocs/location_bloc/location_bloc.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({
    super.key,
  });

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  late final FocusNode _focusnode;

  @override
  void initState() {
    context.read<ProvinceSearchBloc>().add(ProvinceSearchChanged(''));
    _focusnode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusnode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 20,
          ),
          child: TextFormField(
            key: const Key('province_search'),
            decoration: InputDecoration(
              label: const Text('ค้นหาจังหวัด'),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black54),
                borderRadius: BorderRadius.circular(25.0),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 17),
              focusColor: Theme.of(context).primaryColor,
              prefixIcon: BlocListener<LocationBloc, LocationState>(
                listener: (context, state) {
                  setState(() {});
                },
                child: Icon(
                  Icons.search,
                  color: _focusnode.hasFocus
                      ? Theme.of(context).primaryColor
                      : Colors.black54,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            focusNode: _focusnode,
            onTap: () {
              setState(() {});
            },
            onFieldSubmitted: (value) {
              setState(() {});
            },
            onChanged: (value) {
              setState(() {
                context
                    .read<ProvinceSearchBloc>()
                    .add(ProvinceSearchChanged(value));
              });
            },
          ),
        ),
        const Divider(
          height: 0,
        ),
      ],
    );
  }
}
