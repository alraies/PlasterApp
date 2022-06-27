import 'package:efood_multivendor/controller/OrgController.dart';
import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/banner_controller.dart';

import 'package:efood_multivendor/controller/location_controller.dart';
import 'package:efood_multivendor/controller/notification_controller.dart';

import 'package:efood_multivendor/controller/splash_controller.dart';

import 'package:efood_multivendor/data/model/response/config_model.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/web_menu_bar.dart';
import 'package:efood_multivendor/view/screens/home/web_home_screen.dart';
import 'package:efood_multivendor/view/screens/main/widget/org_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrgScreen extends StatelessWidget {
  static Future<void> loadData(bool reload) async {
    Get.find<OrgController>().getOrgList(reload);
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    loadData(false);
    ConfigModel _configModel = Get.find<SplashController>().configModel;

    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context) ? WebMenuBar() : null,
      backgroundColor: ResponsiveHelper.isDesktop(context)
          ? Theme.of(context).cardColor
          : null,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Get.find<OrgController>().getOrgList(true);
          },
          child: ResponsiveHelper.isDesktop(context)
              ? WebHomeScreen(scrollController: _scrollController)
              : CustomScrollView(
                  controller: _scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  slivers: [
                    // App Bar
                    SliverAppBar(
                      floating: true,
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      backgroundColor: ResponsiveHelper.isDesktop(context)
                          ? Colors.transparent
                          : Theme.of(context).backgroundColor,
                      title: Center(
                          child: Container(
                        width: Dimensions.WEB_MAX_WIDTH,
                        height: 50,
                        color: Theme.of(context).backgroundColor,
                        child: Row(children: [
                          Expanded(
                              child: InkWell(
                            onTap: () => Get.toNamed(
                                RouteHelper.getAccessLocationRoute('home')),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: Dimensions.PADDING_SIZE_SMALL,
                                horizontal: ResponsiveHelper.isDesktop(context)
                                    ? Dimensions.PADDING_SIZE_SMALL
                                    : 0,
                              ),
                              child: GetBuilder<LocationController>(
                                  builder: (locationController) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      locationController
                                                  .getUserAddress()
                                                  .addressType ==
                                              'home'
                                          ? Icons.home_filled
                                          : locationController
                                                      .getUserAddress()
                                                      .addressType ==
                                                  'office'
                                              ? Icons.work
                                              : Icons.location_on,
                                      size: 20,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .color,
                                    ),
                                    SizedBox(width: 10),
                                    Flexible(
                                      child: Text(
                                        locationController
                                            .getUserAddress()
                                            .address,
                                        style: robotoRegular.copyWith(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .color,
                                          fontSize: Dimensions.fontSizeSmall,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Icon(Icons.arrow_drop_down,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .color),
                                  ],
                                );
                              }),
                            ),
                          )),
                          InkWell(
                            child: GetBuilder<NotificationController>(
                                builder: (notificationController) {
                              bool _hasNewNotification = false;
                              if (notificationController.notificationList !=
                                  null) {
                                _hasNewNotification = notificationController
                                        .notificationList.length !=
                                    notificationController
                                        .getSeenNotificationCount();
                              }
                              return Stack(children: [
                                Icon(Icons.notifications,
                                    size: 25,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .color),
                                _hasNewNotification
                                    ? Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          height: 10,
                                          width: 10,
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                width: 1,
                                                color: Theme.of(context)
                                                    .cardColor),
                                          ),
                                        ))
                                    : SizedBox(),
                              ]);
                            }),
                            onTap: () =>
                                Get.toNamed(RouteHelper.getNotificationRoute()),
                          ),
                        ]),
                      )),
                    ),

                    SliverToBoxAdapter(
                      child: Center(
                          child: SizedBox(
                        width: Dimensions.WEB_MAX_WIDTH,
                        child: Column(children: [
                          GetBuilder<OrgController>(builder: (orgController) {
                            return orgController.orgList == null
                                ? OrgView(orgController: orgController)
                                : orgController.orgList.length == 0
                                    ? SizedBox()
                                    : OrgView(orgController: orgController);
                          }),
                        ]),
                      )),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
