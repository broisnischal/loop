import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:loop/services/esewa/models/esewa_config.dart';
import 'package:loop/services/esewa/models/esewa_payment.dart';

class EsewaService {
  EsewaService({required this.config});

  final EsewaConfig config;

  String generateSignature(EsewaPayment payment) {
    final message = 'total_amount=${payment.totalAmount},'
        'transaction_uuid=${payment.productId},'
        'product_code=${config.merchantId}';

    final key = utf8.encode(config.secretKey);
    final bytes = utf8.encode(message);
    final hmacSha256 = Hmac(sha256, key);
    final digest = hmacSha256.convert(bytes);

    return base64.encode(digest.bytes);
  }

  Future<Map<String, dynamic>> initiatePayment({
    required String productId,
    required String productName,
    required double amount,
    required String successUrl,
    required String failureUrl,
  }) async {
    try {
      final payment = EsewaPayment(
        productId: productId,
        productName: productName,
        totalAmount: amount,
        productPrice: amount,
        productServiceCharge: 0,
        productDeliveryCharge: 0,
        taxAmount: 0,
        successUrl: successUrl,
        failureUrl: failureUrl,
        signedFieldNames: 'total_amount,transaction_uuid,product_code',
        signature: '',
      );

      final signature = generateSignature(payment);
      final updatedPayment = EsewaPayment(
        productId: payment.productId,
        productName: payment.productName,
        totalAmount: payment.totalAmount,
        productPrice: payment.productPrice,
        productServiceCharge: payment.productServiceCharge,
        productDeliveryCharge: payment.productDeliveryCharge,
        taxAmount: payment.taxAmount,
        successUrl: payment.successUrl,
        failureUrl: payment.failureUrl,
        signedFieldNames: payment.signedFieldNames,
        signature: signature,
      );

      return {
        'success': true,
        'payment': updatedPayment,
        'paymentUrl': config.baseUrl,
      };
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> verifyPayment({
    required String transactionId,
    required String productId,
    required double totalAmount,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('${config.baseUrl}/transaction/$transactionId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'success': true,
          'data': data,
        };
      } else {
        return {
          'success': false,
          'error': 'Failed to verify payment',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }
}
