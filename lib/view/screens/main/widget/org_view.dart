import 'package:efood_multivendor/controller/OrgController.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/controller/theme_controller.dart';
import 'package:efood_multivendor/controller/wishlist_controller.dart';
import 'package:efood_multivendor/data/model/response/org_model.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/custom_image.dart';
import 'package:efood_multivendor/view/base/rating_bar.dart';
import 'package:efood_multivendor/view/base/title_widget.dart';
import 'package:efood_multivendor/view/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:get/get.dart';

import '../../../../helper/route_helper.dart';

class OrgView extends StatelessWidget {
  final OrgController orgController;

  OrgView({@required this.orgController});

  @override
  Widget build(BuildContext context) {
    List<OrgModel> _orgList = orgController.orgList;
    ScrollController _scrollController = ScrollController();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
          child: TitleWidget(
            title: 'الاقسام',
            // onTap: () => Get.toNamed(RouteHelper.getAllRestaurantRoute(isPopular ? 'popular' : 'latest')),
          ),
        ),
        SizedBox(
          height: 500,
          child: _orgList != null
              ? ListView.builder(
                  controller: _scrollController,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
                  itemCount: _orgList.length > 10 ? 10 : _orgList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          right: Dimensions.PADDING_SIZE_SMALL, bottom: 5),
                      child: InkWell(
                        onTap: () {
                          Get.to(
                            HomeScreen(
                              org: _orgList[index],
                              reload: true,
                            ),
                          );
                        },
                        child: Container(
                          height: 150,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.RADIUS_SMALL),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[
                                    Get.find<ThemeController>().darkTheme
                                        ? 700
                                        : 300],
                                blurRadius: 5,
                                spreadRadius: 1,
                              )
                            ],
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(
                                            Dimensions.RADIUS_SMALL)),
                                    child: CustomImage(
                                      image:
                                          '${Get.find<SplashController>().configModel.baseUrls.orgImageUrl}'
                                          '/${_orgList[index].photo}',
                                      height: 90,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  // DiscountTag(
                                  //   discount: _orgList[index].discount != null
                                  //       ? _orgList[index].discount.discount : 0,
                                  //   discountType: 'percent', freeDelivery: _orgList[index].freeDelivery,
                                  // ),
                                  //  _orgList[index].open == 1 ? SizedBox() : NotAvailableWidget(isRestaurant: true),
                                  Positioned(
                                    top: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                    right: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                    child: GetBuilder<WishListController>(
                                        builder: (wishController) {
                                      bool _isWished = wishController
                                          .wishRestIdList
                                          .contains(_orgList[index].orgId);
                                      return InkWell(
                                        // onTap: () {
                                        //   if(Get.find<AuthController>().isLoggedIn()) {
                                        //     _isWished ? wishController.removeFromWishList(_orgList[index].id, true)
                                        //         : wishController.addToWishList(null, _orgList[index], true);
                                        //   }else {
                                        //     showCustomSnackBar('you_are_not_logged_in'.tr);
                                        //   }
                                        // },
                                        child: Container(
                                          padding: EdgeInsets.all(Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.RADIUS_SMALL),
                                          ),
                                          child: Icon(
                                            _isWished
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            size: 15,
                                            color: _isWished
                                                ? Theme.of(context).primaryColor
                                                : Theme.of(context)
                                                    .disabledColor,
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ]),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions
                                            .PADDING_SIZE_EXTRA_SMALL),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            _orgList[index].OrgName,
                                            style: robotoMedium.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeSmall),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ]),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    );
                  },
                )
              : OrgShimmer(orgController: orgController),
        ),
      ],
    );
  }
}

class OrgShimmer extends StatelessWidget {
  final OrgController orgController;
  OrgShimmer({@required this.orgController});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          height: 150,
          width: 200,
          margin:
              EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL, bottom: 5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[300], blurRadius: 10, spreadRadius: 1)
              ]),
          child: Shimmer(
            duration: Duration(seconds: 2),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 90,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(Dimensions.RADIUS_SMALL)),
                    color: Colors.grey[300]),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 10, width: 100, color: Colors.grey[300]),
                        SizedBox(height: 5),
                        Container(
                            height: 10, width: 130, color: Colors.grey[300]),
                        SizedBox(height: 5),
                        RatingBar(rating: 0.0, size: 12, ratingCount: 0),
                      ]),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
