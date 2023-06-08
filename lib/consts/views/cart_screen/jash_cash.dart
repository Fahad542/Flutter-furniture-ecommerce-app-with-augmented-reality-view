import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jazzcash_flutter/jazzcash_flutter.dart';
import 'package:mart/consts/views/cart_screen/shiping_screen.dart';

import '../../../widgets_common/our_button.dart';
import '../../colors.dart';
import 'package:pay/pay.dart';

class jash_cash extends StatefulWidget {
  const jash_cash({super.key});

  @override
  State<jash_cash> createState() => _nameState();
}

class _nameState extends State<jash_cash> {
  var _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    )
  ];
// In your Stateless Widget class or State
  void onGooglePayResult(paymentResult) {
    // Send the resulting Google Pay token to your server or PSP
  }

  @override
  Widget build(BuildContext context) {
    return GooglePayButton(
      paymentConfigurationAsset: 'sample_payment_configuration.json',
      paymentItems: _paymentItems,
      type: GooglePayButtonType.pay,
      onPaymentResult: onGooglePayResult,
    );
  }
}
