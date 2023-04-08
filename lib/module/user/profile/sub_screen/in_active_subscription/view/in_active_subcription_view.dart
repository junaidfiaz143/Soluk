import 'dart:io';

import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/user/profile/sub_screen/in_active_subscription/bloc/payment_method_cubit.dart';
import 'package:app/module/user/subscription/subscription.dart';
import 'package:app/module/user/widgets/top_appbar_row.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/utils/soluk_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class InActiveSubscriptionScreen extends StatefulWidget {
  @override
  _InActiveSubscriptionScreenState createState() => _InActiveSubscriptionScreenState();
}

// const _paymentItems = [
//   PaymentItem(
//     label: 'Total',
//     amount: '99.99',
//     status: PaymentItemStatus.final_price,
//   )
// ];

Widget paymentTile(
    {required BuildContext context,
    required String paymentType,
    required Function()? onPaymentTap,
    required bool isSelected}) {
  return Container(
    margin: EdgeInsets.only(top: 5, bottom: 5),
    child: InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onPaymentTap!,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: isSelected == true ? Border.all(color: Colors.blue) : Border.all(color: Color(0xFFe9e9e9)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: defaultSize.screenHeight * .1,
              width: defaultSize.screenWidth * .1,
              // child: Image.asset(APP_LOGO),
              child: SvgPicture.asset(
                'assets/svgs/$paymentType.svg'.replaceAll(" ", "_").toLowerCase(),
                height: 25,
                width: 25,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                '$paymentType',
                style: labelTextStyle(context)!.copyWith(color: isSelected == true ? Colors.blue : Colors.black),
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: isSelected == true ? Colors.blue : Colors.black,
              size: 20,
            ),
          ],
        ),
      ),
    ),
  );
}

onPaymentMethods(BuildContext _context) {
  showModalBottomSheet<void>(
    isScrollControlled: true,
    context: _context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Wrap(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
            // height: defaultSize.screenHeight * .2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Payment methods',
                  style: headingTextStyle(context),
                ),
                Text(
                  'Choose a payment method',
                  style: labelTextStyle(context),
                ),
                SizedBox(
                  height: 20,
                ),
                BlocBuilder<PaymentMethodCubit, PaymentMethod>(builder: (context, state) {
                  return SingleChildScrollView(
                    child: Column(children: [
                      paymentTile(
                          context: context,
                          paymentType: Subscription.CARD.toUpperCase().replaceAll("_", " "),
                          isSelected: state == PaymentMethod.card,
                          onPaymentTap: () {
                            context.read<PaymentMethodCubit>().onPaymentMethodChanged(Subscription.CARD);
                            // Navigator.pop(context);
                            //PAYMENT FOR SUBCRIPTION
                            // Subscription.startPayment(
                            //     paymentMethod: Subscription.CARD);
                          }),
                      if (Platform.isIOS)
                        paymentTile(
                            context: context,
                            paymentType: Subscription.APPLE_PAY.toUpperCase().replaceAll("_", " "),
                            isSelected: state == PaymentMethod.apple_pay,
                            onPaymentTap: () {
                              context.read<PaymentMethodCubit>().onPaymentMethodChanged(Subscription.APPLE_PAY);
                            }),
                      // if (Platform.isAndroid)
                      //   paymentTile(
                      //       context: context,
                      //       paymentType: Subscription.GOOGLE_PAY
                      //           .toUpperCase()
                      //           .replaceAll("_", " "),
                      //       isSelected: state == PaymentMethod.google_pay,
                      //       onPaymentTap: () {
                      //         context
                      //             .read<PaymentMethodCubit>()
                      //             .onPaymentMethodChanged(
                      //                 Subscription.GOOGLE_PAY);
                      //       }),
                      SizedBox(
                        height: 20,
                      ),
                      // GooglePayButton(
                      //   paymentConfigurationAsset:
                      //       'default_payment_profile_google_pay.json',
                      //   paymentItems: _paymentItems,
                      //   style: GooglePayButtonStyle.black,
                      //   type: GooglePayButtonType.pay,
                      //   margin: const EdgeInsets.only(top: 15.0),
                      //   onPaymentResult: (paymentResult) {},
                      //   loadingIndicator: const Center(
                      //     child: CircularProgressIndicator(),
                      //   ),
                      // ),
                      SalukGradientButton(
                        buttonHeight: HEIGHT_2 + 5,
                        onPressed: () {
                          Navigator.pop(context);
                          if (state == PaymentMethod.card) {
                            // PAYMENT FOR SUBCRIPTION
                            Subscription.startPayment(
                              paymentMethod: Subscription.CARD,
                              context: _context,
                            );
                            // Navigator.pop(_context, isPayment_Demo);
                          } else if (state == PaymentMethod.apple_pay) {
                            // PAYMENT FOR SUBCRIPTION
                            Subscription.startPayment(paymentMethod: Subscription.APPLE_PAY, context: _context);
                          } else {
                            SolukToast.showToast("under working");
                          }
                        },
                        title: 'PROCEED',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ]),
                  );
                }),

                // SalukGradientButton(
                //   buttonHeight: HEIGHT_2 + 5,
                //   onPressed: () {
                //     Navigator.pop(context);
                //   },
                //   title: 'PROCEED',
                // )
              ],
            ),
          ),
        ],
      );
    },
  ).whenComplete(() {
    _context.read<PaymentMethodCubit>().onPaymentMethodChanged("not");
  });
}

class _InActiveSubscriptionScreenState extends State<InActiveSubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SCAFFOLD_BACKGROUND_COLOR,
      body: Column(
        children: [
          TopAppbarRow(
            title: '',
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: defaultSize.screenHeight * 0.15,
                  child: Image.asset(APP_LOGO),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Subscribe now and get",
                      style: subTitleTextStyle(context),
                    ),
                    Text(
                      "Full Access",
                      style: headingTextStyle(context),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: defaultSize.screenWidth * 0.8,
                  child: Text(
                    "Get access instantly to the largest selection of workouts and classes offered in one app",
                    textAlign: TextAlign.center,
                    style: labelTextStyle(context),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: defaultSize.screenWidth * 0.5,
                    // height: HEIGHT_5 * 2.7,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0)),
                      color: Colors.white,
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SB_1H,
                        SizedBox(
                          width: defaultSize.screenWidth * 0.4,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${(subscriptionCharges! / 30).toStringAsFixed(2)}",
                                style: headingTextStyle(context)!.copyWith(fontSize: 13.sp, color: Colors.red),
                              ),
                              Text(
                                "  SAR PER DAY",
                                style: TextStyle(fontSize: 8.sp, color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: defaultSize.screenWidth * 0.4,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${(subscriptionCharges!).toStringAsFixed(0)}",
                                style: headingTextStyle(context)!.copyWith(color: Colors.blue),
                              ),
                              Text(
                                "  SAR/mo",
                                style: labelTextStyle(context)!.copyWith(color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: defaultSize.screenWidth * 0.4,
                          child: Text(
                            "The subscription will be updated today, not at the end of the month.",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SB_1H,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
          Container(
            width: defaultSize.screenWidth,
            padding:
                EdgeInsets.symmetric(vertical: 14, horizontal: 20) + EdgeInsets.only(bottom: Platform.isIOS ? 12 : 0),
            color: Colors.white,
            child: SizedBox(
              width: defaultSize.screenWidth,
              height: 50,
              child: SalukGradientButton(
                dim: false,
                title: 'SUBSCRIBE NOW',
                style: buttonTextStyle(context)?.copyWith(fontWeight: FontWeight.w500),
                onPressed: () {
                  Subscription.generateCartId();
                  onPaymentMethods(context);
                },
                buttonHeight: HEIGHT_2 + 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
