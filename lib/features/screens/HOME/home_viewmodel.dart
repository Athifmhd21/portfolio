import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HomeViewModel extends ChangeNotifier {
  bool _isSendingMessage = false;
  bool get isSendingMessage => _isSendingMessage;

  String selectedFilter = 'ALL';

  final List<Map<String, String>> projects = [
    {
      'image': 'assets/project1.png',
      'type': 'CODED',
      'project': 'razacks_homeopathy',
    },
    {'image': 'assets/project2.png', 'type': 'DESIGNED', 'project': 'grela'},
    {'image': 'assets/project3.png', 'type': 'DESIGNED', 'project': 'foodiaq'},
    {'image': 'assets/pendi.png', 'type': 'DESIGNED', 'project': 'pendi'},
  ];

  static const String _emailJsServiceId = 'service_0ckozsh';
  static const String _emailJsTemplateId = 'template_wzrqhsi';
  static const String _emailJsPublicKey = 'i7C5hV-Y83P5BNsqE';

  List<Map<String, String>> get filteredProjects {
    if (selectedFilter == 'ALL') return projects;
    return projects
        .where((project) => project['type'] == selectedFilter)
        .toList();
  }

  void setSelectedFilter(String filter) {
    if (selectedFilter == filter) return;
    selectedFilter = filter;
    notifyListeners();
  }

  Future<bool> submitContactForm({
    required String name,
    required String email,
    required String phone,
    required String message,
  }) async {
    if (_emailJsServiceId == 'YOUR_SERVICE_ID' ||
        _emailJsTemplateId == 'YOUR_TEMPLATE_ID' ||
        _emailJsPublicKey == 'YOUR_PUBLIC_KEY') {
      return false;
    }

    _isSendingMessage = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
        headers: const {'Content-Type': 'application/json'},
        body: jsonEncode({
          'service_id': _emailJsServiceId,
          'template_id': _emailJsTemplateId,
          'user_id': _emailJsPublicKey,
          'template_params': {
            'from_name': name.trim(),
            'from_email': email.trim(),
            'phone_number': phone.trim(),
            'message': message.trim(),
            'reply_to': email.trim(),
          },
        }),
      );

      if (response.statusCode == 200) return true;

      debugPrint('EmailJS returned ${response.statusCode}: ${response.body}');
      return false;
    } catch (error) {
      debugPrint('Contact form submission failed: $error');
      return false;
    } finally {
      _isSendingMessage = false;
      notifyListeners();
    }
  }

  Future<void> openWhatsApp() async {
    final whatsappUrl = Uri.parse(
      'https://wa.me/919746963938?text=Hello Athif',
    );

    try {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } catch (error) {
      debugPrint('Could not open WhatsApp: $error');
    }
  }

  Future<void> launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }
}
