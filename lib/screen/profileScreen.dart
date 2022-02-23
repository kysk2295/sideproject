import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ex0205/screen/imageFullScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProfileScreenState();
  }

}

class _ProfileScreenState extends State<ProfileScreen> {

var url = 'https://us-central1-project-1448894476953307608.cloudfunctions.net/paypalPayment';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Pay'),
          onPressed: () async {
            var request = BraintreeDropInRequest(
              tokenizationKey: 'sandbox_24j893xd_69gmvkphhfxpf5jg',
              collectDeviceData: true,
              paypalRequest: BraintreePayPalRequest(
                amount: '1.00',
                displayName: 'YUNSEO KO'
              ),
              cardEnabled: true
            );

            BraintreeDropInResult? result = await BraintreeDropIn.start(request);
            if(result!=null){
              print(result.paymentMethodNonce.description);
              print(result.paymentMethodNonce.nonce);

              final http.Response response =
                  await http.post(Uri.parse(
                    '$url?payment_method_nonce=${result.paymentMethodNonce.nonce}&device_data=${result.deviceData}'
                  ));
              
              final payResult = jsonDecode(response.body);
              print(payResult);
              if(payResult['result']=='success') print('payment done');
            }
            else {
              result.printError();
            }
          },
        ),
      )
    );
  }
}