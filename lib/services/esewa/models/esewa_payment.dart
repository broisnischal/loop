class EsewaPayment {
  EsewaPayment({
    required this.productId,
    required this.productName,
    required this.totalAmount,
    required this.productPrice,
    required this.productServiceCharge,
    required this.productDeliveryCharge,
    required this.taxAmount,
    required this.successUrl,
    required this.failureUrl,
    required this.signedFieldNames,
    required this.signature,
    required this.productCode,
  });
  final String productId;
  final String productName;
  final double totalAmount;
  final double productPrice;
  final double productServiceCharge;
  final double productDeliveryCharge;
  final double taxAmount;
  final String successUrl;
  final String failureUrl;
  final String signedFieldNames;
  final String productCode;

  final String signature;

  Map<String, String> toMap(String merchantId) {
    return {
      'amount': totalAmount.toString(),
      'failure_url': failureUrl,
      'product_delivery_charge': productDeliveryCharge.toString(),
      'product_service_charge': productServiceCharge.toString(),
      'product_code': productCode,
      'signature': signature,
      'signed_field_names': signedFieldNames,
      'success_url': successUrl,
      'tax_amount': taxAmount.toString(),
      'total_amount': totalAmount.toString(),
      'transaction_uuid': productId,
    };
  }
}
