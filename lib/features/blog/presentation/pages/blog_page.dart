import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialx/core/common/widgets/loader.dart';
import 'package:socialx/core/theme/app_pallette.dart';
import 'package:socialx/core/utils/show_snackbar.dart';
import 'package:socialx/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:socialx/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:socialx/features/blog/presentation/widgets/blog_card.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogPage());

  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  int currentSelectedTabIndex = 0;
  final NotchBottomBarController _controller = NotchBottomBarController();

  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Blog Page'),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         Navigator.push(context, AddNewBlogPage.route());
      //       },
      //       icon: Icon(CupertinoIcons.add_circled),
      //     ),
      //   ],
      // ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          if (state is BlogDisplaySuccess) {
            return <Widget>[
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text("Hello Lahiru,", style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'monsterrat',
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                      SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.blogs.length,
                        itemBuilder: (context, index) {
                          final blog = state.blogs[index];
                          return BlogCard(
                            blog: blog,
                            color:
                                index % 3 == 0
                                    ? AppPallete.gradient1
                                    : index % 3 == 1
                                    ? AppPallete.gradient2
                                    : AppPallete.gradient3,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              AddNewBlogPage(),
            ][currentSelectedTabIndex];
          }

          return const SizedBox();
        },
      ),
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        onTap: (index) {
          setState(() {
            currentSelectedTabIndex = index;
          });
        },
        bottomBarItems: [
          const BottomBarItem(
            inActiveItem: Icon(Icons.home_filled, color: Colors.white),
            activeItem: Icon(Icons.home_filled, color: Colors.white),
            itemLabel: 'Home',
          ),
          const BottomBarItem(
            inActiveItem: Icon(Icons.add_circle, color: Colors.white),
            activeItem: Icon(Icons.add_circle, color: Colors.white),
            itemLabel: 'Add Blog',
          ),
          const BottomBarItem(
            inActiveItem: Icon(Icons.book, color: Colors.white),
            activeItem: Icon(Icons.book, color: Colors.white),
            itemLabel: 'My Blogs',
          ),
        ],
        kIconSize: 24,
        kBottomRadius: 10,
        bottomBarHeight: 60,
        bottomBarWidth: screenWidth,
        removeMargins: true,
        color: AppPallete.gradient1,
        notchColor: AppPallete.gradient1,
        itemLabelStyle: TextStyle(color: Colors.white, fontSize: 12.0),
      ),
    );
  }
}
