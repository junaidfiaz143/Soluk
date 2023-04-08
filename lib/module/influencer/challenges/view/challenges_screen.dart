import 'package:app/module/influencer/challenges/cubit/challenges_bloc/challengesbloc_cubit.dart';
import 'package:app/module/influencer/challenges/view/add_challenges.dart';
import 'package:app/module/influencer/challenges/widget/challenges_widget.dart';
import 'package:app/module/influencer/challenges/widget/create_challenge_widget.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repo/data_source/local_store.dart';
import '../../../../res/constants.dart';
import '../../../../services/localisation.dart';

class ChallengesScreen extends StatefulWidget {
  static const String id = "/challenges";

  const ChallengesScreen({Key? key}) : super(key: key);

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  dynamic challengesCubit;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChallengesblocCubit, ChallengesblocState>(
      builder: (context, state) {
        if (state is ChallengesLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.grey,
          ));
        } else if (state is ChallengesEmpty) {
          return const CreateChallengeWidget();
        }
        if (state is ChallengesLoaded) {
          return Scaffold(
              backgroundColor: const Color(0xffF3F3F3),
              body: AppBody(
                  bgColor: backgroundColor,
                  title: AppLocalisation.getTranslated(context, LKChallenges),
                  body: const ChallengesWidget()),
              floatingActionButton: state is! ChallengesEmpty
                  ? FutureBuilder<dynamic>(
                      future: LocalStore.getData(PREFS_USERTYPE),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data == INFLUENCER) {
                          return FAB(callback: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const AddChallenges()));
                          });
                        }
                        return SizedBox.shrink();
                      })
                  : SizedBox.shrink());
        }
        return SizedBox.shrink();
      },
    );
  }
}

class CreateChallengeClass {
  static bool _isChallengeCreated = false;

  static bool get isChallengeCreated => _isChallengeCreated;

  static challengeCreated() {
    _isChallengeCreated = true;
  }
}
