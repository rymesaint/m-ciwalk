import 'package:ciwalk/src/data/models/event/event.dart';
import 'package:ciwalk/src/data/models/movie/movie.dart';
import 'package:ciwalk/src/data/models/promo/promo.dart';
import 'package:ciwalk/src/data/models/resource.dart';
import 'package:ciwalk/src/data/models/tenant/tag.dart';
import 'package:ciwalk/src/repositories/event.dart';
import 'package:ciwalk/src/repositories/movie.dart';
import 'package:ciwalk/src/repositories/promo.dart';
import 'package:ciwalk/src/repositories/tag.dart';
import 'package:ciwalk/src/view/events/event_detail_screen.dart';
import 'package:ciwalk/src/view/events/events_screen.dart';
import 'package:ciwalk/src/view/maps/map_screen.dart';
import 'package:ciwalk/src/view/movies/movie_detail_screen.dart';
import 'package:ciwalk/src/view/movies/movies_screen.dart';
import 'package:ciwalk/src/view/promo/promo_detail_screen.dart';
import 'package:ciwalk/src/view/promo/promo_screen.dart';
import 'package:ciwalk/src/view/tags/tags_screen.dart';
import 'package:ciwalk/src/view_models/base.vm.dart';
import 'package:ciwalk/src/view_models/dashboard.vm.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';

class HomepageViewModel extends BaseViewModel {
  final FirebaseAnalytics _firebaseAnalytics = FirebaseAnalytics.instance;
  final loadingEvent = false.obs;
  final loadingPromo = false.obs;
  final loadingMovie = false.obs;
  final tagResults = Resource<List<Tag>>(data: []).obs;
  final eventResults = Resource<List<Event>>(data: []).obs;
  final promoResults = Resource<List<Promo>>(data: []).obs;
  final movieResults = Resource<List<Movie>>(data: []).obs;
  final dashboardVm = Get.put(DashboardViewModel());

  @override
  void onInit() {
    _fetchTags();
    _fetchEvents();
    _fetchPromos();
    _fetchMovies();
    super.onInit();
  }

  _fetchTags() async {
    var response = await TagRepository().getTags();
    tagResults.update((val) => val?.data = response.data);
  }

  _fetchEvents() async {
    loadingEvent(true);
    var response = await EventRepository().getEvents(start: 0, limit: 4);
    loadingEvent(false);
    eventResults.value.data = response.data;
  }

  goToEvents() {
    Get.toNamed(EventsScreen.routeName);
  }

  _fetchPromos() async {
    loadingPromo(true);
    var response = await PromoRepository().getPromos(start: 0, limit: 10);
    loadingPromo(false);
    promoResults.value.data = response.data;
  }

  goToPromo() {
    Get.toNamed(PromoScreen.routeName);
  }

  _fetchMovies() async {
    loadingMovie(true);
    var response = await MovieRepository().getMovies(start: 0, limit: 6);
    loadingMovie(false);
    movieResults.value.data = response.data;
  }

  openDetail(Event event) {
    Get.toNamed(EventDetailScreen.routeName, arguments: event);
  }

  goToMovies() {
    Get.toNamed(MoviesScreen.routeName);
  }

  openTag(Tag tag) {
    Get.toNamed(TagsScreen.routeName, arguments: tag);
  }

  openPromoDetail(Promo promo) async {
    await _firebaseAnalytics.logSelectPromotion(
      promotionName: promo.title,
      promotionId: promo.id,
      creativeName: promo.tenant?.name,
    );

    Get.toNamed(PromoDetailScreen.routeName, arguments: promo);
  }

  openMovieDetail(Movie movie) {
    Get.toNamed(MovieDetailScreen.routeName, arguments: movie);
  }

  openMap() {
    Get.toNamed(MapScreen.routeName);
  }

  openMenu() {
    dashboardVm.openMenu();
  }
}
