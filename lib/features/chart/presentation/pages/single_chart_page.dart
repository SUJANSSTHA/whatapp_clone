import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:swipe_to/swipe_to.dart';

// import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';
// import 'dart:io';
// import 'package:flutter/material.dart';
import 'package:whatapp_clone/features/app/theme/style.dart';

class SingleChartPage extends StatefulWidget {
  const SingleChartPage({super.key});

  @override
  State<SingleChartPage> createState() => _SingleChartPageState();
}

class _SingleChartPageState extends State<SingleChartPage> {
  final TextEditingController _textMessageController = TextEditingController();
  bool _isDispalySendButton = false;
  bool _isShowAttachWindow = false;

  @override
  void dispose() {
    _textMessageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Username"),
            Text(
              "Online",
              style: TextStyle(
                fontSize: 11,
                color: Colors.white.withAlpha(200),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.videocam_rounded,
              size: 25,
              color: whiteColor,
            ),
          ),
          SizedBox(width: 15),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.call,
              size: 25,
              color: whiteColor,
            ),
          ),
          SizedBox(width: 15),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              size: 25,
              color: whiteColor,
            ),
          ),
          SizedBox(width: 15),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          if (_isShowAttachWindow) {
            setState(() => _isShowAttachWindow = false);
          }
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/whatsapp_bg_image.png",
                fit: BoxFit.cover,
              ),
            ),
            // main column with messages and input; add bottom padding for keyboard
            Padding(
              padding: EdgeInsets.only(bottom: bottomInset),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        _messageLayout(
                          message: "Hello, how are you?",
                          alignment: Alignment.centerRight,
                          createAt: Timestamp.now(),
                          isSeen: false,
                          isShowTick: true,
                          messageBgColor: messageColor,
                          onLongPress: () {},
                          onSwipe: () {},
                        ),
                        _messageLayout(
                          message: "Hello, I am fine?",
                          alignment: Alignment.centerLeft,
                          createAt: Timestamp.now(),
                          isSeen: false,
                          isShowTick: true,
                          messageBgColor: senderMessageColor,
                          onLongPress: () {},
                          onSwipe: () {},
                        ),
                        _messageLayout(
                          message: "k gardai xas",
                          alignment: Alignment.centerRight,
                          createAt: Timestamp.now(),
                          isSeen: false,
                          isShowTick: true,
                          messageBgColor: messageColor,
                          onLongPress: () {},
                          onSwipe: () {},
                        ),
                        _messageLayout(
                          message: "Coding garira xu",
                          alignment: Alignment.centerLeft,
                          createAt: Timestamp.now(),
                          isSeen: false,
                          isShowTick: false,
                          messageBgColor: senderMessageColor,
                          onLongPress: () {},
                          onSwipe: () {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 10,
                      top: 5,
                    ),
                    color: appBarColor,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: searchBarColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            height: 50,
                            child: TextField(
                              onTap: () {
                                if (_isShowAttachWindow) {
                                  setState(() => _isShowAttachWindow = false);
                                }
                              },
                              controller: _textMessageController,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  setState(() {
                                    _isDispalySendButton = true;
                                  });
                                } else {
                                  setState(() {
                                    _isDispalySendButton = false;
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 2,
                                  vertical: 15,
                                ),
                                border: InputBorder.none,
                                hintText: "message",
                                prefixIcon: Icon(
                                  Icons.emoji_emotions_outlined,
                                  color: greyColor,
                                ),
                                suffixIcon: Wrap(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        // toggle attach window and dismiss keyboard
                                        FocusScope.of(context).unfocus();
                                        setState(() {
                                          _isShowAttachWindow = !_isShowAttachWindow;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.attach_file,
                                        color: greyColor,
                                        size: 25,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.camera_alt,
                                        color: greyColor,
                                        size: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            color: tabColor,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Icon(
                            _isDispalySendButton ? Icons.send : Icons.mic,
                            color: whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // attach window: show only when toggled and position above keyboard
            if (_isShowAttachWindow)
              Positioned(
                right: 15,
                left: 15,
                bottom: 65 + bottomInset,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: bottomAttachContainerColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: _attachWindowItem(
                                icon: Icons.document_scanner,
                                color: Colors.deepPurpleAccent,
                                title: "Document",
                              ),
                            ),
                            Flexible(
                              child: _attachWindowItem(
                                icon: Icons.camera_alt,
                                color: Colors.pinkAccent,
                                title: "Camera",
                              ),
                            ),
                            Flexible(
                              child: _attachWindowItem(
                                icon: Icons.insert_photo,
                                color: Colors.purpleAccent,
                                title: "Gallery",
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: _attachWindowItem(
                                icon: Icons.headphones,
                                color: Colors.deepOrange,
                                title: "Audio",
                              ),
                            ),
                            Flexible(
                              child: _attachWindowItem(
                                icon: Icons.location_on,
                                color: Colors.green,
                                title: "Location",
                              ),
                            ),
                            Flexible(
                              child: _attachWindowItem(
                                icon: Icons.account_circle,
                                color: Colors.deepPurpleAccent,
                                title: "Contact",
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: _attachWindowItem(
                                icon: Icons.bar_chart,
                                color: tabColor,
                                title: "Poll",
                              ),
                            ),
                            Flexible(
                              child: _attachWindowItem(
                                icon: Icons.gif_box_outlined,
                                color: Colors.indigoAccent,
                                title: "Camera",
                                onTap: () {},
                              ),
                            ),
                            Flexible(
                              child: _attachWindowItem(
                                icon: Icons.video_call_rounded,
                                color: Colors.lightGreen,
                                title: "Video",
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  //* message item widget
  Padding _messageLayout({
    Color? messageBgColor,
    Alignment? alignment,
    Timestamp? createAt,
    String? message,
    bool? isShowTick,
    VoidCallback? onSwipe,
    bool? isSeen,
    double? rightPadding,
    VoidCallback? onLongPress,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: SwipeTo(
        onRightSwipe: onSwipe != null ? (_) => onSwipe() : null,
        child: GestureDetector(
          onLongPress: onLongPress,
          child: Container(
            alignment: alignment,
            child: Stack(children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                    ),
                    padding: const EdgeInsets.only(
                      left: 5,
                      right: 85,
                      top: 5,
                      bottom: 5,
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.80,
                    ),
                    decoration: BoxDecoration(
                      color: messageBgColor ?? messageBgColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "$message",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                ],
              ),
              Positioned(
                bottom: 4,
                right: rightPadding ?? 10,
                child: Row(
                  children: [
                    Text(
                      createAt != null
                          ? DateFormat('hh:mm a').format(
                              createAt.toDate(),
                            )
                          : '',
                      style: TextStyle(
                        fontSize: 12,
                        color: greyColor,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    isShowTick == true
                        ? Icon(
                            isSeen == true ? Icons.done_all_rounded : Icons.done,
                            size: 16,
                            color: isSeen == true ? Colors.blue : greyColor,
                          )
                        : Container(),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  //* attach window item widget
  Widget _attachWindowItem({
    required IconData icon,
    required Color color,
    required String title,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: color,
            ),
            child: Icon(
              icon,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: TextStyle(
              color: greyColor,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}