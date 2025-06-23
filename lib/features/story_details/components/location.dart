import 'package:flutter/material.dart';

class Location extends StatelessWidget {
  const Location(this.location, {super.key});

  final String location;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.location_on, size: 16.0, color: Colors.grey),
        const SizedBox(width: 4.0),
        Text(
          location,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
