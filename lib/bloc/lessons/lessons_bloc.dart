import 'package:bloc/bloc.dart';
import 'package:hlingo/models/lesson.dart';
import 'package:hlingo/utils/constant.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'lessons_event.dart';
part 'lessons_state.dart';

class LessonsBloc extends Bloc<LessonsEvent, LessonsState> {
  LessonsBloc() : super(const LessonsInitialState()) {
    on<LoadLessons>((event, emit) async {
      emit(const LoadingState());

      try {
        final res = await http.get(Uri.parse('$baseUrl/lessons'));
        if (res.statusCode == 200) {
          final lessons = json
              .decode(res.body)
              .map<Lesson>((lesson) => Lesson.fromJson(lesson))
              .toList();
          emit(LessonsSetState(lessons));
        } else {
          print("Error getting lessons");
          emit(const ErrorState('Error al obtener los datos'));
        }
      } catch (e) {
        emit(const ErrorState('Error al cargar'));
      }
    });
  }
}
