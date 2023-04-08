import 'package:app/module/influencer/subscribers/bloc/subscriber_bloc.dart';
import 'package:app/module/influencer/subscribers/widget/subscribers_name_profile.dart';
import 'package:app/module/influencer/subscribers/widget/subscribers_top_widget.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class SubscribersScreen extends StatelessWidget {
  static const id = 'SubscribersScreen';

  const SubscribersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _subscriberBloc = BlocProvider.of<SubscriberBloc>(context);
    // _subscriberBloc.add(SubscribersListLoadedEvent());

    return Scaffold(
      body: AppBody(
        title: AppLocalisation.getTranslated(context, LKSubscribers),
        body: BlocBuilder<SubscriberBloc, SubscriberState>(
          builder: (context, state) {
            if (state is SubscribersListLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              );
            }
            if (state is SubscribersListLoadedState) {
              return SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    subscribersTopWidget(context,
                        subscribers:
                            state.subscribersList?.length.toString() ?? '0'),
                    Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(
                        AppLocalisation.getTranslated(
                            context, LKSubscriberList),
                        style: headingTextStyle(context)!.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.subscribersList?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SubscribersNameProfileWidget(context,
                              subscriberName:
                                  state.subscribersList?[index].fullname ?? '',
                              subscriberProfile:
                                  state.subscribersList?[index].imageUrl ??
                                      'https://picsum.photos/201');
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
