import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/entities/entities.dart';
import 'package:ulearning_app/common/themes/app_color.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_blocs.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_events.dart';
import 'package:ulearning_app/pages/home/bloc/home_page_states.dart';
import 'package:ulearning_app/pages/home/home_controller.dart';
import 'package:ulearning_app/pages/home/widgets/home_page_widgets.dart';
import 'package:ulearning_app/router/names.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late HomeController _homeController;
  late UserItem userProfile;
  @override
  void initState() {
    super.initState();
    // _homeController = HomeController(context: context);
    // _homeController.init();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userProfile = HomeController(context: context).userProfile!;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(userProfile.avatar.toString()),
      body: BlocBuilder<HomePageBlocs, HomePageStates>(
        builder: (context, state) {
          if (state.courseItem.isEmpty) {
            HomeController(context: context).init();
          } 
          return Container(
            margin: EdgeInsets.only(left: 25.w, right: 25.w),
            child: CustomScrollView(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              slivers: [
                SliverToBoxAdapter(
                  child: buildHomePageText(
                    "Hello",
                    color: AppColors.primaryThreeElementText,
                    top: 20,
                  ),
                ),
                SliverToBoxAdapter(
                  child: buildHomePageText(
                    userProfile.name ?? "",
                    color: AppColors.primaryText,
                    top: 5,
                  ),
                ),
                SliverPadding(padding: EdgeInsets.only(top: 20.h)),
                SliverToBoxAdapter(child: searchView()),
                SliverToBoxAdapter(child: slidersView(context, state)),
                SliverToBoxAdapter(child: menuView()),
                SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 0),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 1.6,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      childCount: state.courseItem.length,
                      (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              AppRouter.courseDetail,
                              arguments: {
                                "id": state.courseItem.elementAt(index).id,
                              },
                            );
                          },
                          // child: courseGrid(state.courseItem[index]),
                          child: Text("Chuyen tam thoi"),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
