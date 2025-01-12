import 'package:flutter/material.dart';
import 'package:rest_api_app/model/user.dart';
import 'package:rest_api_app/pages/user_detail_page.dart';
import '../api_service.dart';

class UserDataViewPage extends StatefulWidget {
  const UserDataViewPage({super.key});

  static route() => MaterialPageRoute(builder: (context) => UserDataViewPage());
  @override
  State<UserDataViewPage> createState() => _UserDataViewPageState();
}

class _UserDataViewPageState extends State<UserDataViewPage> {
  final ApiService apiService = ApiService();
  late Future<List<Map<String, dynamic>>> apiResponse;

  void _deleteAllUsers() async {
    final res = await apiService.deleteData();
    debugPrint(res.toString());
    setState(() {
      apiResponse = apiService.fetchData();
    });
  }

  @override
  void initState() {
    super.initState();
    apiResponse = apiService.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('Flutter API Integration'),
        actions: [
          TextButton(
            onPressed: _deleteAllUsers,
            child: Text(
              'Delete all',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: apiResponse,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final List<Map<String, dynamic>> data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final user = User.fromJson(data[index]);
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    UserDetailPage.route(user),
                  ),
                  child: ListTile(
                    title: Text('${user.firstName} ${user.lastName}'),
                    subtitle: Text('Email: ${user.email}'),
                    trailing: Chip(
                      backgroundColor: Colors.grey.shade200,
                      label: Text(
                        user.gender,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}
