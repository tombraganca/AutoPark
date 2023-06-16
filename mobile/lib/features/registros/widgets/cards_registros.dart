import 'package:flutter/material.dart';

class CardRegistros extends StatelessWidget {
  final String title;
  final String placa;
  final String date;
  const CardRegistros({
    super.key,
    required this.title,
    required this.placa,
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
            width: MediaQuery.sizeOf(context).width * 0.10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  title == 'Entrada'
                      ? Icons.arrow_upward
                      : Icons.arrow_downward,
                  color: title == 'Entrada' ? Colors.green : Colors.red,
                )
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Text(placa),
                Text(date),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
