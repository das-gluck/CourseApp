import 'package:course_app/common/entities/entities.dart';
import 'package:course_app/common/routes/names.dart';
import 'package:course_app/common/values/colors.dart';
import 'package:course_app/pages/Home/bloc/home_page_bloc.dart';
import 'package:course_app/pages/Home/bloc/home_page_state.dart';
import 'package:course_app/pages/Home/home_controller.dart';
import 'package:course_app/pages/Home/widgets/home_page_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // late HomeController _homeController ;
  late UserItem userProfile;

  @override
  void initState() {
    super.initState();
    //_homeController = HomeController(context: context);
    //_homeController.init();
    // print(_homeController.userProfile!.avatar.toString());
    // print(_homeController.userProfile!.name);


  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userProfile = HomeController(context: context).userProfile;
  }

  @override
  Widget build(BuildContext context) {
    // return _homeController.userProfile!=null ? Scaffold(
    //   backgroundColor: Colors.white,
    //   appBar: buildAppBar(_homeController.userProfile!.avatar.toString()),
    //   body: BlocBuilder<HomePageBloc, HomePageState>(
    //     builder: (context, state) {
    //       return Container(
    //         //color: Colors.red,
    //         margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 0),
    //         child: CustomScrollView(
    //           slivers: [
    //             SliverToBoxAdapter(
    //               child: homePageText("Hello",
    //                   color: AppColors.primaryThirdElementText),
    //             ),
    //             SliverToBoxAdapter(
    //               child: homePageText(
    //                   _homeController.userProfile!.name!,
    //                   top: 0
    //               ),
    //             ),
    //             SliverPadding(padding: EdgeInsets.only(top: 20.h)),
    //             SliverToBoxAdapter(
    //               child: searchView(),
    //             ),
    //             SliverToBoxAdapter(
    //               child: sliderView(context, state),
    //             ),
    //             SliverToBoxAdapter(
    //               child: menuView(),
    //             ),
    //             SliverPadding(
    //               padding:
    //                   EdgeInsets.symmetric(vertical: 18.h, horizontal: 0.h),
    //               sliver: SliverGrid(
    //                 gridDelegate:
    //                     const SliverGridDelegateWithFixedCrossAxisCount(
    //                   crossAxisCount: 2,
    //                   mainAxisSpacing: 15,
    //                   crossAxisSpacing: 15,
    //                   childAspectRatio: 1.6,
    //                 ),
    //                 delegate: SliverChildBuilderDelegate(
    //                     childCount: state.courseItem.length,
    //                     (BuildContext context, int index) {
    //                   return GestureDetector(
    //                     onTap: () {},
    //                     child: courseGrid(state.courseItem[index]),
    //                   );
    //                 }),
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     },
    //   ),
    // ) : Container();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(userProfile.avatar.toString()),
      body: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          if(state.courseItem.isEmpty){
            HomeController(context: context).init();
          }
          return Container(
            //color: Colors.red,
            margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 0),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: homePageText("Hello",
                      color: AppColors.primaryThirdElementText),
                ),
                SliverToBoxAdapter(
                  child: homePageText(
                      userProfile.name??"",
                      top: 0
                  ),
                ),
                SliverPadding(padding: EdgeInsets.only(top: 20.h)),
                SliverToBoxAdapter(
                  child: searchView(),
                ),
                SliverToBoxAdapter(
                  child: sliderView(context, state),
                ),
                SliverToBoxAdapter(
                  child: menuView(),
                ),
                SliverPadding(
                  padding:
                  EdgeInsets.symmetric(vertical: 18.h, horizontal: 0.h),
                  sliver: SliverGrid(
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
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
                                AppRoutes.COURSE_DETAIL,
                                arguments: {
                                  "id": state.courseItem.elementAt(index).id,
                                }
                              );
                            },
                            child: courseGrid(state.courseItem[index]),
                          );
                        }),
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
