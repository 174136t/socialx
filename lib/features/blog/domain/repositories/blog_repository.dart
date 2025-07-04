import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:socialx/core/error/failures.dart';
import 'package:socialx/features/blog/domain/entities/blog.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required List<String> topics,
    required String posterId,
  });

  Future<Either<Failure, List<Blog>>> getAllBlogs();
}
