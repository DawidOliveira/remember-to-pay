import 'package:flutter/material.dart';

class SectionTileWidget extends StatelessWidget {
  const SectionTileWidget({
    Key? key,
    required this.label,
    required this.icon,
  }) : super(key: key);

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          minLeadingWidth: 5,
          leading: Icon(
            icon,
          ),
          title: Text(
            label,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        Divider(
          height: 0,
        ),
      ],
    );
  }
}
