part of 'init_dependancy.dart';

final serviceLocator = GetIt.instance;



Future<void> initDependencies() async {
  _initAuthDependancies();
  _initBlogDependancies();
  _initStripeDependancies();
  _initImageDependencies();

  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
    
  );

  serviceLocator.registerLazySingleton(() => Dio());

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerLazySingleton(() => Hive.box(name: 'blogs'));

  serviceLocator.registerFactory(() => InternetConnection());

  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(serviceLocator()),
  );
}

void _initAuthDependancies() {
  // dataSource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(supabaseClient: serviceLocator()),
    )
    // repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator(), serviceLocator()),
    )
    // usecases
    ..registerFactory(() => UserSignUp(serviceLocator()))
    ..registerFactory(() => UserSignIn(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))
    // bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userSignIn: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initBlogDependancies() {
  //datasource
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<BlogLocalDataSource>(
      () => BlogLocalDataSourceImpl(serviceLocator()),
    )
    //repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
    // usecases
    ..registerFactory(() => UploadBlog(serviceLocator()))
    ..registerFactory(() => GetAllBlogs(serviceLocator()))
    // bloc
    ..registerLazySingleton(
      () =>
          BlogBloc(uploadBlog: serviceLocator(), getAllBlogs: serviceLocator()),
    );
}

void _initStripeDependancies() {
  // BLoC
  serviceLocator.registerFactory(
    () => PaymentBloc(
      createPaymentIntent: serviceLocator(),
      confirmPayment: serviceLocator(),
    ),
  );

  // Use cases
  serviceLocator.registerLazySingleton(() => CreatePaymentIntent(serviceLocator()));
  serviceLocator.registerLazySingleton(() => ConfirmPayment(serviceLocator()));

  // Repository
  serviceLocator.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(
      remoteDataSource: serviceLocator(),
    ),
  );

  // Data sources
  serviceLocator.registerLazySingleton<PaymentRemoteDataSource>(
    () => PaymentRemoteDataSourceImpl(
      client: serviceLocator(),
      baseUrl: 'https://api.stripe.com', // Replace with your backend URL
      stripeSecretKey: AppSecrets.stripeSecretKey, // Replace with your Stripe secret key
    ),
  );

  // External
  // serviceLocator.registerLazySingleton<Dio>(() => Dio());
}

void _initImageDependencies() {
  // Remote Data Source
  serviceLocator.registerFactory<ImageRemoteDataSource>(
    () => ImageRemoteDataSourceImpl(dio: serviceLocator()), // pass Dio
  );

  // Repository
  serviceLocator.registerFactory<ImageRepository>(
    () => ImageRepositoryImpl(remoteDataSource: serviceLocator(),),
  );

  // UseCase
  serviceLocator.registerFactory(() => GenerateImage(serviceLocator()));

  // BLoC
  serviceLocator.registerLazySingleton(
    () => ImageBloc(generateImage: serviceLocator()),
  );
}

