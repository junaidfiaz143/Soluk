import 'package:app/module/influencer/workout/model/get_influencer.dart';
import 'package:app/module/user/home/sub_screen/influencer_about_me/view/user_influencer_profile.dart';
import 'package:flutter/material.dart';

class InfluencerAboutMe extends StatefulWidget {
  GetInfluencerModel? influencerInfo;

  InfluencerAboutMe({Key? key, this.influencerInfo}) : super(key: key);

  @override
  State<InfluencerAboutMe> createState() => _InfluencerAboutMeState();
}

class _InfluencerAboutMeState extends State<InfluencerAboutMe> {
  @override
  Widget build(BuildContext context) {
    return UserInfluencerProfile(
      influencerInfo: widget.influencerInfo,
      valueChanged: (val) {
        setState(() {});
      },
    );
  }

  @override
  void initState() {}
}
