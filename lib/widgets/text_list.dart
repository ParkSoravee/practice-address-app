import 'package:flutter/material.dart';

import '../screens/screens.dart';

class TextList extends StatelessWidget {
  final Function() onTap;

  const TextList({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: 10,
        // padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) => ListTile(
          title: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('xxx'),
          ),
          onTap: onTap,
        ),
        separatorBuilder: (context, index) {
          return const Divider(
            height: 0,
            indent: 16,
          );
        },
      ),
    );
  }
}
