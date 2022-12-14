import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:restaurant_app_3/model/data/restaurant_detail.dart';
import 'package:restaurant_app_3/model/data/restaurant_list.dart';
import 'package:restaurant_app_3/provider/database_provider.dart';
import 'package:restaurant_app_3/provider/restaurant_database_provider.dart';
import 'package:restaurant_app_3/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app_3/style/customstyle.dart';
import 'package:restaurant_app_3/widgets/buttom_tombol_favorite.dart';

class DetailScreenPage extends StatelessWidget {
  final Restaurant restaurantDetailResult;
  const DetailScreenPage({
    Key? key,
    required this.restaurantDetailResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Image.asset('assets/icons/back2.png'),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: primary,
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            flexibleSpace: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Stack(
                children: <Widget>[
                  Align(
                    child: Container(
                      width: double.infinity,
                      height: 450,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://restaurant-api.dicoding.dev/images/large/${restaurantDetailResult.pictureId}",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 20,
                      color: Colors.transparent,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                InfoDetailRestaurant(
                    restaurantDetailResult: restaurantDetailResult),
                DetailPagesRestaurant(
                    restaurantDetailResult: restaurantDetailResult),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class InfoDetailRestaurant extends StatelessWidget {
  final Restaurant restaurantDetailResult;

  const InfoDetailRestaurant({Key? key, required this.restaurantDetailResult})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final RestaurantDatabaseProvider databaseProvider =
    //     Provider.of<RestaurantDatabaseProvider>(context, listen: false);
    return Consumer<RestaurantDatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorite(restaurantDetailResult.id),
          builder: ((context, snapshot) {
            var isFavorite = snapshot.data ?? false;
            var restaurantListResult = Restaurant1(
                city: restaurantDetailResult.city,
                description: restaurantDetailResult.description,
                id: restaurantDetailResult.id,
                name: restaurantDetailResult.name,
                pictureId: restaurantDetailResult.pictureId,
                rating: restaurantDetailResult.rating);
            if (snapshot.connectionState == ConnectionState.active) {
              return (CircularProgressIndicator());
            } else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      restaurantDetailResult.name,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            RatingBar(
                              initialRating: restaurantDetailResult.rating,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 15.0,
                              ratingWidget: RatingWidget(
                                full: Icon(
                                  Icons.star,
                                  color: orange,
                                ),
                                half: Icon(
                                  Icons.star_half,
                                  color: orange,
                                ),
                                empty: Icon(
                                  Icons.star_border,
                                  color: grey1,
                                ),
                              ),
                              onRatingUpdate: (rating) {},
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              restaurantDetailResult.rating.toString(),
                            ),
                            Row(
                              children: <Widget>[
                                SvgPicture.asset(
                                  'assets/icons/loc.svg',
                                  color: Colors.brown[700],
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  restaurantDetailResult.city,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                isFavorite == true
                                    ? IconButton(
                                        onPressed: () {
                                          provider.removeFavorite(
                                              restaurantListResult.id);
                                        },
                                        icon: Icon(Icons.favorite),
                                        color: Colors.red,
                                      )
                                    : IconButton(
                                        onPressed: () {
                                          provider.addFavorite(
                                              restaurantListResult);
                                        },
                                        icon: Icon(Icons.favorite_border),
                                        color: Colors.red,
                                      ),
                              ],
                            )
                            // Consumer<RestaurantDatabaseProvider>(
                            //   builder: (context,
                            //       RestaurantDatabaseProvider databaseProvider, _) {
                            //     var restaurantListResult = Restaurant1(
                            //         city: restaurantDetailResult.city,
                            //         description: restaurantDetailResult.description,
                            //         id: restaurantDetailResult.id,
                            //         name: restaurantDetailResult.name,
                            //         pictureId: restaurantDetailResult.pictureId,
                            //         rating: restaurantDetailResult.rating);
                            //     var isFavorite = snapshot.data ?? false;
                            //     switch (databaseProvider.stateDatabase) {
                            //       case ResultStateDatabase.loading:
                            //         return const CircularProgressIndicator();
                            //       case ResultStateDatabase.noData:
                            //         return Column(
                            //           crossAxisAlignment: CrossAxisAlignment.center,
                            //           children: [
                            //             isFavorite == true
                            //                 ? IconButton(
                            //                     onPressed: () {
                            //                       databaseProvider.removeFavorite(
                            //                           restaurantListResult.id);
                            //                     },
                            //                     icon: Icon(Icons.favorite),
                            //                     color: Colors.red,
                            //                   )
                            //                 : IconButton(
                            //                     onPressed: () {
                            //                       databaseProvider.addFavorite(
                            //                           restaurantListResult);
                            //                     },
                            //                     icon: Icon(Icons.favorite_border),
                            //                     color: Colors.red,
                            //                   ),
                            //           ],
                            //         );
                            //       case ResultStateDatabase.hasData:
                            //         return Column(
                            //           crossAxisAlignment: CrossAxisAlignment.center,
                            //           children: [
                            //             isFavorite == true
                            //                 ? IconButton(
                            //                     onPressed: () {
                            //                       databaseProvider.removeFavorite(
                            //                           restaurantListResult.id);
                            //                     },
                            //                     icon: Icon(Icons.favorite),
                            //                     color: Colors.red,
                            //                   )
                            //                 : IconButton(
                            //                     onPressed: () {
                            //                       databaseProvider.addFavorite(
                            //                           restaurantListResult);
                            //                     },
                            //                     icon: Icon(Icons.favorite_border),
                            //                     color: Colors.red,
                            //                   ),
                            //           ],
                            //         );
                            //       default:
                            //         return const CircularProgressIndicator(
                            //           color: primary,
                            //         );
                            //     }
                            //   },
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          }),
        );
      },
    );
  }
}

class DetailPagesRestaurant extends StatefulWidget {
  final Restaurant restaurantDetailResult;
  const DetailPagesRestaurant({Key? key, required this.restaurantDetailResult})
      : super(key: key);

  @override
  State<DetailPagesRestaurant> createState() => _DetailPagesRestaurantState();
}

class _DetailPagesRestaurantState extends State<DetailPagesRestaurant> {
  late int _activeTabView = 0;
  List<Widget> listTabView = [];

  Widget tabActive({
    required int index,
    required List<Category> food,
    required List<Category> drink,
    required List<Category> category,
  }) {
    listTabView = [
      DescribeContentDetail(
        decription: widget.restaurantDetailResult.description,
        categoryContent: category,
      ),
      ContentMenuDetailFoods(
        foodMenus: widget.restaurantDetailResult.menus.foods,
      ),
      ContentMenuDetailDrinks(
        drinkMenus: widget.restaurantDetailResult.menus.drinks,
      ),
      GiveReviewCustomer(),
    ];
    return listTabView[index];
  }

  @override
  Widget build(BuildContext context) {
    final dataRestaurantDetailProvider =
        Provider.of<RestaurantDetailProvider>(context);
    switch (dataRestaurantDetailProvider.stateDetailRestaurant) {
      case ResultStateDetail.loading:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              color: primary,
            ),
          ],
        );
      case ResultStateDetail.hashData:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30,
              child: DefaultTabController(
                length: 4,
                child: TabBar(
                  isScrollable: true,
                  indicatorPadding: const EdgeInsets.only(left: 32, right: 32),
                  unselectedLabelColor: grey1,
                  indicatorColor: primary,
                  labelColor: primary,
                  labelStyle: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                  unselectedLabelStyle: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                  onTap: (value) {
                    setState(() {
                      _activeTabView = value;
                    });
                  },
                  tabs: [
                    Tab(
                      child: Text(
                        'Deskripsi',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: dark),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Makanan',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: dark),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Minuman',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: dark),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Review Pengguna',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: dark),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            tabActive(
                index: _activeTabView,
                food: dataRestaurantDetailProvider
                    .restaurantResultDetail!.restaurant.menus.foods,
                drink: dataRestaurantDetailProvider
                    .restaurantResultDetail!.restaurant.menus.drinks,
                category: dataRestaurantDetailProvider
                    .restaurantResultDetail!.restaurant.categories)
          ],
        );
      case ResultStateDetail.error:
        return Center(
            child: Text(
                'Maaf Atas Ketidaknyamanannya, Kami Sedang Mengalami Error'));
      case ResultStateDetail.noData:
        return Center(
          child: Text(
            'Maaf Data Tidak Ditemukan Coba Cari Yang Lain',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      default:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: primary,
            ),
          ],
        );
    }
  }
}

class DescribeContentDetail extends StatelessWidget {
  final String decription;
  final List<Category> categoryContent;
  const DescribeContentDetail(
      {Key? key, required this.decription, required this.categoryContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          categoryContent.isNotEmpty
              ? SizedBox(
                  height: 40,
                  child: ListView.separated(
                    padding: EdgeInsets.only(left: 100),
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ChoiceChip(
                        disabledColor: Colors.grey[300],
                        side: BorderSide.none,
                        labelStyle: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(
                                fontSize: 15, fontWeight: FontWeight.bold),
                        label: Text(
                          categoryContent[index].name,
                          style: TextStyle(color: Colors.green[900]),
                        ),
                        selected: false,
                      );
                    },
                    separatorBuilder: (BuildContext context, _) {
                      return const SizedBox(
                        width: 7,
                      );
                    },
                    itemCount: categoryContent.length,
                  ),
                )
              : Text(''),
          ExpandableText(
            decription,
            expandText: "Baca Selengkapnya",
            maxLines: 5,
            animation: true,
            collapseText: 'Tampilkan Sedikit',
            style:
                Theme.of(context).textTheme.subtitle2!.copyWith(color: grey1),
            textAlign: TextAlign.justify,
            linkColor: primary,
          ),
          const SizedBox(
            height: 17,
          ),
          // GiveReviewCustomer(),
          SizedBox(
            height: 12,
          ),
          // GiveRatingToCustomer(),
        ],
      ),
    );
  }
}

class ContentMenuDetailFoods extends StatelessWidget {
  final List<Category> foodMenus;
  const ContentMenuDetailFoods({Key? key, required this.foodMenus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Wrap(
        spacing: 6,
        children: foodMenus
            .map((value) => ChoiceChip(
                  side: BorderSide.none,
                  disabledColor: Colors.grey[300],
                  labelStyle: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                  selected: false,
                  label: Text(
                    value.name,
                    style: TextStyle(color: Colors.green[900]),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class ContentMenuDetailDrinks extends StatelessWidget {
  final List<Category> drinkMenus;
  const ContentMenuDetailDrinks({Key? key, required this.drinkMenus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Wrap(
        spacing: 6,
        children: drinkMenus
            .map((value) => ChoiceChip(
                  disabledColor: Colors.grey[300],
                  side: BorderSide.none,
                  labelStyle: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                  selected: false,
                  label: Text(
                    value.name,
                    style: TextStyle(color: Colors.green[900]),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class GiveReviewCustomer extends StatelessWidget {
  const GiveReviewCustomer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
          ),
          SizedBox(
            height: 8,
          ),
          GiveRatingToCustomer(),
        ],
      ),
    );
  }
}

class GiveRatingToCustomer extends StatelessWidget {
  const GiveRatingToCustomer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Lihat Rating dan Review Dari Kami',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.arrow_downward,
              size: 17,
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Rating dan Review Dari Pengguna Tercinta',
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontSize: 10, color: dark, fontWeight: FontWeight.bold),
        ),
        Consumer<RestaurantDetailProvider>(
          builder: (context, RestaurantDetailProvider data, _) {
            return ListView.separated(
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                CustomerReview reviewCustomer = data
                    .restaurantResultDetail!.restaurant.customerReviews[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.blue,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(reviewCustomer.name),
                          ],
                        ),
                        Icon(
                          Icons.more_vert,
                          color: grey1,
                          size: 15,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        RatingBar(
                          initialRating: 4.5 - (index - 0.4),
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 15,
                          ratingWidget: RatingWidget(
                            full: Icon(Icons.star, color: orange),
                            half: Icon(
                              Icons.star_half,
                              color: orange,
                            ),
                            empty: Icon(
                              Icons.star_border,
                              color: grey1,
                            ),
                          ),
                          onRatingUpdate: (value) {},
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          reviewCustomer.date,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      reviewCustomer.review,
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                );
              },
              separatorBuilder: (context, _) {
                return const SizedBox(
                  height: 15,
                );
              },
              itemCount: data
                  .restaurantResultDetail!.restaurant.customerReviews.length,
            );
          },
        )
      ],
    );
  }
}




// return Padding(
    //   padding: const EdgeInsets.all(16.0),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: <Widget>[
    //       Text(restaurantDetailResult.name,
    //           style: Theme.of(context)
    //               .textTheme
    //               .headline6!
    //               .copyWith(fontWeight: FontWeight.w700)),
    //       SizedBox(
    //         height: 5.0,
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: <Widget>[
    //           Row(
    //             children: <Widget>[
    //               RatingBar(
    //                 initialRating: restaurantDetailResult.rating,
    //                 allowHalfRating: true,
    //                 itemCount: 5,
    //                 itemSize: 15.0,
    //                 ratingWidget: RatingWidget(
    //                   full: Icon(
    //                     Icons.star,
    //                     color: orange,
    //                   ),
    //                   half: Icon(
    //                     Icons.star_half,
    //                     color: orange,
    //                   ),
    //                   empty: Icon(
    //                     Icons.star_border,
    //                     color: grey1,
    //                   ),
    //                 ),
    //                 onRatingUpdate: (value) {},
    //               ),
    //               SizedBox(
    //                 width: 10,
    //               ),
    //               Text(restaurantDetailResult.rating.toString()),
    //             ],
    //           ),
    //           Row(
    //             children: <Widget>[
    //               SvgPicture.asset(
    //                 'assets/icons/loc.svg',
    //                 color: Colors.brown[700],
    //               ),
    //               const SizedBox(
    //                 width: 3,
    //               ),
    //               Text(
    //                 restaurantDetailResult.city,
    //                 style: Theme.of(context)
    //                     .textTheme
    //                     .subtitle1!
    //                     .copyWith(fontWeight: FontWeight.bold),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );