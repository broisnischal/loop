import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:loop/services/esewa/models/esewa_config.dart';
import 'package:loop/services/esewa/models/esewa_payment.dart';
import 'package:webview_flutter/webview_flutter.dart';

@RoutePage(name: 'EsewaPaymentRoute')
class EsewaPaymentWidget extends StatefulWidget {
  const EsewaPaymentWidget({
    required this.payment,
    required this.paymentUrl,
    required this.onPaymentResult,
    super.key,
  });
  final EsewaPayment payment;
  final String paymentUrl;

  final Function(Map<String, dynamic>) onPaymentResult;

  @override
  State<EsewaPaymentWidget> createState() => _EsewaPaymentWidgetState();
}

class _EsewaPaymentWidgetState extends State<EsewaPaymentWidget> {
  late final WebViewController controller;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('eSewa Payment'),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  String _generatePaymentForm(Map<String, String> formData) {
    final formFields = formData.entries
        .map((e) => '<input type="hidden" name="${e.key}" value="${e.value}">')
        .join('\n');

    return '''
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>eSewa Payment</title>
    </head>
    <body>
        <form id="paymentForm" action="${widget.paymentUrl}" method="POST">
            $formFields
        </form>
        <script>
            document.getElementById('paymentForm').submit();
        </script>
    </body>
    </html>
    ''';
  }

  void _initializeWebView() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });

            if (url.contains(widget.payment.successUrl)) {
              final uri = Uri.parse(url);
              widget.onPaymentResult({
                'success': true,
                'transactionId': uri.queryParameters['refId'],
                'productId': uri.queryParameters['oid'],
                'amount': uri.queryParameters['amt'],
              });
            } else if (url.contains(widget.payment.failureUrl)) {
              widget.onPaymentResult({
                'success': false,
                'error': 'Payment failed or cancelled',
              });
            }
          },
        ),
      );

    _loadPaymentForm();
  }

  void _loadPaymentForm() {
    final formData = widget.payment.toMap(EsewaConfig.test.merchantId);
    formData['signature'] = widget.payment.signature;

    final htmlContent = _generatePaymentForm(formData);
    controller.loadHtmlString(htmlContent);
  }
}
