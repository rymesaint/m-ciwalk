import 'package:ciwalk/src/view/about/about_screen.dart';
import 'package:ciwalk/src/view/dashboard/dashboard_screen.dart';
import 'package:ciwalk/src/view/events/event_detail_screen.dart';
import 'package:ciwalk/src/view/events/events_screen.dart';
import 'package:ciwalk/src/view/movies/movie_detail_screen.dart';
import 'package:ciwalk/src/view/movies/movies_screen.dart';
import 'package:ciwalk/src/view/onboarding/onboarding_screen.dart';
import 'package:ciwalk/src/view/promo/promo_detail_screen.dart';
import 'package:ciwalk/src/view/promo/promo_screen.dart';
import 'package:get/route_manager.dart';

final routes = [
  GetPage(
      name: OnboardingScreen.routeName, page: () => const OnboardingScreen()),
  GetPage(name: AboutScreen.routeName, page: () => const AboutScreen()),
  GetPage(name: DashboardScreen.routeName, page: () => const DashboardScreen()),
  GetPage(name: EventsScreen.routeName, page: () => EventsScreen()),
  GetPage(
      name: EventDetailScreen.routeName, page: () => const EventDetailScreen()),
  GetPage(name: PromoScreen.routeName, page: () => PromoScreen()),
  GetPage(
      name: PromoDetailScreen.routeName, page: () => const PromoDetailScreen()),
  GetPage(name: MoviesScreen.routeName, page: () => MoviesScreen()),
  GetPage(
      name: MovieDetailScreen.routeName, page: () => const MovieDetailScreen()),
];
