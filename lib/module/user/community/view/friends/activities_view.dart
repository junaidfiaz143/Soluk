import 'package:app/module/user/community/bloc/friends/friend_detail_bloc.dart';
import 'package:app/module/user/widgets/text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../res/constants.dart';
import '../../../../../utils/c_date_format.dart';
import '../../../widgets/user_appbar.dart';
import '../../model/user_activities_model.dart';

class ActivitiesView extends StatelessWidget {
  final String id;

  const ActivitiesView({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FriendDetailBloc _friendDetailBloc = BlocProvider.of(context);
    _friendDetailBloc.getUserActivitiesDetail(id);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: UserAppbar(
        title: 'Activities',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: StreamBuilder<UserActivitiesModel>(
            stream: _friendDetailBloc.userActivitiesStream,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        /*TextView(
                  'Challenges',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                SizedBox(height: 16),*/
                        ...List.generate(
                            snapshot.data?.responseDetails?.data?.length ?? 0,
                            (index) => ActivityCard(
                                activityModel: snapshot
                                    .data!.responseDetails!.data![index])),
                        /* SizedBox(height: 20),
                TextView(
                  'Workout Programs',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                SizedBox(height: 16),
                ...List.generate(3, (index) => ActivityCard()),*/
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    );
            }),
      ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final Data activityModel;

  const ActivityCard({Key? key, required this.activityModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            activityModel.actionText ?? "",
            fontSize: 16,
          ),
          SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: TextView(
                CDateFormat.returnMonthDayYear(activityModel.createdAt ?? ""),
                color: Colors.grey),
          )
        ],
      ),
    );
  }
}
