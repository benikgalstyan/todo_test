import 'package:todo/core/logger/composite_logger.dart';
import 'package:todo/core/logger/composite_logger_impl.dart';
import 'package:todo/data/service/network_service/error_parser.dart';
import 'package:todo/data/repository/repository.dart';
import 'package:todo/data/repository/repository_impl.dart';
import 'package:todo/data/service/local_storage/shared_pref_storage_service.dart';
import 'package:todo/data/service/network_service/dio_network_service_impl.dart';
import 'package:todo/data/service/network_service/network_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final getIt = GetIt.instance;
final getDio = getIt.get<Dio>();
final getLogger = getIt.call<CompositeLogger>();

void setupServicesLocator() {
  final dio = Dio();
  // Error parser
  dio.interceptors.add(ErrorInterceptors(dio));

  getIt.registerSingleton<Dio>(dio);

  final localeStorage = SharedPrefsStorageService();
  final networkService = DioNetworkServiceImpl(getDio);

  getIt.registerSingleton<CompositeLogger>(
    CompositeLoggerImpl(logger: Logger()),
  );

  getIt.registerSingleton<NetworkService>(networkService);
  getIt.registerSingleton<Repository>(
    RepositoryImpl(
      localStorageService: localeStorage,
      networkService: networkService,
    ),
  );
}
