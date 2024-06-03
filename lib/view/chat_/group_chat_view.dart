// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_wanna_play_app/controller/group_chat_controller.dart';


import 'package:intl/intl.dart';

import '../../controller/chat_controller.dart';
import '../../firebase/firebase_methods.dart';

import '../../helper/basehelper.dart';
import '../../model/chat_model.dart';
import '../../model/create_group_model.dart';
import '../../utils/constant/colors.dart';
import '../../utils/constant/heading_text_style.dart';
import '../../utils/constant/image_path.dart';
import '../../widgets/circle_widget.dart';
import 'image_preview.dart';

class GroupChatView extends StatefulWidget {
  final String groupId;

  const GroupChatView({
    Key? key,
    required this.groupId,
  }) : super(key: key);

  @override
  State<GroupChatView> createState() => _ChatwithuserState();
}

class _ChatwithuserState extends State<GroupChatView>
    with WidgetsBindingObserver {
  bool emojiShowing = false;
  late FocusNode focusNode;
  late TextEditingController messageController;

  ValueNotifier<bool> isAdmin = ValueNotifier(false);
  @override
  void initState() {
    checkAdmin();
    WidgetsBinding.instance.addObserver(this);

    focusNode = FocusNode();
    messageController = TextEditingController();
    focusNode.addListener(
      () {
        if (focusNode.hasFocus) {
          emojiShowing = false;
          setState(() {});
        }
      },
    );
    // ChatController.onChatScreen(1, widget.email);
    // ChatController.recentchatGetValue(widget.email);
    // TODO: implement initState
    super.initState();
  }

  checkAdmin() {
    for (var element in GroupChatController.groupData?.memberList ?? []) {
      if (element['isAdmin'] == true &&
          element['email'] == BaseHelper.user?.email) {
        isAdmin.value = true;
      } else if (isAdmin.value != true) {
        isAdmin.value = false;
      }

      GroupChatController.onChatScreen(
          true, GroupChatController.groupData?.groupId ?? '');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      GroupChatController.onChatScreen(
          true, GroupChatController.groupData?.groupId ?? '');
    } else if (state == AppLifecycleState.inactive) {
      GroupChatController.onChatScreen(
          false, GroupChatController.groupData?.groupId ?? '');
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    focusNode.dispose();
    GroupChatController.onChatScreen(
        false, GroupChatController.groupData?.groupId ?? '');
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          leadingWidth: 30,
          backgroundColor: AppColor.textfield_color,
          leading: BackButton(onPressed: () {
            BaseHelper.hideKeypad(context);

            Navigator.pop(context);
            // ChatController.onChatScreen(0, widget.email);
          }),
          title: Row(
            children: [
              CustomCircleAvatar(
                imageUrl: GroupChatController.groupData?.imageUrl.toString(),
                radius: 20,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                GroupChatController.groupData?.groupName.toString() ?? "",
                style: heading22BlackStyle,
              ),
            ],
          )),
      body: StreamBuilder(
          stream: FirebaseMethod.groupChatCollection(widget.groupId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      padding: const EdgeInsets.only(bottom: 10, top: 10),
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        ChatModel chatModel =
                            snapshot.data?.docs[index].data() as ChatModel;
                        bool isSameDate = false;
                        String date = '';
                        if (index == 0 && snapshot.data?.docs.length == 1) {
                          date = ChatController.groupMessageDateTime(
                              snapshot.data?.docs[index].data().timeStamp
                                  as DateTime);
                        } else if (index == snapshot.data!.docs.length - 1) {
                          date = ChatController.groupMessageDateTime(
                              snapshot.data?.docs[index].data().timeStamp
                                  as DateTime);
                        } else {
                          final currentIndexDate =
                              ChatController.returnDateTimeFormatted(
                                  snapshot.data?.docs[index].data().timeStamp
                                      as DateTime);

                          final previousIndexDate =
                              ChatController.returnDateTimeFormatted(snapshot
                                  .data?.docs[index + 1]
                                  .data()
                                  .timeStamp as DateTime);
                          isSameDate = currentIndexDate
                              .isAtSameMomentAs(previousIndexDate);
                          date = isSameDate == true
                              ? ''
                              : ChatController.groupMessageDateTime(
                                  snapshot.data?.docs[index].data().timeStamp
                                      as DateTime);
                        }

                        return Column(
                          children: [
                            if (date != '') Text(date),
                            messageView(size, chatModel)
                          ],
                        );
                      },
                    ),
                  ),
                  chatTextField(),
                  Visibility(
                      visible: emojiShowing,
                      child: SizedBox(
                          height: 250,
                          child: EmojiPicker(
                            textEditingController: messageController,
                            onBackspacePressed: () {},
                            config: const Config(
                              columns: 7,

                              emojiSizeMax: 32 * 1.0,

                              verticalSpacing: 0,
                              horizontalSpacing: 0,
                              gridPadding: EdgeInsets.zero,
                              initCategory: Category.RECENT,
                              bgColor: Color(0xFFF2F2F2),
                              indicatorColor: Colors.blue,
                              iconColor: Colors.grey,
                              iconColorSelected: Colors.blue,
                              backspaceColor: Colors.blue,
                              skinToneDialogBgColor: Colors.white,
                              skinToneIndicatorColor: Colors.grey,
                              enableSkinTones: true,
                              // showRecentsTab: true,
                              recentsLimit: 28,
                              replaceEmojiOnLimitExceed: false,
                              noRecents: Text(
                                'No Recents',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black26),
                                textAlign: TextAlign.center,
                              ),
                              loadingIndicator: SizedBox.shrink(),
                              tabIndicatorAnimDuration: kTabScrollDuration,
                              categoryIcons: CategoryIcons(),
                              buttonMode: ButtonMode.MATERIAL,
                              checkPlatformCompatibility: true,
                            ),
                          )))
                ],
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong'),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return Container();
          }),
    );
  }

  chatTextField() {
    return ValueListenableBuilder(
        valueListenable: isAdmin,
        builder: (_, value, child) {
          return Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
            child: value == false
                ? const Text("Only Admin can Send Message")
                : TextField(
                    focusNode: focusNode,
                    controller: messageController,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        onPressed: () {
                          focusNode.unfocus();

                          setState(() {
                            emojiShowing = !emojiShowing;
                          });
                        },
                        icon: Image.asset(AppAssets.emojiimg),
                      ),
                      suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: IconButton(
                            onPressed: () {
                              GroupChatController.onSendBtn(
                                  createGroupModel: GroupChatController
                                      .groupData as GroupDetailModel,
                                  messageController: messageController.text);
                              messageController.clear();
                            },
                            icon: Image.asset(AppAssets.sendimg),
                          )),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Colors.grey), //<-- SEE HERE
                      ),
                    ),
                  ),
          );
        });
  }

  messageView(
    Size size,
    ChatModel chatModel,
  ) {
    return chatModel.type == "text"
        ? Column(
            crossAxisAlignment: chatModel.sendByEmail == BaseHelper.user?.email
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Container(
                  alignment: chatModel.sendByEmail == BaseHelper.user?.email
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColor.hinttext_color,
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 12),
                    margin: chatModel.sendByEmail == BaseHelper.user?.email
                        ? const EdgeInsets.fromLTRB(130, 5, 8, 5)
                        : const EdgeInsets.fromLTRB(8, 5, 130, 5),
                    child: Text(chatModel.message,
                        style: normal14BlackStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            color:
                                chatModel.sendByEmail == BaseHelper.user?.email
                                    ? AppColor.blackcolor
                                    : AppColor.textcolor)),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 3
                    // top: 5,
                    ),
                child: Text(DateFormat('h:mm a').format(chatModel.timeStamp)),
              ),
            ],
          )
        : chatModel.type == "img"
            ? Container(
                alignment: chatModel.sendByEmail == BaseHelper.user?.email
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  width: size.width * 0.5,
                  height: size.height * 0.3,
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.fromLTRB(8, 5, 8, 2),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.maincolor),
                      color: AppColor.maincolor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: chatModel.message != ''
                      ? InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ImagePreview(image: chatModel.message),
                                ));
                          },
                          child: CachedNetworkImage(
                            imageUrl: chatModel.message,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder: (context, url, progress) {
                              return Center(
                                child: CircularProgressIndicator.adaptive(
                                  value: progress.progress,
                                ),
                              );
                            },
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator.adaptive()),
                ),
              )
            : Container(
                decoration: const BoxDecoration(color: AppColor.hinttext_color),
                child: Text(
                  chatModel.message,
                  style: title18BlackStyle,
                ),
              );
  }
}
