import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hlingo/bloc/camera/camera_bloc.dart';
import 'package:hlingo/routes/router.gr.dart';

class LessonCard extends StatelessWidget {
  final String id;
  final String title;
  final String? imgUrl;

  const LessonCard(
      {Key? key, required this.id, required this.title, this.imgUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CameraBloc, CameraState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Card(
            elevation: 0,
            child: InkWell(
                splashColor: Colors.indigo[100],
                highlightColor: Colors.indigo.withAlpha(50),
                onTap: () {
                  debugPrint('go to lesson ' + title);
                  context.read<CameraBloc>().add(const LoadCamerasEvent());
                  AutoRouter.of(context).push(LessonWrapperRoute(id: title));
                },
                child: Container(
                  width: 120,
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(children: [
                    // TODO: change to imgUrl
                    Image.asset("assets/logo.png", height: 54),
                    // align center
                    Text(title, textAlign: TextAlign.center),
                  ]),
                )),
          );
        });
  }
}
