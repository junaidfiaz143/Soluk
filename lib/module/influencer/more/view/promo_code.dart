import 'package:app/animations/slide_up_transparent_animation.dart';
import 'package:app/module/influencer/more/bloc/cubit/promobloc_cubit.dart';
import 'package:app/module/influencer/more/widget/custom_alert_dialog.dart';
import 'package:app/module/influencer/widgets/action_pop_up.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';

import '../../widgets/back_button.dart';

class PromoCode extends StatefulWidget {
  static const String id = "/more_promo_code";

  const PromoCode({Key? key}) : super(key: key);

  @override
  State<PromoCode> createState() => _PromoCodeState();
}

class _PromoCodeState extends State<PromoCode> {
  bool isButtonPressed = false;

  @override
  void initState() {
    BlocProvider.of<PromoblocCubit>(context).getPromoCode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: HORIZONTAL_PADDING),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80),
            Stack(
              children: [
                SolukBackButton(),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 4),
                      SvgPicture.asset('assets/svgs/ic_promocode.svg'),
                      SizedBox(height: 10),
                      Text(AppLocalisation.getTranslated(context, LKPromoCodes),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16))
                    ],
                  ),
                ),
              ],
            ),
            SB_1H,
            Text(
              AppLocalisation.getTranslated(context, LKGenerateCode),
              style: labelTextStyle(context)?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: defaultSize.screenHeight * .01,
            ),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
              style: labelTextStyle(context),
            ),
            SB_1H,
            BlocBuilder<PromoblocCubit, PromoblocState>(
              builder: (context, state) {
                if (state is PromoLoading) {
                  return CircularProgressIndicator(color: Colors.grey);
                }
                return Column(children: [
                  if (state is PromoEmpty)
                    SalukGradientButton(
                      title:
                          AppLocalisation.getTranslated(context, LKGenerateNow),
                      onPressed: () {
                        BlocProvider.of<PromoblocCubit>(context).addPromoCode();
                        navigatorKey.currentState?.push(
                          SlideUpTransparentRoute(
                            enterWidget: CustomAlertDialog(
                              contentWidget: ActionPopUp(
                                title: AppLocalisation.getTranslated(
                                    context, LKYourCode),
                                content: AppLocalisation.getTranslated(
                                    context, LKGeneratedSuccessfully),
                                subContent:
                                    BlocBuilder<PromoblocCubit, PromoblocState>(
                                  builder: (context, state) {
                                    return Text(
                                      state is PromoDialogLoading
                                          ? "Generating"
                                          : state.promoCode?.responseDetails
                                                  ?.promoCode ??
                                              '',
                                      style: labelTextStyle(context)?.copyWith(
                                        color: PRIMARY_COLOR,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    );
                                  },
                                ),
                                actionButtons:
                                    BlocBuilder<PromoblocCubit, PromoblocState>(
                                  builder: (context, state) {
                                    return Row(
                                      children: [
                                        SizedBox(
                                          width: defaultSize.screenWidth * .35,
                                          child: SalukGradientButton(
                                            title:
                                                AppLocalisation.getTranslated(
                                                    context, LKShare),
                                            onPressed: () async {
                                              if (state is PromoLoaded) {
                                                await sharePromo(state
                                                        .promoCode
                                                        ?.responseDetails
                                                        ?.promoCode ??
                                                    '');
                                                Navigator.pop(context);
                                              }
                                            },
                                            buttonHeight: HEIGHT_3,
                                            linearGradient:
                                                const LinearGradient(
                                              colors: [
                                                Colors.black,
                                                Colors.black,
                                              ],
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        SizedBox(
                                          width: defaultSize.screenWidth * .35,
                                          child: SalukGradientButton(
                                            title:
                                                AppLocalisation.getTranslated(
                                                    context, LKOk),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            buttonHeight: HEIGHT_3,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                            routeName: CustomAlertDialog.id,
                          ),
                        );
                      },
                      buttonHeight: HEIGHT_4,
                    ),
                  if (state is PromoLoaded)
                    Row(
                      children: [
                        Text(
                          "Promo Code",
                          style: subTitleTextStyle(context)?.copyWith(
                            fontSize: defaultSize.screenHeight * .022,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SB_1W,
                        Text(
                          "${state.promoCode?.responseDetails?.promoCode ?? ''}",
                          style: subTitleTextStyle(context)?.copyWith(
                            fontSize: defaultSize.screenHeight * .022,
                            fontWeight: FontWeight.w600,
                            color: PRIMARY_COLOR,
                          ),
                        ),
                        SB_1W,
                        Container(
                          width: WIDTH_5,
                          height: WIDTH_5,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              sharePromo(
                                  state.promoCode?.responseDetails?.promoCode ??
                                      '');
                            },
                            child: Icon(
                              Icons.share,
                              color: Colors.black,
                              size: defaultSize.screenWidth * .05,
                            ),
                          ),
                        ),
                      ],
                    ),
                ]);
              },
            )
          ],
        ),
      ),
    );
  }

  sharePromo(String promo) async {
    await Share.share(
        'Sign up using my promo Code $promo or click on this link to signup https://soluk.app/signup/$promo',
        subject: 'Look what I made!');
  }
}
