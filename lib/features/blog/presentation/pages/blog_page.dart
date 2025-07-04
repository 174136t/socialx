import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialx/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:socialx/core/common/entities/user.dart';
import 'package:socialx/core/common/widgets/loader.dart';
import 'package:socialx/core/theme/app_pallette.dart';
import 'package:socialx/core/utils/show_snackbar.dart';
import 'package:socialx/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:socialx/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:socialx/features/blog/presentation/widgets/blog_card.dart';
import 'package:socialx/features/payment/presentation/pages/payment_tab_page.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogPage());

  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  int currentSelectedTabIndex = 0;
  final NotchBottomBarController _controller = NotchBottomBarController();
  late User user;

  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
    user = (context.read<AppUserCubit>().state as AppUserLoggedIn).user;
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
                        child: Text(
                          "Hello ${user.name},",
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'monsterrat',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.blogs.length,
                        itemBuilder: (context, index) {
                          final blogs = state.blogs.reversed.toList();
                          final blog = blogs[index];
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
              // AddNewBlogPage(),
              PaymentTabPage(),
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
          // const BottomBarItem(
          //   inActiveItem: Icon(Icons.add_circle, color: Colors.white),
          //   activeItem: Icon(Icons.add_circle, color: Colors.white),
          //   itemLabel: 'Add Blog',
          // ),
          const BottomBarItem(
            inActiveItem: Icon(Icons.person, color: Colors.white),
            activeItem: Icon(Icons.person, color: Colors.white),
            itemLabel: 'Profile',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNewBlogPage()),
          );
        },
        backgroundColor: AppPallete.whiteColor,
        child: Icon(Icons.add_circle, color: AppPallete.gradient1),
      ),
      floatingActionButtonLocation: CenteredFloatingButtonLocation(yOffset: 80),

      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}

class CenteredFloatingButtonLocation extends FloatingActionButtonLocation {
  final double yOffset;

  CenteredFloatingButtonLocation({required this.yOffset});

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    // Widths
    final double fabWidth = scaffoldGeometry.floatingActionButtonSize.width;
    final double scaffoldWidth = scaffoldGeometry.scaffoldSize.width;

    // Center X offset
    final double fabX = (scaffoldWidth - fabWidth) / 2;

    // From bottom (yOffset)
    final double fabY = scaffoldGeometry.scaffoldSize.height - yOffset;

    return Offset(fabX, fabY);
  }
}
