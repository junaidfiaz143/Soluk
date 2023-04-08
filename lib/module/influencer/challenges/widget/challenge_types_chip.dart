import 'package:app/res/color.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

class CustomChipsGroup extends StatefulWidget {
  const CustomChipsGroup(
      {Key? key, this.chips, this.isBorderStyle, this.onItemClick})
      : super(key: key);
  final List<String>? chips;
  final bool? isBorderStyle;
  final Function(int)? onItemClick;

  @override
  State<CustomChipsGroup> createState() => _CustomChipsGroupState();
}

class _CustomChipsGroupState extends State<CustomChipsGroup> {
  final List<String> chipTitles = ["Approved", "Unapproved"];

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: List.generate(
      widget.chips != null && widget.chips!.isNotEmpty
          ? widget.chips!.length
          : chipTitles.length,
      (index) {
        return Padding(
          padding: EdgeInsets.only(
            right: widget.isBorderStyle == true ? 10 : 20,
          ),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onItemClick?.call(selectedIndex);
            },
            child: Chip(
              backgroundColor: selectedIndex == index
                  ? PRIMARY_COLOR
                  : widget.isBorderStyle == true
                      ? Colors.white
                      : null,
              shape: widget.isBorderStyle == true
                  ? StadiumBorder(side: BorderSide(color: PRIMARY_COLOR))
                  : null,
              label: Text(
                  widget.chips != null && widget.chips!.isNotEmpty
                      ? widget.chips![index]
                      : chipTitles[index],
                  style: selectedIndex == index
                      ? labelTextStyle(context)?.copyWith(
                            color: Colors.white,
                          )
                        : hintTextStyle(context)?.copyWith(
                            color: widget.isBorderStyle == true
                                ? PRIMARY_COLOR
                                : Colors.grey)),
              ),
            ),
          );
        },
      ),
    );
  }
}
