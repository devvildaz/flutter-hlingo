import 'dart:io';

import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:ffmpeg_kit_flutter/ffprobe_kit.dart';
import "package:flutter/material.dart";
import 'package:hlingo/ui/pages/review_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:path/path.dart' as path;
import 'package:ffmpeg_kit_flutter/ffmpeg_kit_config.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:http/http.dart' as http;

class VideoPreview extends StatefulWidget {

  const VideoPreview({Key? key, required this.urlVideo, this.onNext, this.onPrev, this.onDispose}) : super(key: key);

  final String urlVideo;
  final Function(String)? onNext;
  final VoidCallback? onPrev;
  final VoidCallback? onDispose;

  static Route<void> route(String url) {
    return MaterialPageRoute<void>(builder: (_) => VideoPreview(urlVideo: url));
  }

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late String urlVideo;
  VideoPlayerController? _videoPlayerController;
  bool isPause = false;
  String information = "<unavailable>";
  File? videoTarget;

  bool reqLoading = false;

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
    urlVideo = widget.urlVideo;
    urlVideo = await resizeVideo(urlVideo);
    videoTarget = File(urlVideo);
    _videoPlayerController = VideoPlayerController.file(videoTarget!);

    await _videoPlayerController?.initialize();
    await _videoPlayerController?.setLooping(true);
    await _videoPlayerController?.play();
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
    await FFmpegKit.execute("-i $videoTarget -vf scale=400x400 -r 30 -an $resultPath");

    return resultPath;
  }

  @override
  void dispose(){
    super.dispose();
    if(widget.onDispose != null ) widget.onDispose!();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
              Center(
                child: _videoPlayerController != null ? Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Center(
                            child: _videoPlayerController == null ?
                            Container():
                            Center(
                                child: _videoPlayerController!.value.isInitialized ?
                                SizedBox(
                                  height: 600,
                                  child: AspectRatio(
                                      aspectRatio: _videoPlayerController!.value.aspectRatio,
                                      child: VideoPlayer(_videoPlayerController!)
                                  ) ,
                                )
                                    :
                                const CircularProgressIndicator()
                            )
                        )
                    ),
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
                        onPressed: _videoPlayerController != null && !reqLoading ? () async {
                          var request = http.MultipartRequest("POST", Uri.http("34.236.148.76", "predict"));
                          request.files.add(await http.MultipartFile.fromPath('file', urlVideo));
                          setState(() {
                            reqLoading = true;
                          });
                          var response = await request.send();
                          var result = await http.Response.fromStream(response);
                          setState(() {
                            reqLoading = false;
                          });
                          if(!mounted) return;
                          if(result.statusCode != 200) {
                            showDialog(context: context, builder: (ctx)  {
                              return AlertDialog(
                                title: Text("Error"),
                                content: Text("Intente realizar la operacion de nuevo"),
                                actions: <Widget>[
                                  FlatButton(onPressed: () {
                                    Navigator.of(ctx).pop();
                                  }, child: Text("Ok"))
                                ],
                              );
                            });
                            return;
                          }

                          if(widget.onNext != null) widget.onNext!(result.body);
                        } : null,
                        icon: const Icon(Icons.upload),
                        label:  !reqLoading ? const Text("Subir video") : const CircularProgressIndicator(),
                    )
                  ],
                ) : const CircularProgressIndicator(),
              ),
    );
  }
}
