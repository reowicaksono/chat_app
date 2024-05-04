part of '../../pages.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();
  final ImagePicker _picker = ImagePicker();
  File? _image;

  late Future<DocumentSnapshot> _receiverData;

  @override
  void initState() {
    super.initState();
    _receiverData = _getReceiverData(_authService.getCurrentUser().uid);
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
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: FutureBuilder<DocumentSnapshot>(
          future: _receiverData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('User not found'));
            }
            final user = snapshot.data!;
            return ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                GestureDetector(
                  onTap: () => _selectImage(context),
                  child: CircleAvatar(
                    radius: 64,
                    backgroundImage: _image != null
                        ? FileImage(_image!)
                        : NetworkImage(user["photoURL"] ??
                                'https://via.placeholder.com/150')
                            as ImageProvider<Object>,
                  ),
                ),
                SizedBox(height: 16.0),
                ListTile(
                  title: Text('Name'),
                  subtitle: Text(user["name"] ?? 'No name'),
                  onTap: () => _editName(context),
                ),
                ListTile(
                  title: Text('Email'),
                  subtitle: Text(user["email"] ?? 'No email'),
                  onTap: () => _editEmail(context),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _selectImage(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _editName(BuildContext context) async {
    // Implementasi logika untuk mengedit nama pengguna
  }

  Future<void> _editEmail(BuildContext context) async {
    // Implementasi logika untuk mengedit email pengguna
  }
}
