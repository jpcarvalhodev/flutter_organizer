import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final int ratinglvl;

  const Rating({super.key, required this.ratinglvl});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          Icons.star,
          size: 15,
          color: getColor(index + 1),
        );
      }),
    );
  }

  Color getColor(int starNumber) {
    if (starNumber > ratinglvl) {
      return Colors.grey;
    } else {
      switch (starNumber) {
        case 1:
          return Colors.green;
        case 2:
          return Colors.blue;
        case 3:
          return Colors.yellow;
        case 4:
          return Colors.orange;
        case 5:
          return Colors.red;
        default:
          return Colors.grey;
      }
    }
  }
}