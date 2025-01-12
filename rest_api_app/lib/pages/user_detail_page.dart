import 'package:flutter/material.dart';
import 'package:rest_api_app/pages/form_page.dart';
import 'package:rest_api_app/widgets/custom_button.dart';
import '../model/user.dart';

class UserDetailPage extends StatelessWidget {
  const UserDetailPage({
    super.key,
    required this.user,
  });

  static MaterialPageRoute route(final User user) => MaterialPageRoute(
      builder: (context) => UserDetailPage(
            user: user,
          ));

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text('Hello ${user.firstName} ${user.lastName} ${user.surName}'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Card
            Container(
              width: MediaQuery.of(context).size.width * 0.35,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 192, 192, 192),
                    spreadRadius: 5,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.greenAccent.shade100,
                    child: Text(
                      user.firstName[0] + user.lastName[0],
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${user.firstName} ${user.lastName}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.profession ?? 'N/A',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Details Section
            _buildDetailSection(
              context,
              'Personal Information',
              [
                _buildDetailRow(
                    Icons.cake_rounded, 'Date of Birth', user.dateOfBirth),
                _buildDetailRow(Icons.male_rounded, 'Gender', user.gender),
              ],
            ),
            const SizedBox(height: 16),
            _buildDetailSection(
              context,
              'Contact Information',
              [
                _buildDetailRow(Icons.email_rounded, 'Email', user.email),
                _buildDetailRow(Icons.phone_rounded, 'Phone', user.phoneNo),
              ],
            ),
            const SizedBox(height: 16),
            _buildDetailSection(
              context,
              'Address Information',
              [
                _buildDetailRow(
                    Icons.home_rounded, 'Street', user.streetAddress ?? 'N/A'),
                _buildDetailRow(
                    Icons.location_city_rounded, 'City', user.city ?? 'N/A'),
                _buildDetailRow(
                    Icons.map_rounded, 'Region', user.region ?? 'N/A'),
                _buildDetailRow(Icons.markunread_mailbox_rounded, 'ZIP Code',
                    user.zipCode ?? 'N/A'),
                _buildDetailRow(
                    Icons.flag_rounded, 'Country', user.country ?? 'N/A'),
              ],
            ),
            const SizedBox(height: 20),
            CustomButton(
              onTap: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => UserFormPage(
                    userModel: user,
                  ),
                ),
                (route) => false,
              ),
              text: 'Update',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(
      BuildContext context, String sectionTitle, List<Widget> rows) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 192, 192, 192),
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sectionTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
          ...rows,
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.greenAccent),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SelectableText(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
