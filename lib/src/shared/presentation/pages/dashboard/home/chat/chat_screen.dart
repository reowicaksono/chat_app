part of '../../../pages.dart';

class ChatScreen extends StatefulWidget {
  final String receiveID;
  const ChatScreen({Key? key, required this.receiveID}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late Stream<QuerySnapshot> _messagesStream;
  late Future<DocumentSnapshot> _receiverData;

  @override
  void initState() {
    super.initState();
    _messagesStream = ChatService()
        .getMessages(FirebaseAuth.instance.currentUser!.uid, widget.receiveID);
    _receiverData = _getReceiverData(widget.receiveID);
  }

  Future<DocumentSnapshot> _getReceiverData(String receiveID) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(receiveID)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: FutureBuilder<DocumentSnapshot>(
          future: _receiverData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading...');
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            final receiverData = snapshot.data!;
            return Text(
              receiverData['name'],
              style: TextStyle(color: Colors.white),
            );
          },
        ),
        actions: [
          IconButton(
              onPressed: () => Navigation.navigateToPage(Approute.VIDEO_CALL),
              icon: Icon(Icons.video_call))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _messagesStream,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final List<DocumentSnapshot> documents = snapshot.data!.docs;
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final Map<String, dynamic> data =
                        documents[index].data() as Map<String, dynamic>;
                    final isSender = data['senderId'] ==
                        FirebaseAuth.instance.currentUser!.uid;
                    final message = data['message'];
                    final timestamp = data['timestamp'] as Timestamp;
                    final dateTime = timestamp.toDate();

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: isSender
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: isSender ? Colors.blue : Colors.green[300],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(isSender ? 8.0 : 0.0),
                                topRight: Radius.circular(isSender ? 0.0 : 8.0),
                                bottomLeft: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              message,
                              style: TextStyle(
                                  color:
                                      isSender ? Colors.white : Colors.black),
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            "${dateTime.hour}:${dateTime.minute}",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    if (_messageController.text.isNotEmpty) {
                      await ChatService().sendMessage(
                          widget.receiveID, _messageController.text);
                      _messageController.clear();
                      // Scroll to bottom when sending a message
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
