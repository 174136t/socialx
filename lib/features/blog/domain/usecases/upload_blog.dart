import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:socialx/core/error/failures.dart';
import 'package:socialx/core/usecase/usecase.dart';
import 'package:socialx/features/blog/domain/entities/blog.dart';
import 'package:socialx/features/blog/domain/repositories/blog_repository.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;
  UploadBlog(this.blogRepository);

  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      topics: params.topics,
      posterId: params.posterId,
    );
  }
}

class UploadBlogParams {
  final File image;
  final String title;
  final String content;
  final List<String> topics;
  final String posterId;

  UploadBlogParams({
    required this.image,
    required this.title,
    required this.content,
    required this.topics,
    required this.posterId,
  });
}
