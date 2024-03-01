import 'package:flutter/material.dart';

class Rating extends StatelessWidget {

  final int ratinglvl;

  const Rating({super.key, required this.ratinglvl});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          size: 15,
          color: (ratinglvl == 1)
              ? Colors.green
              : Colors.grey,
        ),
        Icon(
          Icons.star,
          size: 15,
          color: (ratinglvl == 2)
              ? Colors.blue
              : Colors.grey,
        ),
        Icon(
          Icons.star,
          size: 15,
          color: (ratinglvl == 3)
              ? Colors.yellow
              : Colors.grey,
        ),
        Icon(
          Icons.star,
          size: 15,
          color: (ratinglvl == 4)
              ? Colors.orange
              : Colors.grey,
        ),
        Icon(
          Icons.star,
          size: 15,
          color: (ratinglvl == 5)
              ? Colors.red
              : Colors.grey,
        ),
      ],
    );
  }
}