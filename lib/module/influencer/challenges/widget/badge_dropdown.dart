import 'package:app/module/influencer/challenges/cubit/badges_bloc/badgesbloc_cubit.dart';
import 'package:app/module/influencer/challenges/model/badges_modal.dart';
import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../res/constants.dart';
import '../../../../services/localisation.dart';

class BadgeDropDown extends StatefulWidget {
  final Function(CompletionBadge) onValueChange;
  const BadgeDropDown({Key? key, required this.onValueChange})
      : super(key: key);

  @override
  State<BadgeDropDown> createState() => _BadgeDropDownState();
}

class _BadgeDropDownState extends State<BadgeDropDown> {
  CompletionBadge? value;

  @override
  Widget build(BuildContext context) {
    List<String> badges = [
      AppLocalisation.getTranslated(context, LKBronze),
      AppLocalisation.getTranslated(context, LKSilver),
      AppLocalisation.getTranslated(context, LKSoluk),
    ];
    return BlocBuilder<BadgesblocCubit, BadgesblocState>(
      builder: (context, state) {
        if(state is BadgesblocLoading){
          return Center(child: LinearProgressIndicator(),);
        }
        return Container(
          width: defaultSize.screenWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10,
            ),
            border: Border.all(
              width: defaultSize.screenWidth * .003,
              color: Colors.blue,
            ),
            color: Colors.transparent,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: defaultSize.screenWidth * .03,
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: DropdownButton<CompletionBadge>(
            hint: Text(AppLocalisation.getTranslated(context, LKSelectBadge),
                style: labelTextStyle(context)),
            underline: const SizedBox(),
            style: labelTextStyle(context)?.copyWith(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                defaultSize.screenWidth * .02,
              ),
            ),
            dropdownColor: DROPDOWN_BACKGROUND_COLOR,
            isExpanded: true,
            value: value,
            items: (state.badges?.responseDetails?.completionBadge??[]) .map((CompletionBadge value) {
              return DropdownMenuItem<CompletionBadge>(
                value: value,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(value.title!),
                  ],
                ),
                onTap: () {},
              );
            }).toList(),
            onChanged: (_) {
              if (_ != null ) {
                widget.onValueChange(_);
                setState(() {
                  value = _;
                });
              }
            },
          ),
        );
      },
    );
  }
}
