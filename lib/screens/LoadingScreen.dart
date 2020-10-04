import 'package:bitcoin_ticker/screens/price_screen.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/services/currency_converter.dart' as converter;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getRateData() async {
    var rateData = await converter.getRateCurrencyCrypto('USD');

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PriceScreen(
        rateData: rateData,
      );
    }));
  }

  @override
  void initState() {
    getRateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
        ),
      ),
    );
  }
}
