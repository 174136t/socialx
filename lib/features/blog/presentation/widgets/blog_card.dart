import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socialx/core/theme/app_pallette.dart';
import 'package:socialx/core/utils/bounce_tap.dart';
import 'package:socialx/core/utils/calculate_reading_time.dart';
import 'package:socialx/features/blog/domain/entities/blog.dart';
import 'package:socialx/features/blog/presentation/pages/blog_viewer.page.dart';
import 'package:socialx/features/blog/presentation/widgets/overlay_message_box.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCard({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    return BounceTap(
      onTap: (){
        Navigator.push(context, BlogViewerPage.route(blog));
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: blog.imageUrl,
                fit: BoxFit.cover,
                height: 200,
                width: MediaQuery.of(context).size.width,
                placeholder:
                    (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        color: Colors.white,
                      ),
                    ),
                errorWidget:
                    (context, url, error) =>
                        const Center(child: Icon(Icons.error)),
              ),
            ),
          ),
          Container(
            height: 200,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              // color: color,
              borderRadius: BorderRadius.circular(8),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            blog.topics
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Chip(
                                      label: Text(
                                        e,
                                        style: TextStyle(
                                          color: AppPallete.whiteColor,
                                        ),
                                      ),
                                      color: WidgetStatePropertyAll(
                                        AppPallete.gradient2.withAlpha(150),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                    OverlayMessageBox(title: blog.title, fontSize: 20),
                  ],
                ),
                Column(
                  children: [
                    OverlayMessageBox(
                      title: '${calculateReadingTime(blog.content)} min',
                      fontSize: 12,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
