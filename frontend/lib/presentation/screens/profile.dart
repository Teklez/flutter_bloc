import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/application/auth/auth_bloc.dart';
import 'package:frontend/presentation/events/auth_event.dart';
import 'package:frontend/presentation/states/auth_state.dart';
import 'package:frontend/presentation/widgets/dialogues.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isEditing = false;
  String _errorText = '';

  @override
  void dispose() {
    _usernameController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
      _errorText = ''; // Clear error text when toggling edit mode
    });
  }

  void _saveProfile(String id, String user) {
    String username = _usernameController.text;
    String oldPassword = _oldPasswordController.text;
    String newPassword = _newPasswordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (newPassword != confirmPassword) {
      setState(() {
        _errorText = 'New password and confirm password do not match';
      });
      return;
    }

    if (username.isEmpty ||
        oldPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmPassword.isEmpty) {
      setState(() {
        _errorText = 'All fields are required';
      });
      return;
    }

    BlocProvider.of<AuthBloc>(context).add(UserUpdated(
        id: id,
        username: username == '' ? user : username,
        oldPassword: oldPassword,
        newPassword: newPassword));
    BlocProvider.of<AuthBloc>(context).add(CurrentUser());
  }

  String _deleteAccount(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AreYouSureDialogue(data: id, feature: "profile");
      },
    );
    return id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        print(
            "================================================================================>state: $state");
        String username = 'username';
        String id = '';
        if (state is AuthSuccess) {
          if (state.message != null) {
            final message = state.message;
            username = message['username'];
            id = message['sub'];
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.account_circle, size: 100),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    username,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _toggleEditMode,
                  child: Text(_isEditing ? 'Cancel' : 'Edit Profile'),
                ),
                if (_isEditing) ...[
                  const SizedBox(height: 16),
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _oldPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Old Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _newPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'New Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Confirm New Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  if (_errorText.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text(
                      _errorText,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _saveProfile(id, username);
                      Navigator.popAndPushNamed(context, '/profile');
                    },
                    child: const Text('Save'),
                  ),
                ],
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _deleteAccount(id);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Delete Account'),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
