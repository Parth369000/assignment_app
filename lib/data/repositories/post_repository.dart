import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/post_model.dart';
import '../../core/constants.dart';
import '../services/api_service.dart';

class PostRepository {
  final ApiService _apiService = ApiService();

  Future<List<PostModel>> fetchPosts(int page, int limit) async {
    try {
      // Calculate 'skip' for DummyJSON pagination
      final skip = (page - 1) * limit;

      final response = await _apiService.get(
        '${ApiConstants.baseUrl}/products?limit=$limit&skip=$skip',
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final List<dynamic> data = jsonResponse['products'];

        // Cache the first page only for offline
        if (page == 1) {
          // Await to ensure saving before returning (or fire-and-forget but handle errors safely)
          // It is better to await to ensure data is written to disk.
          await _saveToCache(data);
        }

        return data.map((json) => PostModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      if (page == 1) {
        final cached = await _loadFromCache();
        if (cached.isNotEmpty) {
          return cached;
        }
        // If cache is empty, rethrow the original network error so UI shows error instead of empty list
        rethrow;
      } else {
        rethrow;
      }
    }
  }

  Future<void> _saveToCache(List<dynamic> posts) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(ApiConstants.cacheKey, jsonEncode(posts));
    } catch (e) {
      // Log error but don't break the app flow
      debugPrint('Error saving to cache: $e');
    }
  }

  Future<List<PostModel>> _loadFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString(ApiConstants.cacheKey);

      if (cachedData != null) {
        final List<dynamic> data = jsonDecode(cachedData);
        return data.map((json) => PostModel.fromJson(json)).toList();
      } else {
        // Return empty list if no cache
        return [];
      }
    } catch (e) {
      debugPrint('Error loading from cache: $e');
      return [];
    }
  }
}
