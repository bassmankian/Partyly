import 'package:flutter/material.dart';
import 'package:partyly_app/common/app_colors.dart';

class CategoryBar extends StatelessWidget {
  const CategoryBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _CategoryButton(icon: Icons.mic, label: 'Live Music'),
          _CategoryButton(icon: Icons.celebration, label: 'Clubs'),
          _CategoryButton(icon: Icons.landscape, label: 'Outdoor'),
          _CategoryButton(icon: Icons.headphones, label: 'Electronic'),
          _CategoryButton(
              icon: Icons.mic, label: 'Electronic'), // Duplicate icon as shown
        ],
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _CategoryButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: containerColor, // Dark background
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            padding: const EdgeInsets.all(16.0),
          ),
          onPressed: () {
            // Handle button press (e.g., navigate to category page)
          },
          child: Icon(
            icon,
            color: textColor,
            size: 32.0,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: textColor, fontSize: 12),
        ),
      ],
    );
  }
}
