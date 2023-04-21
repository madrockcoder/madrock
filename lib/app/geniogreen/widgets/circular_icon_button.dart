import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color iconColor;
  const CircularIconButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
    this.iconColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(35),
          onTap: () {},
          child: CircleAvatar(
            minRadius: 35,
            backgroundColor: color,
            child: Icon(
              icon,
              size: 32,
              color: iconColor,
            ),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium,
        )
      ],
    );
  }
}
