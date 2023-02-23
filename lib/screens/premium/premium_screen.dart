import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:layover/config/theme.dart';
import 'package:pay/pay.dart';
import 'payment_configurations.dart' as payment_configurations;
import '../../blocs/profile/profile_bloc.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({Key? key}) : super(key: key);

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
  static const String routeName = '/premium';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const PremiumScreen(),
    );
  }
}

List<PaymentItem> get paymentItems {
  const _paymentItems = [
    (PaymentItem(
        amount: '5.99', label: 'Total', status: PaymentItemStatus.final_price))
  ];

  return _paymentItems;
}

class _PremiumScreenState extends State<PremiumScreen> {
  late final Future<PaymentConfiguration> _googlePayConfigFuture;

  @override
  void initState() {
    super.initState();
    _googlePayConfigFuture =
        PaymentConfiguration.fromAsset('google_pay_config.json');
  }

  void onGooglePayResult(dynamic paymentResult) {
    debugPrint(paymentResult.toString());
  }

  void onApplePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is ProfileLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is ProfileLoaded) {
        return Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomLeft,
                  colors: [
                Color.fromARGB(255, 72, 163, 237),
                Color.fromARGB(255, 220, 239, 255)
              ])),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: (Get.context!.height / (Get.context!.height / 88))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: (Get.context!.width /
                                      (Get.context!.width / 58))),
                              child: Text(
                                'Get Premium',
                                style: theme().textTheme.headline1!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: (Get.context!.width /
                                      (Get.context!.width / 38)),
                                  bottom: (Get.context!.height /
                                      (Get.context!.height / 40))),
                              child: FloatingActionButton(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.clear,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          'Get Lifetime Access To All Features of This App',
                          style: theme().textTheme.headline4!.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: (Get.context!.height / (Get.context!.height / 80)),
                  ),
                  SvgPicture.asset('assets/images/pay.svg',
                      height:
                          (Get.context!.height / (Get.context!.height / 200))),
                  SizedBox(
                    height: (Get.context!.height / (Get.context!.height / 90)),
                  ),
                  Text(
                    '\$5.99',
                    style: theme().textTheme.headline1!.copyWith(
                        color: const Color.fromARGB(255, 21, 22, 52),
                        fontWeight: FontWeight.w500,
                        fontSize: 50),
                  ),
                  Text(
                    '∞ Monthly Plan ∞',
                    style: theme().textTheme.headline1!.copyWith(
                        color: const Color.fromARGB(255, 21, 22, 52),
                        fontWeight: FontWeight.w500,
                        fontSize: 22),
                  ),
                  SizedBox(
                    height: (Get.context!.height / (Get.context!.height / 10)),
                  ),
                  Center(
                    child: Column(
                      children: [
                        FutureBuilder<PaymentConfiguration>(
                            future: _googlePayConfigFuture,
                            builder: (context, snapshot) => snapshot.hasData
                                ? GooglePayButton(
                                    paymentConfiguration: snapshot.data!,
                                    paymentItems: paymentItems,
                                    type: GooglePayButtonType.pay,
                                    width: (Get.context!.width /
                                        (Get.context!.width / 300)),
                                    margin: EdgeInsets.only(
                                        top: (Get.context!.height /
                                            (Get.context!.height / 35))),
                                    onPaymentResult: onGooglePayResult,
                                    loadingIndicator: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : const SizedBox.shrink()),
                        ApplePayButton(
                          paymentConfiguration:
                              PaymentConfiguration.fromJsonString(
                                  payment_configurations.defaultApplePay),
                          paymentItems: paymentItems,
                          style: ApplePayButtonStyle.black,
                          type: ApplePayButtonType.buy,
                          margin: const EdgeInsets.only(top: 15.0),
                          onPaymentResult: onApplePayResult,
                          loadingIndicator: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                            height: (Get.context!.height /
                                (Get.context!.height / 15)))
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        );
      } else {
        return Text('');
      }
    }));
  }
}
