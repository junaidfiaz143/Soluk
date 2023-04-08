
import 'package:app/module/influencer/challenges/view/all_challengers.dart';
import 'package:app/module/influencer/widgets/item_header.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:flutter/material.dart';

class ItemDetails extends StatelessWidget {
  final String route;
  final String? title;
  final String? blog;
  const ItemDetails({
    Key? key,
    required this.route,
    this.title,
    this.blog,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ItemHeader(title: title!),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: HEIGHT_5 * 6.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      defaultSize.radius(30),
                    ),
                    topRight: Radius.circular(
                      defaultSize.radius(30),
                    ),
                  ),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                padding: EdgeInsets.symmetric(
                      horizontal: HORIZONTAL_PADDING,
                    ) +
                    EdgeInsets.only(
                      top: defaultSize.screenHeight * .02,
                    ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  route.contains("chall")
                                      ? "Challenge Title"
                                      : "Title",
                                  style: hintTextStyle(context)?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: defaultSize.screenHeight * .01,
                                ),
                                Text(
                                  "Body weight for upper body",
                                  style: labelTextStyle(context)?.copyWith(
                                    fontSize: defaultSize.screenWidth * .042,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (!route.contains("challenge"))
                            InkWell(
                              onTap: () {},
                              splashColor: Colors.black26,
                              child: Container(
                                width: WIDTH_5,
                                height: WIDTH_5,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.edit,
                                    color: PRIMARY_COLOR,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SB_2H,
                      Text(
                        route.contains("link")
                            ? "Link"
                            : route.contains("blog")
                                ? "Blog"
                                : route.contains("challenge")
                                    ? "Description"
                                    : "Nutrient Diet",
                        style: hintTextStyle(context)?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: defaultSize.screenHeight * .01,
                      ),
                      if (route.contains("blog") && blog != null)
                        Text(
                          blog!,
                          style: labelTextStyle(context),
                        )
                      else if (route.contains("challenge") && blog != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              blog!,
                              style: labelTextStyle(context)?.copyWith(
                                fontSize: defaultSize.screenWidth * .035,
                              ),
                            ),
                            SB_1H,
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Date",
                                      style: labelTextStyle(context)?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: defaultSize.screenHeight * .01,
                                    ),
                                    Text(
                                      "12/03/2022",
                                      style: labelTextStyle(context)?.copyWith(
                                        fontSize:
                                            defaultSize.screenWidth * .035,
                                      ),
                                    ),
                                  ],
                                ),
                                SB_1W,
                                Column(
                                  children: [
                                    Text(
                                      "Time",
                                      style: labelTextStyle(context)?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: defaultSize.screenHeight * .01,
                                    ),
                                    Text(
                                      "10:30:00",
                                      style: labelTextStyle(context)?.copyWith(
                                        fontSize:
                                            defaultSize.screenWidth * .035,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SB_1H,
                            Text(
                              "Complete Badge",
                              style: labelTextStyle(context)?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: defaultSize.screenHeight * .01,
                            ),
                            const Icon(
                              Icons.padding,
                            ),
                            SB_1H,
                            Text(
                              "22 Users done your challenge",
                              style: hintTextStyle(context),
                            ),
                            SB_1H,
                            Center(
                              child: SalukGradientButton(
                                title: "See all challengers",
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const AllChallengers(),
                                    ),
                                  );
                                },
                                buttonHeight: HEIGHT_3,
                              ),
                            ),
                            SB_1H,
                          ],
                        )
                      else if (route.contains("link"))
                        Row(
                          children: [
                            Icon(
                              Icons.link,
                              size: WIDTH_2,
                              color: PRIMARY_COLOR,
                            ),
                            SB_1W,
                            Text(
                              "www.abc.com",
                              style: labelTextStyle(context)?.copyWith(
                                fontSize: defaultSize.screenWidth * .035,
                                color: PRIMARY_COLOR,
                              ),
                            ),
                          ],
                        )
                      else if (route.contains("nutrient"))
                        GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          children: List.generate(
                            4,
                            (index) {
                              return Container(
                                height: HEIGHT_5 * 2,
                                width: HEIGHT_5 * 2,
                                decoration: BoxDecoration(
                                  borderRadius: BORDER_CIRCULAR_RADIUS * 2,
                                  image: const DecorationImage(
                                    image: AssetImage(
                                      WORKOUT_COVER2,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
