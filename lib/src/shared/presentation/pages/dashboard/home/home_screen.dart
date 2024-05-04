part of '../../pages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final AppPreferences _preferences = AppPreferences();
  TextEditingController searchController = TextEditingController();

  var currentIndex = 0;

  final AuthService _authService = AuthService();
  final ChatService _chatService = ChatService();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> logout() {
    return _authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => logout(),
          child: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
      ),
      body: _buildUserList(),
    );
  }

  // Widget  _buildTopBar() {
  //   return ListTile(
  //     leading: const CircleAvatar(
  //       maxRadius: 30,
  //       backgroundColor: Colors.transparent,
  //       backgroundImage: AssetImage("assets/images/Memoji.png"),
  //     ),
  //     title: Text(
  //       'Home',
  //       style: BlackText.copyWith(fontSize: 20),
  //     ),
  //     subtitle: Row(
  //       children: [
  //         Text(
  //           'Class ',
  //           style: BlackText,
  //         ),
  //         const SizedBox(width: 10),
  //         Text(
  //           '8',
  //           style: BlackText,
  //         ),
  //       ],
  //     ),
  //     trailing: IconButton(
  //       onPressed: () {
  //         setState(() {
  //           logout();
  //         });
  //       },
  //       icon: const Icon(
  //         Icons.notification_add,
  //         color: Colors.yellow,
  //       ),
  //     ),
  //   );
  // }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUserList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData == null ||
        userData["email"] == _authService.getCurrentUser().email) {
      return Container();
    }
    return UserTile(
      teks: userData["name"],
      onTap: () => Navigation.intentWithDataPush(Approute.CHAT_ROUTE,
          arguments: userData["uid"]),
    );
  }

  // void _signOut() async {
  //   await dialogBuilder(context, "Are you sure want to sign out?", () {
  //     BlocProvider.of<AuthBloc>(context).add(
  //       SignOutRequested(),
  //     );
  //   });
  // }
}
