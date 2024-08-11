part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initRouter();
  _initInternetConnectionChecker();
  _initAuth();
  _initSessionManager();
  _initProducts();
}

void _initRouter() {
  final router = RoutesProvider().router;
  serviceLocator.registerSingleton<GoRouter>(router);
}

void _initInternetConnectionChecker() {
  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      internetConnection: serviceLocator(),
    ),
  );
}

void _initSessionManager() {
  serviceLocator.registerSingleton(UserSessionManager());
}

void _initAuth() {
  serviceLocator

    //Auth Remote Data Source
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(),
    )

    //Auth Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: serviceLocator(),
        connectionChecker: serviceLocator(),
      ),
    )

    //Login Usecase
    ..registerFactory(
      () => UserLogin(authRepository: serviceLocator()),
    )

    //Signup Usecase
    ..registerFactory(
      () => UserSignup(authRepository: serviceLocator()),
    )

    //Session Usecase
    ..registerFactory(
      () => UserSession(authRepository: serviceLocator()),
    )

    //Login Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userLogin: serviceLocator(),
        userSignup: serviceLocator(),
        userSession: serviceLocator(),
      ),
    );
}

void _initProducts() {
  serviceLocator

    //Products Remote Data Source
    ..registerFactory<ProductsRemoteDataSource>(
      () => ProductsRemoteDataSourceImpl(),
    )

    //Products Repository
    ..registerFactory<ProductsRepository>(
      () => ProductsRepositoryImpl(
        dataSource: serviceLocator(),
      ),
    )

    //Products Usecase
    ..registerFactory(
      () => ProductsUsecase(
        repository: serviceLocator(),
      ),
    )

    //Login Bloc
    ..registerLazySingleton(() => ProductsBloc(
          productsUsecase: serviceLocator(),
        ));
}
