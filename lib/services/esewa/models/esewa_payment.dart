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

  final String signature;

  Map<String, String> toMap(String merchantId) {
    return {
      'tAmt': totalAmount.toString(),
      'amt': productPrice.toString(),
      'txAmt': taxAmount.toString(),
      'psc': productServiceCharge.toString(),
      'pdc': productDeliveryCharge.toString(),
      'scd': merchantId,
      'pid': productId,
      'su': successUrl,
      'fu': failureUrl,
    };
  }
}
