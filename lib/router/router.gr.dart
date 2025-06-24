// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i6;
import 'package:loop/features/index/presentation/screens/home.dart' as _i2;
import 'package:loop/features/test/presentation/screens/payment.dart' as _i3;
import 'package:loop/services/esewa/models/esewa_payment.dart' as _i5;
import 'package:loop/services/esewa/widget/esewa_payment_widget.dart' as _i1;

/// generated route for
/// [_i1.EsewaPaymentWidget]
class EsewaPaymentRoute extends _i4.PageRouteInfo<EsewaPaymentRouteArgs> {
  EsewaPaymentRoute({
    required _i5.EsewaPayment payment,
    required String paymentUrl,
    required dynamic Function(Map<String, dynamic>) onPaymentResult,
    _i6.Key? key,
    List<_i4.PageRouteInfo>? children,
  }) : super(
         EsewaPaymentRoute.name,
         args: EsewaPaymentRouteArgs(
           payment: payment,
           paymentUrl: paymentUrl,
           onPaymentResult: onPaymentResult,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'EsewaPaymentRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EsewaPaymentRouteArgs>();
      return _i1.EsewaPaymentWidget(
        payment: args.payment,
        paymentUrl: args.paymentUrl,
        onPaymentResult: args.onPaymentResult,
        key: args.key,
      );
    },
  );
}

class EsewaPaymentRouteArgs {
  const EsewaPaymentRouteArgs({
    required this.payment,
    required this.paymentUrl,
    required this.onPaymentResult,
    this.key,
  });

  final _i5.EsewaPayment payment;

  final String paymentUrl;

  final dynamic Function(Map<String, dynamic>) onPaymentResult;

  final _i6.Key? key;

  @override
  String toString() {
    return 'EsewaPaymentRouteArgs{payment: $payment, paymentUrl: $paymentUrl, onPaymentResult: $onPaymentResult, key: $key}';
  }
}

/// generated route for
/// [_i2.HomeScreen]
class HomePageRoute extends _i4.PageRouteInfo<void> {
  const HomePageRoute({List<_i4.PageRouteInfo>? children})
    : super(HomePageRoute.name, initialChildren: children);

  static const String name = 'HomePageRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeScreen();
    },
  );
}

/// generated route for
/// [_i3.PaymentScreen]
class PaymentRoute extends _i4.PageRouteInfo<void> {
  const PaymentRoute({List<_i4.PageRouteInfo>? children})
    : super(PaymentRoute.name, initialChildren: children);

  static const String name = 'PaymentRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.PaymentScreen();
    },
  );
}
