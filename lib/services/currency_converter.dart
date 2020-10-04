import 'package:http/http.dart' as http;

import 'Networking.dart';

final String APIKEY = 'A2E36D2A-0AEE-4764-96A9-032ADB21D72E';

Future<dynamic> getRateCurrencyCrypto(
  String currency,
) async {
  NetworkingHelper networkingHelper = NetworkingHelper(
      'https://rest.coinapi.io/v1/exchangerate/$currency?apikey=$APIKEY&filter_asset_id=BTC,ETH,LTC&invert=true');
  return await networkingHelper.getData();
}
