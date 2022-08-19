import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:ffmpeg_kit_flutter/ffprobe_kit.dart';
import "package:flutter/material.dart";
import 'package:hlingo/ui/pages/review_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:path/path.dart' as path;
import 'package:ffmpeg_kit_flutter/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';

class VideoPreview extends StatefulWidget {

  const VideoPreview({Key? key, required this.urlVideo, this.onNext, this.onPrev}) : super(key: key);

  final String urlVideo;
  final VoidCallback? onNext;
  final VoidCallback? onPrev;

  static Route<void> route(String url) {
    return MaterialPageRoute<void>(builder: (_) => VideoPreview(urlVideo: url));
  }

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  VideoPlayerController? _videoPlayerController;
  bool isPause = false;
  String information = "<unavailable>";

  @override
  void initState() {
    super.initState();
    initializeCamera().then((value) {
      setState(() {
        isPause = false;
      });
    });
  }

  Future<void> initializeCamera() async {
    String resultPath = await resizeVideo(widget.urlVideo);
    _videoPlayerController = VideoPlayerController.file(File(resultPath));

    await _videoPlayerController?.initialize();
    await _videoPlayerController?.setLooping(true);
    await _videoPlayerController?.play();
    await getVideoInfo(resultPath);
  }

  Future<void> getVideoInfo(String videoTarget) async {
    FFprobeKit.getMediaInformation(videoTarget).then((session) async {
      final information = session.getMediaInformation();
      if(information != null) {
        final state = FFmpegKitConfig.sessionStateToString(await session.getState());
        final mediaInfo = information.getAllProperties().toString();
        setState(() {
          this.information = state + " " + mediaInfo;
        });

        final duration = await session.getDuration();
      } else {
        setState(() {
          this.information = "<no loading>";
        });
      }
    });
  }

  Future<String> resizeVideo(String videoTarget) async {
    List<String> directoryCache = videoTarget.split('/');
    String filename = '${path.basenameWithoutExtension(videoTarget)}_cache.mp4';
    directoryCache = directoryCache.sublist(0, directoryCache.length - 1);
    String resultPath = path.join(directoryCache.join('/'), filename ) ;
    debugPrint(resultPath);
    await FFmpegKit.execute("-i $videoTarget -t 00:02:00  -vf scale=640x480 -r 30 -an $resultPath");
    FFmpegKitConfig.enableLogCallback((log) {
      debugPrint(log.getMessage());
    });

    return resultPath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            children:[
              Container(
                decoration: const BoxDecoration(

                ),
              ),
              Center(
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                            child: _videoPlayerController == null ?
                            Container():
                            Center(
                                child: _videoPlayerController!.value.isInitialized ?
                                SizedBox(
                                  height: 500,
                                  child: AspectRatio(
                                      aspectRatio: _videoPlayerController!.value.aspectRatio,
                                      child: VideoPlayer(_videoPlayerController!)
                                  ) ,
                                )
                                    :
                                Container()
                            )
                        )
                    ),
                    // Text(information)
                    ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                              }
                              return null; // Use the component's default.
                            },
                          ),
                        ),
                        onPressed: () {
                          if(widget.onNext != null) widget.onNext!();
                        },
                        icon: Icon(Icons.upload),
                        label:  Text("Subir video"),
                    )
                  ],
                ),
              ),
            ]
        )


    );
  }
}
