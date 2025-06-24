import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loop/di/injection_config.dart';
import 'package:loop/router/router.dart';
import 'package:loop/router/router.gr.dart';
import 'package:loop/services/esewa/esewa_services.dart';
import 'package:loop/services/esewa/models/esewa_config.dart';
import 'package:loop/services/esewa/models/esewa_payment.dart';

@RoutePage(name: 'PaymentRoute')
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final EsewaService esewaService = EsewaService(config: EsewaConfig.test);
  final TextEditingController amountController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('eSewa Payment Demo'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Enter Payment Amount',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount (NPR)',
                border: OutlineInputBorder(),
                prefixText: 'Rs. ',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: isLoading ? null : _initiatePayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'Pay with eSewa',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _handlePaymentResult(Map<String, dynamic> result) {
    Navigator.pop(context);

    if (result['success'] == true) {
      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Payment Successful'),
          content: Text(
            'Transaction ID: ${result['transactionId']}\n'
            'Amount: Rs. ${result['amount']}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Payment Failed'),
          content:
              Text(result['error']?.toString() ?? 'Unknown error occurred'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _initiatePayment() async {
    if (amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter amount')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final amount = double.tryParse(amountController.text) ?? 0;
    final productId = DateTime.now().millisecondsSinceEpoch.toString();

    final result = await esewaService.initiatePayment(
      productId: productId,
      productName: 'Test Product',
      productCode: 'EPAYTEST',
      amount: amount,
      successUrl: 'https://your-backend.com/payment/success',
      failureUrl: 'https://your-backend.com/payment/failure',
    );

    setState(() {
      isLoading = false;
    });

    if (result['success'] == true) {
      // await Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => EsewaPaymentWidget(
      //       payment: result['payment'] as EsewaPayment,
      //       paymentUrl: result['paymentUrl'] as String,
      //       onPaymentResult: _handlePaymentResult,
      //     ),
      //   ),
      // );

      log(result.toString());

      await getIt<AppRouter>().push(
        EsewaPaymentRoute(
          payment: result['payment'] as EsewaPayment,
          paymentUrl: result['paymentUrl'] as String,
          onPaymentResult: _handlePaymentResult,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${result['error']}')),
      );
    }
  }
}
