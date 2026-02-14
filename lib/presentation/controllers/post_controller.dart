import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../data/models/post_model.dart';
import '../../data/repositories/post_repository.dart';

class PostController extends GetxController {
  final PostRepository _repository = PostRepository();

  List<PostModel> posts = [];
  bool isLoading = true;
  String errorMessage = '';
  bool isMoreLoading = false;

  // Pagination Logic
  int page = 1;
  final int _limit = 10;
  bool _hasMore = true;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    refreshPosts(); // Initial load acts like a refresh
    scrollController.addListener(_onScroll);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> fetchPosts() async {
    try {
      if (page == 1) {
        isLoading = true;
        errorMessage = ''; // Clear previous errors on new fetch
        update();
      } else {
        isMoreLoading = true;
        update();
      }

      final newPosts = await _repository.fetchPosts(page, _limit);

      if (newPosts.length < _limit) {
        _hasMore = false;
      }

      if (page == 1) {
        posts.assignAll(newPosts);
      } else {
        posts.addAll(newPosts);
      }
    } catch (e) {
      if (page == 1) {
        // If initial load fails (and no cache), show specific error message
        String errorString = e.toString();
        if (errorString.contains('SocketException') ||
            errorString.contains('Connection refused') ||
            errorString.contains('Network is unreachable')) {
          errorMessage = 'No Internet Connection';
        } else if (errorString.contains('404')) {
          errorMessage = 'Data not found';
        } else if (errorString.contains('500')) {
          errorMessage = 'Server Error. Please try again later.';
        } else {
          errorMessage = errorString;
        }

        posts.clear(); // Ensure empty state triggers
      } else {
        // If pagination fails, show snackbar and decrement page
        if (page > 1) page--;
        Get.snackbar(
          'Error',
          'No Internet Connection Available',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }

      debugPrint('Error fetching posts: $e');
    } finally {
      isLoading = false;
      isMoreLoading = false;
      update();
    }
  }

  Future<void> refreshPosts() async {
    posts.clear();
    page = 1;
    _hasMore = true;
    errorMessage = '';
    await fetchPosts();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      if (!isLoading && !isMoreLoading && _hasMore) {
        page++;
        fetchPosts();
      }
    }
  }
}
