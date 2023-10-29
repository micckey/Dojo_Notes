import 'package:dojonotes/configurations/custom_widgets.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class KataPage extends StatefulWidget {
  const KataPage({super.key});

  @override
  State<KataPage> createState() => _KataPageState();
}

class _KataPageState extends State<KataPage> {

  late YoutubePlayerController _controller;

  final name = Get.arguments[0];
  final category = Get.arguments[1];
  final description = Get.arguments[2];
  final meaning = Get.arguments[3];
  final videoURL = Get.arguments[4];
  final steps = Get.arguments[5];

  @override
  void initState() {

    final videoID = YoutubePlayer.convertUrlToId(videoURL);

    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
        )
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    Orientation currentDeviceOrientation = MediaQuery.of(context).orientation;

    return Scaffold(
      backgroundColor: CustomColors().highlightColor,
      appBar: currentDeviceOrientation == Orientation.landscape ?
      AppBar(toolbarHeight: 0.0, backgroundColor: CustomColors().backgroundColor,)
      :
      AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 65,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        flexibleSpace: SizedBox(
          width: 395,
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                roundButtons(60.0, Icons.arrow_back_rounded, () => Get.back()),
                const SizedBox(
                  width: 150,
                ),
                roundButtons(60.0, Icons.add, (){}),
              ],
            ),
          ),
        ),
      ),
      body: currentDeviceOrientation == Orientation.landscape?
      Container(
        width: double.maxFinite,
        color: CustomColors().buttonColor,
        child: AspectRatio(
            aspectRatio: 16/9,
          child: buildYoutubePlayer(),
        ),
      )
      :
      Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: CustomColors().backgroundColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              myTextWidget(name, 35.0, FontWeight.w800, Colors.white),
              SizedBox(
                height: bodyHeight*0.53.h,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: buildYoutubePlayer(),
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: CustomColors().cardColor,
                    borderRadius: BorderRadius.circular(5)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          myTextWidget('Meaning: ', 20.0, FontWeight.w500, CustomColors().titleText),
                          Flexible(child: myTextWidget(meaning, 20.0, FontWeight.normal, CustomColors().contentText)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          myTextWidget('Description: ', 20.0, FontWeight.w500, CustomColors().titleText),
                          Flexible(
                              child: myTextWidget(
                                  description, 20.0, FontWeight.normal, CustomColors().contentText)),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          myTextWidget('Steps: ', 20.0, FontWeight.w500, CustomColors().titleText),
                          myTextWidget('$steps', 20.0, FontWeight.normal, CustomColors().contentText),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  YoutubePlayer buildYoutubePlayer() {
    return YoutubePlayer(
            showVideoProgressIndicator: true,
            bottomActions: [
              CurrentPosition(),
              FullScreenButton(),
              ProgressBar(
                isExpanded: true,
                colors: ProgressBarColors(
                    playedColor: CustomColors().highlightColor,
                    handleColor: Colors.black
                ),
              )
            ],
            controller: _controller);
  }
}
