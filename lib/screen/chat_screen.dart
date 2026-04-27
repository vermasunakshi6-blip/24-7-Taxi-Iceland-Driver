// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:taxi_driver_24_7/widgets/common/shimmer_loader.dart';
import 'package:intl/intl.dart';
import 'package:taxi_driver_24_7/apppackages.dart';
import 'package:taxi_driver_24_7/utils/app_system_ui.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatScreen extends StatefulWidget {
  final String? rideid, senderid, reciverid;
  final String recieverName, receieverImage;
  final String? source, destination, fare, usd;
  final String? vehicleNumber, vehicleName, vehicleColor, vehicleImage;
  final bool? isScheduleRide;

  const ChatScreen(
      {super.key,
      this.rideid,
      this.senderid,
      this.reciverid,
      required this.recieverName,
      required this.receieverImage, this.source, this.destination, this.fare, this.usd, this.vehicleNumber, this.vehicleName, this.vehicleColor, this.vehicleImage, this.isScheduleRide});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  SharedPreferences? prefs;
  final TextEditingController _textController = TextEditingController();
  bool? msgSendType = false;
  Socket? socket;
  String? rideid;
  String? senderId;
  String? receiverId;
  String? messages;
  String? messageSent, senderIDSent, reciveridSent;
  ChatModelDec? chatModelDec;
  ChatModelDecNew? chatModelDecNew;
  String? dec;
  static String key =
      'SgVkYp3s6v9y/B?E(H+MbQeThWmZq4t7w!z%C&F)J@NcRfUjXn2r5u8x/A?D(G-K';
  ScrollController scrollController = ScrollController();

  List<Data> chatDetails = [];

  @override
  void initState() {
    super.initState();

    socket = io('https://taxi-api.testdrivesite.com/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket!.connect();

    socket!.onConnect((_) {
      log('Connected to Server');
    });

    socket!.on('chatMessageEnc', (message) {
      try {
        if (!mounted) return;
        // Socket may send String or already-parsed Map
        final Map<String, dynamic> parsed = message is Map<String, dynamic>
            ? message
            : Map<String, dynamic>.from(jsonDecode(message as String));
        final ChatModel chatModel = ChatModel.fromJson(parsed);
        if (chatModel.data == null || chatModel.data!.isEmpty) return;
        final Data newMessage = chatModel.data!.first;
        if (!mounted) return;
        setState(() {
          chatDetails.add(newMessage);
        });
        if (!mounted) return;
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 100),
          );
        }
      } catch (e, stack) {
        log('Chat message receive error: $e');
        log('Stack: $stack');
      }
    });

    // Disconnection listener
    socket!.onDisconnect((_) {
      log('Disconnected from server');
    });

    getData(widget.rideid);
  }

  /// Chat uses a solid blue status bar; restore app default when leaving. Call
  /// before [Navigator.push] too — push keeps this route alive so [dispose] won't run.
  void _restoreAppStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(AppSystemUi.driverDefault);
  }

  void getData(String? rideid) async {
    prefs = await SharedPreferences.getInstance();
    Timer(
        const Duration(seconds: 0),
        () => Provider.of<ChatProvider>(context, listen: false)
            .getChat(rideid, context));
    Provider.of<ProfileProvider>(context, listen: false)
        .getProfile(prefs!.getString(PrefConstant.userid), context);
  }

  @override
  Widget build(BuildContext context) {
    final chatprovider = Provider.of<ChatProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);
    if (chatprovider.chatDetails != null) {
      chatDetails = chatprovider.chatDetails!;
    }

    return 
    AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.chat,
      child: 
      Scaffold(
      backgroundColor: Colors.white,
      body: chatprovider.isloading
          ? Padding(
            padding: const EdgeInsets.only(top: 45.0),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      ShimmerLoader(count: 1, height: MediaQuery.of(context).size.height/14),
                      ShimmerLoader(count: 1, height: MediaQuery.of(context).size.height/8),
                      ShimmerLoader(count: 1, height: MediaQuery.of(context).size.height/3),
                    ],
                  ),
                ),
                Expanded(
                  flex: 0,
                  child:ShimmerLoader(count: 1, height: MediaQuery.of(context).size.height/8) )
              ],
            ),
          )
          : SafeArea(
            bottom: false,
            child: Column(
              children: [
                Container(
                  color: AppColors.redColor,
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          socket!.disconnect();
                          socket!.dispose();
                          _restoreAppStatusBar();
                          if (widget.isScheduleRide == true) {
                            Navigator.pop(context);
                          } else {
                            // Replace so chat disposes; otherwise it stays under
                            // the stack and its blue AnnotatedRegion can stick.
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RideOngoing()));
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Image(
                            height: 25,
                            image: AssetImage(AppImages.arrowback),
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  NetworkImage(widget.receieverImage),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              widget.recieverName,
                              style: whiteHeading,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                widget.vehicleName==null?
                Container(
                  color: AppColors.redColor.withOpacity(0.15),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Route',
                              style: blackTitle,
                            ),
                            Text(
                              '8mi',
                              style: blackTitle,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.source.toString(),
                                style: greyBody,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Icon(Icons.arrow_forward,color: AppColors.greyColor,size: 20,),
                            Expanded(
                              child: Text(
                                widget.destination.toString(),
                                style: greyBody,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Fare',
                              style: blackTitle,
                            ),
                            RichText(text: TextSpan(
                              text: widget.fare,
                              style: blackTitle,
                              children: [
                               
                              ]
                            ))
                          ],
                        ),
                      ],
                    ),
                  ),
                )
                :
                Container(
                  color: AppColors.redColor.withOpacity(0.15),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Vehicle Details: ',
                              style: blackTitle,
                            ),
                            Text(
                              widget.vehicleName.toString(),
                              style: greyBody,
                            ),
                            Text(
                              widget.vehicleNumber.toString(),
                              style: greyBody,
                            ),
                            Text(
                              widget.vehicleColor.toString(),
                              style: greyBody,
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white),
                          child: Image.network(
                            widget.vehicleImage.toString(),
                            width: 100,
                            height: 50,
                            errorBuilder: (context, error, stackTrace) {
                              return const CircularProgressIndicator(
                                color: AppColors.blackColor,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                  controller: scrollController,
                  itemCount: chatDetails.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    dec = decryptAESCryptoJS(chatDetails[index].chatData!, key);
                    chatModelDec = ChatModelDec.fromJson(jsonDecode(dec!));
                    DateTime dateF =
                    chatDetails[index].chateDate==null?
                    DateTime.parse(chatDetails[index].createdAt.toString()):  DateTime.fromMillisecondsSinceEpoch(int.parse(chatDetails[index].chateDate.toString()));
                    String formattedTime = DateFormat('hh:mm a').format(dateF);
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: chatModelDec!.receiverId ==
                                prefs!.getString(PrefConstant.userid)
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          chatModelDec!.receiverId !=
                                  prefs!.getString(PrefConstant.userid)
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: AppColors.redColor,
                                    backgroundImage:
                                        NetworkImage(widget.receieverImage),
                                  ),
                                )
                              : const SizedBox(),
                          Column(
                            crossAxisAlignment: chatModelDec!.receiverId ==
                                    prefs!.getString(PrefConstant.userid)
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: chatModelDec!.receiverId ==
                                            prefs!
                                                .getString(PrefConstant.userid)
                                        ? AppColors.redColor
                                        : AppColors.redColor.withOpacity(0.15),
                                    borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(8.0),
                                      topRight: const Radius.circular(8.0),
                                      bottomLeft: Radius.circular(
                                          chatModelDec!.senderId ==
                                                  prefs!.getString(
                                                      PrefConstant.userid)
                                              ? 0
                                              : 8),
                                      bottomRight: Radius.circular(
                                          chatModelDec!.senderId ==
                                                  prefs!.getString(
                                                      PrefConstant.userid)
                                              ? 8
                                              : 0.0),
                                    ),
                                  ),
                                  child: Text(
                                    chatModelDec!.messages!,
                                    style:chatModelDec!.senderId ==
                                                prefs!.getString(
                                                    PrefConstant.userid)
                                            ? blackBody:whiteBody,
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(formattedTime,
                                    style:
                                        smallGrey),
                              )
                            ],
                          ),
                          chatModelDec!.receiverId ==
                                  prefs!.getString(PrefConstant.userid)
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: AppColors.redColor,
                                    backgroundImage: NetworkImage(
                                        profileProvider
                                            .profileDetailss!.profilePic
                                            .toString()),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    );
                  },
                )),
                
                SizedBox(
                  height: 50,
                  child: ListView.separated(
                    itemCount:widget.source!=null?chatprovider.driverMessages.length: chatprovider.riderMessages.length,
                    padding: const EdgeInsets.only(bottom: 15),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => const SizedBox(width: 8,),
                    itemBuilder: (context, index) {
                      final data = widget.source!=null?chatprovider.driverMessages[index]: chatprovider.riderMessages[index];
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _textController.text = data;
                            _sendMessage(data,);
                            _textController.clear();
                            widget.source!=null?chatprovider.driverMessages.remove(data): chatprovider.riderMessages.remove(data);
                            
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.blackColor,width: 1)
                          ),
                          child:  Center(child: Text(data,style: blackBody)),
                        ),
                      );
                    },),
                ),
                _buildMessageComposer(chatprovider, chatDetails,
                    profileProvider.profileDetailss!.profilePic.toString()),
              ],
            ),
          ),)
          );
  }

  Widget _buildMessageComposer(
      ChatProvider chatprovider, List<Data> chatDetails, String image) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        height: 50,
        color: Colors.white,
        child: Row(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: AppColors.redColor,
              backgroundImage: NetworkImage(image,),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: TextField(
                controller: _textController,
                cursorColor: AppColors.blackColor,
                decoration: InputDecoration(
                  hintText: AppStrings.sendamessage,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: AppColors.blackColor, width: 1)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: AppColors.blackColor, width: 1)),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send,color: AppColors.redColor,),
              onPressed: () {
                _sendMessage(_textController.text,);
                _textController.clear();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage(
      String text,) {
    if (_textController.text.isEmpty) {
      CSnackBar.showSnackBar(AppStrings.cantSendEmptyMessage, context);
    } else {
      var param = {};
      widget.senderid == prefs!.getString(PrefConstant.userid)
          ? param = {
              'rideid': widget.rideid,
              'senderId': widget.reciverid,
              'receiverId': widget.senderid,
              'messages': _textController.text
            }
          : param = {
              'rideid': widget.rideid,
              'senderId': widget.senderid,
              'receiverId': widget.reciverid,
              'messages': _textController.text
            };
      final enc = encryptAESCryptoJS(jsonEncode(param), key);
      socket!.emit('chatMessageEnc', enc.toString());
    }
  }

  @override
  void dispose() {
    socket?.clearListeners();
    socket?.disconnect();
    socket?.dispose();
    socket = null;
    super.dispose();
  }
}
