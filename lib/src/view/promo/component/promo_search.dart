import 'package:ciwalk/src/data/models/event/event.dart';
import 'package:ciwalk/src/data/models/promo/promo.dart';
import 'package:ciwalk/src/data/models/resource.dart';
import 'package:ciwalk/src/repositories/promo.dart';
import 'package:ciwalk/src/view/homepage/component/promo.card.dart';
import 'package:ciwalk/src/view/promo/promo_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class PromoSearchDelegate extends SearchDelegate<Event> {
  final PromoRepository promoRepository = PromoRepository();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_rounded),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<Resource<List<Promo>>>(
        future: promoRepository.getPromos(limit: 5, query: query.toLowerCase()),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator.adaptive().centered();
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 260,
            ),
            itemCount: snapshot.data?.data!.length,
            itemBuilder: (context, index) {
              final promo = snapshot.data!.data![index];
              return PromoCard(
                promo: promo,
                onTap: () => openDetail(promo),
              );
            },
          );
        });
  }

  openDetail(Promo promo) async {
    Get.toNamed(PromoDetailScreen.routeName, arguments: promo);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<Resource<List<Promo>>>(
        future: promoRepository.getPromos(limit: 5, query: query.toLowerCase()),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator.adaptive().centered();
          }
          var promos = snapshot.data?.data?.where((promo) =>
              promo.title!.toLowerCase().contains(query.toLowerCase()));
          return GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 260,
            ),
            children: promos!
                .map((promo) => PromoCard(
                      promo: promo,
                      onTap: () => openDetail(promo),
                    ))
                .toList(),
          );
        });
  }
}
