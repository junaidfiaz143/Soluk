import 'package:app/module/influencer/more/bloc/suggestion_bloc/suggestionbloc_cubit.dart';
import 'package:app/module/influencer/more/model/suggestion_model.dart';
import 'package:app/module/influencer/more/widget/suggestion_tile.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/workout/widgets/components/refresh_widget.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Suggestions extends StatelessWidget {
  static const String id = "/more_suggestions";
  const Suggestions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sugg = BlocProvider.of<SuggestionblocCubit>(context);
    sugg.getSuggestions();
    return Scaffold(
      body: BlocBuilder<SuggestionblocCubit, SuggestionblocState>(
        builder: (context, state) {
          if (state is SuggestionblocLoading) {
            return const Center(child: CircularProgressIndicator());
          }else {
            // if((state.suggestions?.responseDetails?.data??[]).isEmpty){
            //    return  Center(child:Text(
            //             'No Suggestions Found',
            //             style: subTitleTextStyle(context)?.copyWith(
            //                   fontSize: defaultSize.screenHeight * .02,
            //                   fontWeight: FontWeight.normal
            //                 ),
            //           ));
            // }
          return AppBody(
            bgColor:  backgroundColor,
            title: AppLocalisation.getTranslated(context, LKSuggestions),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SB_1H,
                // Text(
                //   AppLocalisation.getTranslated(context, LKToday),
                //   style: hintTextStyle(context),
                // ),
                SB_1H,
                Expanded(
                  child:(state.suggestions?.responseDetails?.data??[]).isEmpty?
                  Center(child:Text(
                        'No Suggestions Found',
                        style: subTitleTextStyle(context)?.copyWith(
                              fontSize: defaultSize.screenHeight * .02,
                              fontWeight: FontWeight.normal
                            ),
                      ))
                   :RefreshWidget(
                    refreshController: sugg.refreshController,
                            onLoadMore: () => sugg.onLoadMore(),
                            onRefresh: () => sugg.onRefresh(),
                            enablePullDown: false,
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: state.suggestions?.responseDetails
                                      ?.data?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                Data item = state
                                    .suggestions!.responseDetails!.data![index];
                                return SuggestionTile(suggestion: item);
                              },
                            ),
                          ),
                ),
              ],
            ),
          );}
          // else {
          //   return Container();
          // }
        },
      ),
    );
  }
}
