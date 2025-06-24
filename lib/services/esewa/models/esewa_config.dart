class EsewaConfig {
  const EsewaConfig({
    required this.merchantId,
    required this.secretKey,
    required this.baseUrl,
  });
  // Test credentials
  static const EsewaConfig test = EsewaConfig(
    merchantId: 'EPAYTEST',
    secretKey: '8gBm/:&EnhH.1/q',
    baseUrl: 'https://rc-epay.esewa.com.np/api/epay/main/v2/form',
  );
  // Production credentials
  static const EsewaConfig production = EsewaConfig(
    merchantId: 'EPAYTEST',
    secretKey: '8gBm/:&EnhH.1/q',
    baseUrl: 'https://rc-epay.esewa.com.np/api/epay/main/v2/form',
  );

// https://rc-epay.esewa.com.np/api/epay/main/v2/form"

  final String merchantId;

  final String secretKey;

  final String baseUrl;
}
