import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:socialx/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:socialx/core/network/connection_checker.dart';
import 'package:socialx/core/secrets/app_secrets.dart';
import 'package:socialx/features/ai_image_generate/data/datasources/image_remote_data_source.dart';
import 'package:socialx/features/ai_image_generate/data/repositories/image_repository_impl.dart';
import 'package:socialx/features/ai_image_generate/domain/repositories/image_repository.dart';
import 'package:socialx/features/ai_image_generate/domain/usecases/generate_image.dart';
import 'package:socialx/features/ai_image_generate/presentation/bloc/image_bloc.dart';
import 'package:socialx/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:socialx/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:socialx/features/auth/domain/repository/auth_repository.dart';
import 'package:socialx/features/auth/domain/usecases/current_user.dart';
import 'package:socialx/features/auth/domain/usecases/user_sign_in.dart';
import 'package:socialx/features/auth/domain/usecases/user_sign_up.dart';
import 'package:socialx/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:socialx/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:socialx/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:socialx/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:socialx/features/blog/domain/repositories/blog_repository.dart';
import 'package:socialx/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:socialx/features/blog/domain/usecases/upload_blog.dart';
import 'package:socialx/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:socialx/features/payment/data/datasources/payment_remote_data_source.dart';
import 'package:socialx/features/payment/data/repositories/payment_repository_impl.dart';
import 'package:socialx/features/payment/domain/repositories/payment_repository.dart';
import 'package:socialx/features/payment/domain/usecases/confirm_payment.dart';
import 'package:socialx/features/payment/domain/usecases/create_payment_intent.dart';
import 'package:socialx/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'init_depencancy.main.dart';
