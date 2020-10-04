import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key key,
    @required this.crypto,
    @required this.selectedCurrency,
    @required this.rate,
  }) : super(key: key);

  final String selectedCurrency;
  final String crypto;
  final String rate;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $crypto = $rate $selectedCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
