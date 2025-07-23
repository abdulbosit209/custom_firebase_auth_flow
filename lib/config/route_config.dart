
import 'package:custom_firebase_login/auth/login/view/login_page.dart';
import 'package:custom_firebase_login/auth/sign_up/view/sign_up_page.dart';
import 'package:custom_firebase_login/core/utils/navigation/route_data.dart';
import 'package:custom_firebase_login/home/view/home_view.dart';
import 'package:custom_firebase_login/not_found/not_found_view.dart';

final routes = [
  RouteEntry(path: '/', builder: (key, routeData) => const HomePage()),
  RouteEntry(path: '/404', builder: (key, routeData) => const NotFoundView()),
  RouteEntry(path: '/sign_up_page', builder: (key, routeData) => const SignUpPage()),
  RouteEntry(path: '/login_page', builder: (key, routeData) => const LoginPage()),
];