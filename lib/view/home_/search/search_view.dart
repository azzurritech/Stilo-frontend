import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanna_play_app/utils/enums.dart';
import 'package:flutter_wanna_play_app/utils/extensions.dart';




import '../../../controller/search_controller.dart';
import '../../../firebase/firebase_methods.dart';

import '../../../helper/basehelper.dart';

import '../../../model/user_model.dart';
import '../../../utils/constant/colors.dart';
import '../../../utils/constant/heading_text_style.dart';

import '../../../widgets/app_bar_widget.dart';

import '../../../widgets/custom_container.dart';
import '../../../widgets/search_listview_widget.dart';
import '../../../widgets/textfield_widget.dart';


class SearchView extends StatefulWidget {
  const SearchView({
    super.key,
  });

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView>
    with SingleTickerProviderStateMixin {
  late TabController tabcontrolller;

  late TextEditingController searchController;
  @override
  void didUpdateWidget(covariant SearchView oldWidget) {
    log("changre");
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    log("changre");
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    getUserData();
    tabcontrolller = TabController(length: 6, vsync: this);
    searchController = TextEditingController();
    // tabcontrolller.animateTo(widget.index);
    // TODO: implement initState
    super.initState();
  }

  getUserData() async {
    await FirebaseMethod.getUserData();
  }

  UserModel? users;
  String? query;
  List<DocumentSnapshot<UserModel>>? doc;

  void querFunc() {
    doc = doc?.where((element) {
      return element
          .data()!
          .city
          .toLowerCase()
          .contains(query.toString().toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarWidget(
        background: Colors.transparent,
        title: 'Search',
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
            child: TextFields(
              controller: searchController,
              height: height * 0.06,
              onChanged: (p0) {
                setState(() {
                  query = p0;
                });
              },
              text: context.loc.searchCountryCity,
              suffixicon: const Icon(Icons.search),
            ),
          ),
          DefaultTabController(
            length: 6,
            child: TabBar(
                controller: tabcontrolller,
                indicatorColor: Colors.transparent,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                tabs:  [
                  Text(
                    context.loc.all,
                  ),
                  Text(
                   context.loc.coach,
                  ),
                  Text(
                    context.loc.player,
                  ),
                  Text(
                    context.loc.club,
                  ),
                  Text(context.loc.paddle),
                  Text(context.loc.physiotherapist)
                ]),
          ),
          const Divider(
            height: 20,
            thickness: 3,
            color: AppColor.maincolor,
          ),
          Expanded(
            child: TabBarView(
              controller: tabcontrolller,
              children: [
                StreamBuilder(
                    stream: BaseHelper.firestore
                        .collection('users')
                        .withConverter(
                            fromFirestore: UserModel.fromFireStore,
                            toFirestore: (UserModel user, options) =>
                                user.toFireStore())
                        .where('email',
                            isNotEqualTo:
                                BaseHelper.currentUser?.email.toString())
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        doc = snapshot.data?.docs;

                        if (query != null && query != "") {
                          querFunc();
                        }
                        if (doc?.isEmpty??false) {
                          return Center(
                            child: Text(
                              "No record found",
                              style: heading22BlackStyle,
                            ),
                          );
                        } else {
                          return allUsers(height);
                        }
                      } else if (!snapshot.hasData) {
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        log("done");
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      return Container();
                    }),
                StreamBuilder(
                    stream: BaseHelper.firestore
                        .collection('users')
                        .withConverter(
                            fromFirestore: UserModel.fromFireStore,
                            toFirestore: (UserModel user, options) =>
                                user.toFireStore())
                        .where('role', isEqualTo:'coach')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        doc = snapshot.data?.docs
                            .where((element) => !element.data().email.contains(
                                BaseHelper.currentUser!.email.toString()))
                            .toList();

                        if (query != null && query != "") {
                          querFunc();
                        }
                        if (doc?.isEmpty??false) {
                          return Center(
                            child: Text(
                             context.loc.norecordfound,
                              style: heading22BlackStyle,
                            ),
                          );
                        } else {
                          return searchListViewWidget(
                            doc,
                            users,
                            true,
                          );
                        }
                      } else if (!snapshot.hasData) {
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      return Container();
                    }),
                StreamBuilder(
                    stream: BaseHelper.firestore
                        .collection('users')
                        .withConverter(
                            fromFirestore: UserModel.fromFireStore,
                            toFirestore: (UserModel user, options) =>
                                user.toFireStore())
                        .where('role', isEqualTo: 'player')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        doc = snapshot.data?.docs
                            .where((element) => !element.data().email.contains(
                                BaseHelper.currentUser!.email.toString()))
                            .toList();

                        if (query != null && query != "") {
                          querFunc();
                        }
                        if (doc?.isEmpty??false) {
                          return Center(
                            child: Text(
                             context.loc.norecordfound,
                              style: heading22BlackStyle,
                            ),
                          );
                        } else {
                          return searchListViewWidget(doc, users, true);
                        }
                      } else if (!snapshot.hasData) {
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      return Container();
                    }),
                StreamBuilder(
                    stream: BaseHelper.firestore
                        .collection('users')
                        .withConverter(
                            fromFirestore: UserModel.fromFireStore,
                            toFirestore: (UserModel user, options) =>
                                user.toFireStore())
                        .where('role', isEqualTo: 'club')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        doc = snapshot.data?.docs
                            .where((element) => !element.data().email.contains(
                                BaseHelper.currentUser!.email.toString()))
                            .toList();

                        if (query != null && query != "") {
                          querFunc();
                        }
                        if (doc?.isEmpty??false) {
                          return Center(
                            child: Text(
                              context.loc.norecordfound,
                              style: heading22BlackStyle,
                            ),
                          );
                        } else {
                          return searchListViewWidget(doc, users, false);
                        }
                      } else if (!snapshot.hasData) {
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      return Container();
                    }),
                StreamBuilder(
                    stream: BaseHelper.firestore
                        .collection('users')
                        .withConverter(
                            fromFirestore: UserModel.fromFireStore,
                            toFirestore: (UserModel user, options) =>
                                user.toFireStore())
                        .where('role', isEqualTo: 'Paddle')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        doc = snapshot.data?.docs
                            .where((element) => !element.data().email.contains(
                                BaseHelper.currentUser!.email.toString()))
                            .toList();

                        if (query != null && query != "") {
                          querFunc();
                        }
                        if (doc?.isEmpty??false) {
                          return Center(
                            child: Text(
                             context.loc.norecordfound,
                              style: heading22BlackStyle,
                            ),
                          );
                        } else {
                          return searchListViewWidget(doc, users, true);
                        }
                      } else if (!snapshot.hasData) {
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      return Container();
                    }),
                StreamBuilder(
                    stream: BaseHelper.firestore
                        .collection('users')
                        .withConverter(
                            fromFirestore: UserModel.fromFireStore,
                            toFirestore: (UserModel user, options) =>
                                user.toFireStore())
                        .where('role', isEqualTo: 'Fisioterapista')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        doc = snapshot.data?.docs
                            .where((element) => !element.data().email.contains(
                                BaseHelper.currentUser!.email.toString()))
                            .toList();

                        if (query != null && query != "") {
                          querFunc();
                        }
                        if (doc?.isEmpty??false) {
                          return Center(
                            child: Text(
                             context.loc.norecordfound,
                              style: heading22BlackStyle,
                            ),
                          );
                        } else {
                          return searchListViewWidget(doc, users, false);
                        }
                      } else if (!snapshot.hasData) {
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      return Container();
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListView allUsers(double height) {
    return ListView.separated(
        itemCount: doc?.length ?? 0,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: ((context, index) {
          log("  value ${BaseHelper.user!.friends!.contains(doc?[index].data()?.email)}");
          users = doc?[index].data();
          return ContainerListTile(
            isPremiumAcc: users?.isPremiumAcc ?? false,
            ontap: () async {
              doc?[index].data()?.role == RoleName.club
                  ? await 
                  GeneralSearchController.selectedClub(
                      context, doc?[index].data()?.email ?? '')
                  : await GeneralSearchController.chechkFriend(
                      context, doc?[index].data()?.email ?? '');
            },
            friend:
                BaseHelper.user!.friends!.contains(doc?[index].data()?.email),
            imagee: users?.profilePhoto ?? '',
            titletext: users?.name ?? "",
            subtitle: users?.city ?? "",
            role:users?.role  ,
            ratingValue:
                double.tryParse(users?.federationRanking ?? '0.0') ?? 0.0,
          );
        }),
        separatorBuilder: (BuildContext context, int index) => const Divider(
              height: 1,
              thickness: 1.2,
              color: AppColor.maincolor,
            ));
  }
}
