import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/pdf/open_pdf.dart';
import 'package:portfolio/features/screens/grelasection.dart';
import 'package:portfolio/features/screens/razacks.dart';
import 'package:portfolio/features/screens/foodiaQ.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _portfolioKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  // Contact form state
  final _contactFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSendingMessage = false;

  static const String _emailJsServiceId = 'service_0ckozsh';
  static const String _emailJsTemplateId = 'template_wzrqhsi';
  static const String _emailJsPublicKey = 'i7C5hV-Y83P5BNsqE';

  @override
  void dispose() {
    _scrollController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submitContactForm() async {
    if (!_contactFormKey.currentState!.validate()) return;

    if (_emailJsServiceId == 'YOUR_SERVICE_ID' ||
        _emailJsTemplateId == 'YOUR_TEMPLATE_ID' ||
        _emailJsPublicKey == 'YOUR_PUBLIC_KEY') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please configure your EmailJS credentials first.'),
        ),
      );
      return;
    }

    setState(() => _isSendingMessage = true);

    try {
      final response = await http.post(
        Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
        headers: const {'Content-Type': 'application/json'},
        body: jsonEncode({
          'service_id': _emailJsServiceId,
          'template_id': _emailJsTemplateId,
          'user_id': _emailJsPublicKey,
          'template_params': {
            'from_name': _nameController.text.trim(),
            'from_email': _emailController.text.trim(),
            'phone_number': _phoneController.text.trim(),
            'message': _messageController.text.trim(),
            'reply_to': _emailController.text.trim(),
          },
        }),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        _contactFormKey.currentState!.reset();
        _nameController.clear();
        _emailController.clear();
        _phoneController.clear();
        _messageController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Thanks for reaching out! I will get back to you soon.',
            ),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception(
          'EmailJS returned ${response.statusCode}: ${response.body}',
        );
      }
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Message could not be sent. Please try again later.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isSendingMessage = false);
    }
  }

  Widget _contactTextField({
    required String hint,
    required TextEditingController controller,
    required String? Function(String?) validator,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: GoogleFonts.montserrat(fontSize: 14, color: Colors.black87),
      decoration: InputDecoration(
        hintText: hint.toUpperCase(),
        hintStyle: GoogleFonts.montserrat(fontSize: 12, color: Colors.black54),
        errorStyle: GoogleFonts.montserrat(fontSize: 11, color: Colors.red),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }

  void scrollToPortfolio() {
    final context = _portfolioKey.currentContext;

    if (context != null) {
      final box = context.findRenderObject() as RenderBox;
      final position = box.localToGlobal(Offset.zero);

      final offset = position.dy + _scrollController.offset - 170;
      //  adjust -80 if needed

      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  void scrollToContact() {
    final context = contactKey.currentContext;

    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        alignment: 0,
      );
    }
  }

  Future<void> openWhatsApp() async {
    final Uri whatsappUrl = Uri.parse(
      'https://wa.me/919746963938?text=Hello Athif',
    );

    try {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Could not open WhatsApp: $e');
    }
  }

  //  FILTER STATE
  String selectedFilter = "ALL";

  //  PROJECT DATA
  final List<Map<String, String>> projects = [
    {
      "image": "assets/project1.png",
      "type": "CODED",
      "project": "razacks_homeopathy",
    },
    {"image": "assets/project2.png", "type": "DESIGNED", "project": "grela"},
    {"image": "assets/project3.png", "type": "DESIGNED", "project": "foodiaq"},
    {"image": "assets/pendi.png", "type": "DESIGNED", "project": "pendi"},
  ];

  // Launch URLs
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;

          if (width > 899) {
            return desktopView(context);
          } else {
            return mobileView(context);
          }
        },
      ),
    );
  }

  // ======================= DESKTOP VIEW ======================== \\

  // ========================================================= \\

  Widget desktopView(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: heroSection(context),
          ),
          aboutSection(context),
          portfolioSection(context),
          contactSection(context),
        ],
      ),
    );
  }

  // ================= MOBILE VIEW ================= \\

  // ================================================ \\

  Widget mobileView(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          heroMobile(context),
          aboutSection(context),
          portfolioSection(context),
          contactSection(context),
        ],
      ),
    );
  }

  // ================= HERO DESKTOP ================= \\

  Widget heroSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Row(
          children: [
            Expanded(flex: 5, child: Container(color: Colors.grey[300])),
            Expanded(flex: 5, child: Container(color: Colors.black)),
          ],
        ),

        Positioned(
          left: screenWidth * 0.45,
          top: 0,
          bottom: 0,
          child: Transform(
            transform: Matrix4.skewX(-0.3),
            child: Container(width: 420, color: Colors.black),
          ),
        ),

        // YOUR IMAGE - DESKTOP ONLY
        if (screenWidth >= 1100)
          Positioned(
            right: 70,
            top: 130,
            bottom: 0,
            width: screenWidth * 0.36,
            child: Image.asset(
              "assets/athif.png",
              fit: BoxFit.contain,
              alignment: Alignment.bottomCenter,
            ),
          ),

        // NAVIGATION
        Positioned(
          top: 30,
          right: 50,
          child: Row(
            children: [
              navItem("Home"),
              navItem(
                "Resume",
                onTap: () {
                  openPdf();
                },
              ),
              navItem("Portfolio", onTap: scrollToPortfolio),
              const SizedBox(width: 20),
              hireButton("LET'S TALK", onTap: scrollToContact),
            ],
          ),
        ),

        // INTRODUCTION
        Positioned(
          left: 100,
          top: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hi, I am", style: GoogleFonts.montserrat(fontSize: 24)),
              const SizedBox(height: 10),
              Text(
                "Athif Mhd",
                style: GoogleFonts.montserrat(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Flutter Developer / UI-UX Designer",
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  socialButton(
                    imagePath: "assets/github.png",
                    onTap: () => _launchURL("https://github.com/athifmhd21"),
                  ),
                  socialButton(
                    imagePath: "assets/linked.jpg",
                    onTap: () =>
                        _launchURL("https://www.linkedin.com/in/athif21/"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ================= HERO MOBILE ================= \\
  Widget heroMobile(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        navItemSmall("Home"),
                        navItem(
                          "Resume",
                          onTap: () {
                            openPdf();
                          },
                        ),
                        navItemSmall("Portfolio", onTap: scrollToPortfolio),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 19),
                hireButtonSmall("LET'S CHAT", onTap: scrollToContact),
              ],
            ),
          ),
        ),

        ////////////////////////////////////// HERO SECTION //////////////////////////////////////////////

        //////////////////////////////////////////////////////////////////////////////////////////////////
        Container(
          color: Colors.grey[300],
          padding: const EdgeInsets.all(24),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hi, I am", style: GoogleFonts.montserrat(fontSize: 18)),
              const SizedBox(height: 9),
              Text(
                "Athif Mhd",
                style: GoogleFonts.montserrat(
                  fontSize: 37,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 9),
              Text(
                "Flutter Developer / UI-UX Designer",
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  socialButton(
                    imagePath: "assets/github.png",
                    onTap: () => _launchURL("https://github.com/athifmhd21"),
                  ),
                  socialButton(
                    imagePath: "assets/linked.jpg",
                    onTap: () =>
                        _launchURL("https://www.linkedin.com/in/athif21"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ================= ABOUT =================
  Widget aboutSection(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF111111),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
              ),
              child: Text(
                "ABOUT ME",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 38),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                Text(
                  "Detail-oriented Flutter Developer with a strong background in Computer Science and expertise in building user-focused, responsive mobile and web applications. Proven track record in UI/UX design, Flutter development, and API integration. Passionate about clean code, team leadership, and delivering intuitive digital experiences that drive user satisfaction.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: Colors.white70,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "I’ve worked on team-based projects, including leading a design team, and I’m passionate about continuous learning and improving user experiences.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: Colors.white70,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 38),
          TextButton(
            onPressed: () {
              openPdf();
            },
            child: Text("-- CLICK HERE TO CHECK OUT MY RESUME --"),
          ),
        ],
      ),
    );
  }

  // ================= PORTFOLIO =================
  Widget portfolioSection(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isMobile = width < 800;

    //  FILTER LOGIC
    List<Map<String, String>> filteredProjects = selectedFilter == "ALL"
        ? projects
        : projects.where((p) => p["type"] == selectedFilter).toList();

    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Color(0xFF111111),
          padding: const EdgeInsets.symmetric(vertical: 60),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Text(
                "PORTFOLIO",
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
            ),
          ),
        ),

        Container(
          key: _portfolioKey,
          width: double.infinity,
          color: const Color(0xFF111111),
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  filterItem("ALL"),
                  filterItem("CODED"),
                  filterItem("DESIGNED"),
                ],
              ),
              const SizedBox(height: 50),

              isMobile
                  ? Column(
                      children: filteredProjects.map((project) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: projectCard(
                            imagePath: project["image"]!,
                            onTap: () => openProject(project),
                          ),
                        );
                      }).toList(),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: filteredProjects.map((project) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: projectCard(
                            imagePath: project["image"]!,
                            onTap: () => openProject(project),
                          ),
                        );
                      }).toList(),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  //================== CONTACT SECTION===========
  Widget contactSection(BuildContext context) {
    return Container(
      key: contactKey,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.grey[300],
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 13,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Text(
                    "CONTACT",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "Feel free to reach out for opportunities, collaborations, or just to connect.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 50),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Form(
                    key: _contactFormKey,
                    child: Column(
                      children: [
                        _contactTextField(
                          hint: 'Enter your name',
                          controller: _nameController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        _contactTextField(
                          hint: 'Enter your email',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            final email = value?.trim() ?? '';
                            if (email.isEmpty) return 'Please enter your email';
                            if (!RegExp(
                              r'^[^@]+@[^@]+\.[^@]+$',
                            ).hasMatch(email)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        _contactTextField(
                          hint: 'Phone number',
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        _contactTextField(
                          hint: 'Your message',
                          controller: _messageController,
                          maxLines: 5,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a message';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: _isSendingMessage ? null : _submitContactForm,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: _isSendingMessage
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.black,
                            ),
                          )
                        : Text(
                            "SUBMIT",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: const Color(0xFF111111),
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: const Color(0xFF111111),
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    children: [
                      Text(
                        "REACH ME AT:",
                        style: GoogleFonts.montserrat(color: Colors.white),
                      ),
                      const SizedBox(height: 10),

                      Text(
                        "+91 9746963938",
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "WHATSAPP ME HERE:",
                        style: GoogleFonts.montserrat(color: Colors.white),
                      ),

                      const SizedBox(height: 20),

                      GestureDetector(
                        onTap: openWhatsApp,
                        child: const FaIcon(
                          FontAwesomeIcons.whatsapp,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= FILTER =================
  Widget filterItem(String text) {
    bool isActive = selectedFilter == text;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = text;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text(
              text,
              style: GoogleFonts.montserrat(
                color: isActive ? Colors.white : Colors.grey,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 2,
              width: 30,
              color: isActive ? Colors.white : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }

  // ================= PROJECT NAVIGATION =================
  void openProject(Map<String, String> project) {
    if (project["project"] == "grela") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const GrelaScreen()),
      );
      return;
    }

    if (project["project"] == "razacks_homeopathy") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const RazacksHomeopathyScreen()),
      );
      return;
    }
    if (project["project"] == "foodiaq") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const FoodiaQScreen()),
      );
      return;
    }

    final link = project["link"];
    if (link != null && link.isNotEmpty) {
      _launchURL(link);
    }
  }

  // ================= PROJECT CARD =================
  Widget projectCard({required String imagePath, required VoidCallback onTap}) {
    return _HoverCard(imagePath: imagePath, onTap: onTap);
  }

  // ================= UI HELPERS =================
  Widget navItem(String text, {VoidCallback? onTap}) => GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(text, style: GoogleFonts.montserrat(color: Colors.white)),
    ),
  );

  Widget hireButton(String text, {VoidCallback? onTap}) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
  Widget navItemSmall(String text, {VoidCallback? onTap}) => GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        text,
        style: GoogleFonts.montserrat(color: Colors.white, fontSize: 13),
      ),
    ),
  );
  Widget hireButtonSmall(String text, {VoidCallback? onTap}) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );

  Widget socialButton({
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.asset(imagePath, width: 20, height: 20),
      ),
    );
  }
}

// ================= HOVER CARD =================
class _HoverCard extends StatefulWidget {
  final String imagePath;
  final VoidCallback onTap;

  const _HoverCard({required this.imagePath, required this.onTap});

  @override
  State<_HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<_HoverCard> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 50),
          width: 280,
          height: 180,
          transform: Matrix4.identity()..scale(isHovering ? 1.05 : 1.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isHovering
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              widget.imagePath,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Center(child: Text("IMAGE")),
            ),
          ),
        ),
      ),
    );
  }
}
