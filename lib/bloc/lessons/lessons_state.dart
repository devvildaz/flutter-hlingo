part of 'lessons_bloc.dart';

@immutable
abstract class LessonsState {
  final bool isLoading;
  final List<Lesson> lessons;

  const LessonsState({this.lessons = const [], this.isLoading = false});
}

class LessonsInitialState extends LessonsState {
  const LessonsInitialState() : super();
}

class LessonsSetState extends LessonsState {
  final List<Lesson> newLessons;

  const LessonsSetState(this.newLessons)
      : super(lessons: newLessons, isLoading: false);
}

class LoadingState extends LessonsState {
  const LoadingState() : super(isLoading: true);
}

class ErrorState extends LessonsState {
  final String error;

  const ErrorState(this.error) : super(isLoading: false);
}
