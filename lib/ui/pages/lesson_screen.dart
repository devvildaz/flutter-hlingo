import "package:flutter/material.dart";
import "package:hlingo/bloc/camera/camera_bloc.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "../widgets/lesson_icon.dart";
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class LessonPage extends StatefulWidget {
  final String id;
  final String description;
  final VoidCallback onNext;
  final String? urlVideo;

  const LessonPage({
    Key? key,
    required this.id,
    required this.description,
    required this.onNext,
    this.urlVideo
  }) : super(key: key);
  
  @override
  State<LessonPage> createState() => _LessonScreenState();
}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  minimumSize: const Size(88,36)
);

class _LessonScreenState extends State<LessonPage> {
  InAppWebViewController? webView;
  bool isLoadingCamera = false;

  @override
  void initState() {
    super.initState();
  }

  Widget buildMainPage(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;
    return Container(
      margin: EdgeInsets.only(top: height),
      padding: const EdgeInsets.only(top: 100),
      color: Colors.white,
      child: Column(
        children: [
          LessonIconWidget(title: widget.id),
          BlocConsumer<CameraBloc,CameraState>(
            listener: (context, state) {
              print(state.cameras);
              print("consumer a state changed event");
              //context.read<CameraBloc>().add(RemoveCameraEvent(state.cameras, state.controller.value));]
              if(state.controller.isEmpty) {

                setState(() {
                  isLoadingCamera = false;
                });
              }
            },
            builder: (context, state) {
              return  Expanded(
                child: SizedBox(
                  child: GridView.count(
                      padding: const EdgeInsets.all(25),
                      shrinkWrap: true,
                      crossAxisCount: 1,
                      childAspectRatio: 9.33 ,
                      mainAxisSpacing: 10,
                      children: [
                        ElevatedButton(
                            onPressed: widget.urlVideo != null ? () {
                              showDialog(context: context, builder: (ctx)  {
                                return AlertDialog(
                                  title: const Text("Video de prueba"),
                                  content: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 400,
                                    child:
                                      Expanded(
                                          child: InAppWebView(
                                          initialUrlRequest: URLRequest(
                                            url: Uri.parse(widget.urlVideo!),
                                          )
                                      ))
                                  ),
                                  actions: <Widget>[
                                    FlatButton(onPressed: () {
                                      Navigator.of(ctx).pop();
                                    }, child: const Text("Ok"))
                                  ],
                                );
                              });
                            } : null,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    child: const Icon(
                                      Icons.smart_display,
                                      color: Colors.white,
                                      size: 32,
                                    )
                                ),
                                const Text("Ver video de muestra"),
                              ],
                            )
                        ),
                        ElevatedButton(
                            onPressed: () {
                              widget.onNext();
                            } ,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: true ?  [
                                Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    child: const Icon(
                                      Icons.videocam,
                                      color: Colors.white,
                                      size: 32,
                                    )
                                ) ,
                                const Text("Grabar y practicar"),
                              ] : [
                                /*
                                const SizedBox(
                                  //child: CircularProgressIndicator(strokeWidth: 2,),
                                  child: const Container(),
                                  width: 16.0,
                                  height: 16.0,
                                )
                                 */
                              ],
                            )
                        )
                      ]
                  ),
                ),
              );
            }
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildMainPage(context);
  }

  @override
  void deactivate() {
    super.deactivate();

  }

  @override
  void dispose() {
    super.dispose();

  }
}

