import 'package:flutter/material.dart';
import 'package:socialx/core/utils/calculate_reading_time.dart';
import 'package:socialx/features/blog/domain/entities/blog.dart';
import 'package:socialx/features/blog/presentation/pages/blog_viewer.page.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCard({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, BlogViewerPage.route(blog));
      },
      child: Container(
        height: 200,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children:
                        blog.topics
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Chip(label: Text(e)),
                              ),
                            )
                            .toList(),
                  ),
                  Text(
                    blog.title,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            Column(
              children: [Text('${calculateReadingTime(blog.content)} min')],
            ),
          ],
        ),
      ),
    );
  }
}
