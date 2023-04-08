import 'package:app/module/influencer/workout/tags_list.dart';
import 'package:app/module/influencer/workout/widgets/add_tags_dialog.dart';
import 'package:app/module/influencer/workout/widgets/multi_select_chips.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AddTagsTransparentButton extends StatefulWidget {
  final Function() onTap;
  const AddTagsTransparentButton({Key? key, required this.onTap}) : super(key: key);

  @override
  State<AddTagsTransparentButton> createState() => _AddTagsTransparentButtonState();
}

class _AddTagsTransparentButtonState extends State<AddTagsTransparentButton> {

  List<String> selectedProgrammingList = [];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.065,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF498aee)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFF498aee),
                radius: 12,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 2.h,
                ),
              ),
              SizedBox(width: 3.w,),
              Text('Add Tags', style: labelTextStyle(context)!.copyWith(
                  color: const Color(0xFF498aee),
                  fontSize: 12.sp
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
