import 'package:dojonotes/configurations/customwidgets.dart';
import 'package:dojonotes/configurations/style.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class KataPage extends StatefulWidget {
  const KataPage({super.key});

  @override
  State<KataPage> createState() => _KataPageState();
}

class _KataPageState extends State<KataPage> {
  final videoURL = "https://youtu.be/3dut0mziO_4";

  late YoutubePlayerController _controller;

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
  Widget build(BuildContext context) {
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
                roundButtons(60.0, Icons.arrow_back_rounded),
                const SizedBox(
                  width: 150,
                ),
                roundButtons(60.0, Icons.add),
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
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
        ),
        child: Column(
          children: [
            const SizedBox(height: 10,),
            myTextWidget('Gankaku', 35.0, FontWeight.w800, Colors.white),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              height: 350,
              color: Colors.white,
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
            Container(width: double.infinity,
              margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              decoration: BoxDecoration(
                color: CustomColors().CardColor,
                borderRadius: BorderRadius.circular(5)                  
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: myTextWidget('Description', 20.0, FontWeight.normal),
              ),
            )
          ],
        ),
      ),
    );
  }
}
