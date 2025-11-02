import 'package:flutter/material.dart';

class ForecastCard extends StatelessWidget {
  final IconData icon;
  final String time;
  final String temperature;
  final String dateTime;

  const ForecastCard({
    super.key,
    required this.icon,
    required this.time,
    required this.temperature,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    final childBoxDecoration = BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(10),
    );
    return Container(
      height: 100,
      width: 100,
      decoration: childBoxDecoration,
      child: Column(
        spacing: 5,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(time, style: Theme.of(context).textTheme.bodySmall,), Icon(icon), Text(temperature), Text(dateTime.toString().split(' ')[0], style: Theme.of(context).textTheme.bodySmall,)],
      ),
    );
  }
}
