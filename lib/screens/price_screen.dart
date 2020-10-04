import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:bitcoin_ticker/coin_data.dart' as coinData;

import '../CryptoCard.dart';
import '../services/currency_converter.dart';

class PriceScreen extends StatefulWidget {
  var rateData;

  PriceScreen({this.rateData});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String rateBTC;
  String rateETH;
  String rateLTC;

  @override
  void initState() {
    updateUi(widget.rateData);
    super.initState();
  }

  Widget getIOSPicker() {
    List<Text> items = [];
    for (String currency in coinData.currenciesList) {
      var element = new Text(
        currency,
        style: TextStyle(color: Colors.white),
      );
      items.add(element);
    }

    return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          setState(() async {
            selectedCurrency = coinData.currenciesList[selectedIndex];
            for (String crypto in coinData.cryptoList) {
              var rateData = await getRateCurrencyCrypto(selectedCurrency);
              updateUi(rateData);
            }
          });
        },
        children: items);
  }

  Widget getAndroidPicker() {
    List<DropdownMenuItem<String>> items = [];
    for (String item in coinData.currenciesList) {
      items.add(new DropdownMenuItem<String>(
        child: Text(item),
        value: item,
      ));
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: items,
      onChanged: (value) async {
        var rateData = await getRateCurrencyCrypto(value);
        setState(() {
          updateUi(rateData);
          selectedCurrency = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('🤑 Coin Ticker'),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: CryptoCard(
                  crypto: 'BTC',
                  selectedCurrency: selectedCurrency,
                  rate: rateBTC,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: CryptoCard(
                  crypto: 'ETH',
                  selectedCurrency: selectedCurrency,
                  rate: rateETH,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: CryptoCard(
                  crypto: 'LTC',
                  selectedCurrency: selectedCurrency,
                  rate: rateLTC,
                ),
              ),
              Container(
                height: 80.0,
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 30.0),
                color: Colors.lightBlue,
                child: Platform.isIOS ? getIOSPicker() : getAndroidPicker(),
              ),
            ]));
  }

  void updateUi(dynamic rateData) {
    setState(() {
      rateBTC = rateData['rates'][2]['rate'].toString().split('.')[0];
      rateETH = rateData['rates'][1]['rate'].toString().split('.')[0];
      rateLTC = rateData['rates'][0]['rate'].toString().split('.')[0];
    });
  }
}
