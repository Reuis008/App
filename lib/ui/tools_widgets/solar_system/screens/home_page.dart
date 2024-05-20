import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//models
import '../models/topic.dart';

//providers
import '../providers/topics.dart';

//widgets
import '../widgets/topic_card.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final topicData = Provider.of<Topics>(context).topics;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color(0xFF161743),
        body: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg2.jpg'),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                heading(),
                subHeading(),
                topicList(height, width, topicData),
              ],
            ),
          ),
        ));
  }
}

Widget topicList(double height, double width, List<Topic> topics) {
  final double topicCardWidth = width * 0.75;
  final double topicCardHeight = topicCardWidth * 0.55;
  return Padding(
    padding: const EdgeInsets.only(top: 40, right: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        ...topics.map((topic) {
          return TopicCard(
              height: topicCardHeight, width: topicCardWidth, topic: topic);
        })
      ],
    ),
  );
}

Widget heading() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        padding: const EdgeInsets.only(left: 30, top: 50),
        alignment: Alignment.centerLeft,
        child: const Text(
          "Solar System",
          style: TextStyle(color: Colors.white, fontSize: 35),
        ),
      ),
    ],
  );
}

Widget subHeading() {
  return Container(
      padding: const EdgeInsets.only(left: 30, top: 10),
      alignment: Alignment.centerLeft,
      child: RichText(
        text: const TextSpan(children: [
          TextSpan(
            text: "Explore the solar system and\n",
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          TextSpan(
            text: "go beyond your reach.",
            style: TextStyle(color: Colors.white, fontSize: 17),
          )
        ]),
      ));
}
