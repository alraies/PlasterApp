import 'package:efood_multivendor/data/api/api_client.dart';
import 'package:efood_multivendor/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class RestaurantRepo {
  final ApiClient apiClient;
  RestaurantRepo({@required this.apiClient});

  Future<Response> getRestaurantList(
      String offset, String filterBy, int orgId) async {
    return await apiClient.getData(
        '${AppConstants.RESTAURANT_URI}/$filterBy?offset=$offset&limit=10&orgId=$orgId');
  }

  Future<Response> getPopularRestaurantList(String type, int orgId) async {
    return await apiClient.getData(
        '${AppConstants.POPULAR_RESTAURANT_URI}?type=$type&orgId=$orgId');
  }

  Future<Response> getLatestRestaurantList(String type, int orgId) async {
    return await apiClient.getData(
        '${AppConstants.LATEST_RESTAURANT_URI}?type=$type&orgId=$orgId');
  }

  Future<Response> getRestaurantDetails(String restaurantID) async {
    return await apiClient
        .getData('${AppConstants.RESTAURANT_DETAILS_URI}$restaurantID');
  }

  Future<Response> getRestaurantProductList(
      int restaurantID, int offset, int categoryID, String type) async {
    return await apiClient.getData(
      '${AppConstants.RESTAURANT_PRODUCT_URI}?restaurant_id=$restaurantID&category_id=$categoryID&offset=$offset&limit=10&type=$type',
    );
  }

  Future<Response> getRestaurantReviewList(String restaurantID) async {
    return await apiClient.getData(
        '${AppConstants.RESTAURANT_REVIEW_URI}?restaurant_id=$restaurantID');
  }
}
