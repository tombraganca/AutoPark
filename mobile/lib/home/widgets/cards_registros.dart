import 'package:flutter/material.dart';

class CardRegistros extends StatelessWidget {
  final String title;
  final String registro;
  final String date;
  const CardRegistros({
    super.key,
    required this.title,
    required this.registro,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [Icon(Icons.south_outlined)],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Text(registro),
                Text(date),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
