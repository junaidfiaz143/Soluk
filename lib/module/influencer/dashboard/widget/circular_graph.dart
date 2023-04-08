import 'package:app/module/influencer/dashboard/model/circular_graph.dart';
import 'package:app/module/influencer/dashboard/widget/info.dart';
import 'package:app/res/constants.dart';
import 'package:app/services/localisation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CircularGraph extends StatelessWidget {
  final int published;
  final int unPublished;

  const CircularGraph({Key? key, required this.published, required this.unPublished}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TooltipBehavior _tooltip = TooltipBehavior(enable: true);
    getCircularGraphData(published: published, unPublished: unPublished);

    return  Padding(
      padding: EdgeInsets.only(top: 1.98.h),
      child: Container(
        height: MediaQuery.of(context).size.height*0.18,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),

        child: Row(
          children: [
            Expanded(
              child: SfCircularChart(
                  tooltipBehavior: _tooltip,
                  series: <CircularSeries>[
                    DoughnutSeries<CircularGraphModel, String>(
                        radius: '55',
                        innerRadius: '37',
                        strokeColor: Colors.red,
                        dataSource: circularGraphData,
                        pointColorMapper:(CircularGraphModel data,  _) => data.color,
                        xValueMapper: (CircularGraphModel data, _) => data.type,
                        yValueMapper: (CircularGraphModel data, _) => data.value,
                    )
                  ]
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  infoWidget(context, type: AppLocalisation.getTranslated(context, LKPublished), value: published.toString(), isPublished: true),
                  infoWidget(context, type: AppLocalisation.getTranslated(context, LKUnPublished), value: unPublished.toString()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
