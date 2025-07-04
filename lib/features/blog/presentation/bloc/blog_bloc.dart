import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialx/core/error/failures.dart';
import 'package:socialx/core/usecase/usecase.dart';
import 'package:socialx/features/blog/domain/entities/blog.dart';
import 'package:socialx/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:socialx/features/blog/domain/usecases/upload_blog.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;
  BlogBloc({required UploadBlog uploadBlog, required GetAllBlogs getAllBlogs})
    : _uploadBlog = uploadBlog,
      _getAllBlogs = getAllBlogs,
      super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUploadEvent>(_blogUploadEvent);
    on<BlogFetchAllBlogs>(_onFetchAllBlogs);
  }

  void _blogUploadEvent(BlogUploadEvent event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog(
      UploadBlogParams(
        image: event.image,
        title: event.title,
        content: event.content,
        topics: event.topics,
        posterId: event.posterId,
      ),
    );

    res.fold((l) => emit(BlogFailure(mapFailureToMessage(l))), (r) => emit(BlogUploadSuccess()));
  }

  void _onFetchAllBlogs(
    BlogFetchAllBlogs event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _getAllBlogs(NoParams());

    res.fold((l) => emit(BlogFailure(mapFailureToMessage(l))), (r) => emit(BlogDisplaySuccess(r)));
  }
}
