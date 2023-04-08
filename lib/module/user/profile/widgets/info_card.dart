import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
                width: defaultSize.screenWidth * 0.15,
                child: Image.asset("assets/images/visa_card.png")),
            SizedBox(width: 20),
            SizedBox(
                width: defaultSize.screenWidth * 0.15,
                child: Image.asset("assets/images/master_card.png")),
            SizedBox(width: 20),
            SizedBox(
                width: defaultSize.screenWidth * 0.15,
                child: Image.asset("assets/images/mada.png")),
          ]),
          SizedBox(height: 25),
          Text(
            "شركة سلوك الرياضية | CR:2050149854",
            style: hintTextStyle(context)!
                .copyWith(fontSize: 10.sp, color: Colors.black),
          ),
          SizedBox(height: 10),
          Text("info@soluk.app",
              style: hintTextStyle(context)!
                  .copyWith(fontSize: 10.sp, color: Colors.black)),
          SizedBox(height: 10),
          Text("+966 54 788 3311",
              style: hintTextStyle(context)!
                  .copyWith(fontSize: 10.sp, color: Colors.black)),
          SizedBox(height: 10),
          Text("Prince Saud bin Nayef bin Abdulaziz, 34436, Dammam, KSA",
              style: hintTextStyle(context)!
                  .copyWith(fontSize: 10.sp, color: Colors.black)),
          // SizedBox(height: 10),
          // Text("Al Khubar 6345-34235",
          //     style: hintTextStyle(context)!.copyWith(fontSize: 10.sp)),
        ],
      ),
    );
  }
}
