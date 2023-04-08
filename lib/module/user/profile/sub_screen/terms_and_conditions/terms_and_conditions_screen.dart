import 'package:app/module/user/widgets/top_appbar_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  Future<String> loadAsset(BuildContext context) async {
    return await DefaultAssetBundle.of(context)
        .loadString('assets/html/terms_and_conditions.html');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopAppbarRow(title: "Terms & Conditions"),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Center(
                child: FutureBuilder<String>(
                  builder: (ctx, snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                          child: HtmlWidget(snapshot.data!
                              .replaceFirst("terms_and_conditions", "")));
                    } else
                      return Container();
                  },
                  future: loadAsset(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
