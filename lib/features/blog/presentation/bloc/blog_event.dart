part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUploadEvent extends BlogEvent {
  final File image;
  final String title;
  final String content;
  final List<String> topics;
  final String posterId;

  BlogUploadEvent({
    required this.image,
    required this.title,
    required this.content,
    required this.topics,
    required this.posterId,
  });
}

final class BlogFetchAllBlogs extends BlogEvent{

}