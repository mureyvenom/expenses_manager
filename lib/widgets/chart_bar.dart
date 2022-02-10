import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final num spendingAmount;
  final num spendingTotal;
  const ChartBar(this.label, this.spendingAmount, this.spendingTotal,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Text(
            'N ${spendingAmount.toStringAsFixed(0)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
              ),
              FractionallySizedBox(
                heightFactor: double.parse(spendingTotal.toString()),
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
