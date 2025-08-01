import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  void _launchInstagram() async {
    const url = 'https://www.instagram.com/your_profile'; // Replace with your actual profile
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Lazeez Rasoi 🍛',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Version 1.0.0',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Divider(height: 30),
            const Text(
              'About:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Lazeez Rasoi is your offline guide to authentic Pakistani recipes. Enjoy easy cooking with traditional flavor, wherever you are!',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Developer:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text('Hasham Ahmad', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Follow on Instagram: ', style: TextStyle(fontSize: 16)),
                IconButton(
                  icon: const Icon(Icons.open_in_new),
                  onPressed: _launchInstagram,
                ),
              ],
            ),
            const Spacer(),
            const Center(
              child: Text(
                'Made with ❤️ in Pakistan',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
