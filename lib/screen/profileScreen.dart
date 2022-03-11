import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'loginScreen.dart';

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center
        ,children: [ Center(
          child: ElevatedButton(
            child: Text('Pay'),
            onPressed: () async {
              var request = BraintreeDropInRequest(
                tokenizationKey: 'sandbox_zjtjy28c_69gmvkphhfxpf5jg',
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
        ),
              Center(
              child: ElevatedButton(
              child: Text('로그아웃'),
          onPressed: (){
          _logout();
    //Get.off(LoginScreen());
    },
    ),
              )
    ]
      )
    );
  }
}

Future<String> _logout() async{

  var flag='fail';
  final prefs = await SharedPreferences.getInstance();
  print(prefs.getStringList('info')![0]);
  if(prefs.getStringList('info')!.isNotEmpty){
    var res = await http.post(
      Uri.parse('http://192.168.45.52:3000/logout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email':prefs.getStringList('info')![0],
        'password':prefs.getStringList('info')![1],
      }),
    ).catchError((error){
      print(error);
      flag='fail';
    });

    if(res.statusCode==302){
      print('로그아웃 성공');
      flag='success';
      //sharedpreference 지워주기
      prefs.remove('info');
      print('제거완료');
      Get.off(LoginScreen());
    }
    else {
      print('로그인 실패');
      flag='fail';

    }
  }
  else {
    print('로그인 실패2');
    flag='fail';
  }

  return flag;
}