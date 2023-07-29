import 'package:dojonotes/configurations/customwidgets.dart';
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

    return Scaffold(
      backgroundColor: CustomColors().HighlightColor,
      appBar: AppBar(
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: CustomColors().BackgroundColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
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
                child: YoutubePlayer(
                    showVideoProgressIndicator: true,
                    bottomActions: [
                      CurrentPosition(),
                      FullScreenButton(),
                      ProgressBar(
                        isExpanded: true,
                        colors: ProgressBarColors(
                            playedColor: CustomColors().HighlightColor,
                            handleColor: Colors.black
                        ),
                      )
                    ],
                    controller: _controller),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: CustomColors().CardColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      myTextWidget('Meaning: ', 20.0, FontWeight.w500),
                      Flexible(child: myTextWidget(meaning, 20.0, FontWeight.normal)),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      myTextWidget('Description: ', 20.0, FontWeight.w500),
                      Flexible(
                          child: myTextWidget(
                              description, 20.0, FontWeight.normal)),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      myTextWidget('Steps: ', 20.0, FontWeight.w500),
                      myTextWidget('${steps}', 20.0, FontWeight.normal),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
