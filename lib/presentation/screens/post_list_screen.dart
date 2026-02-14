import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/post_controller.dart';
import '../widgets/post_tile.dart';

class PostListScreen extends GetView<PostController> {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          forceMaterialTransparency: true,
          title: const Text('Products')),
      body: GetBuilder<PostController>(
        builder: (controller) {
          // Initial Loading State (Show full screen loader only if list is empty)
          if (controller.isLoading && controller.posts.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.isNotEmpty && controller.posts.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.redAccent,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      controller.errorMessage,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: controller.refreshPosts,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (controller.posts.isEmpty) {
            return const Center(child: Text('No posts found.'));
          }

          return RefreshIndicator(
            onRefresh: controller.refreshPosts,
            child: ListView.builder(
              controller: controller.scrollController,
              // Add 1 to itemCount if we are loading more to show the indicator at the bottom
              itemCount:
                  controller.posts.length + (controller.isMoreLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == controller.posts.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2.5),
                      ),
                    ),
                  );
                }
                return PostTile(post: controller.posts[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
