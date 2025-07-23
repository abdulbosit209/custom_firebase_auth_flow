import 'package:authentication_repository/authentication_repository.dart';
import 'package:custom_firebase_login/auth/authentication/authentication_view_model.dart';
import 'package:custom_firebase_login/config/route_config.dart';
import 'package:custom_firebase_login/core/utils/internal_notification/notify_service.dart';
import 'package:custom_firebase_login/core/utils/navigation/router_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerSingleton<RouterService>(
    RouterService(supportedRoutes: routes),
  );
  locator.registerSingleton<NotifyService>(NotifyService());
  locator.registerSingletonAsync<AuthenticationRepository>(() async {
    final authenticationRepository = AuthenticationRepository();
    await authenticationRepository.user.first;
    return authenticationRepository;
  });
  locator.registerLazySingleton(
    () => AuthenticationViewModel(
      authenticationRepository: locator<AuthenticationRepository>(),
      routerService: locator<RouterService>(),
    ),
    dispose: (authenticationViewModel) => authenticationViewModel.dispose(),
  );
}
