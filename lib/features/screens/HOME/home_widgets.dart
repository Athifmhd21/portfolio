import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PortfolioIntroOverlay extends StatelessWidget {
  final Animation<double> nameFade;
  final Animation<double> detailsFade;
  final Animation<double> lineProgress;
  const PortfolioIntroOverlay({
    super.key,
    required this.nameFade,
    required this.detailsFade,
    required this.lineProgress,
  });

  @override
  Widget build(BuildContext context) => Container(
    color: const Color(0xFF111111),
    width: double.infinity,
    height: double.infinity,
    child: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FadeTransition(
              opacity: nameFade,
              child: Text(
                'AM.',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 3,
                ),
              ),
            ),
            const SizedBox(height: 18),
            FadeTransition(
              opacity: nameFade,
              child: Text(
                'ATHIF MHD',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 5,
                ),
              ),
            ),
            const SizedBox(height: 12),
            FadeTransition(
              opacity: detailsFade,
              child: Text(
                'FLUTTER DEVELOPER  ·  UI/UX DESIGNER',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  color: Colors.white70,
                  fontSize: 11,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: 150,
              child: AnimatedBuilder(
                animation: lineProgress,
                builder: (context, child) => ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: lineProgress.value,
                    minHeight: 2,
                    backgroundColor: Colors.white24,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            FadeTransition(
              opacity: detailsFade,
              child: Text(
                'WELCOME TO MY PORTFOLIO',
                style: GoogleFonts.montserrat(
                  color: Colors.white54,
                  fontSize: 8,
                  letterSpacing: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class DesktopHeroSection extends StatelessWidget {
  final VoidCallback onResume, onPortfolio, onContact, onGithub, onLinkedIn;
  const DesktopHeroSection({
    super.key,
    required this.onResume,
    required this.onPortfolio,
    required this.onContact,
    required this.onGithub,
    required this.onLinkedIn,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Row(
          children: [
            Expanded(flex: 5, child: Container(color: Colors.grey[300])),
            Expanded(flex: 5, child: Container(color: Colors.black)),
          ],
        ),
        Positioned(
          left: width * .45,
          top: 0,
          bottom: 0,
          child: Transform(
            transform: Matrix4.skewX(-.3),
            child: Container(width: 419, color: Colors.black),
          ),
        ),
        if (width >= 1100)
          Positioned(
            right: 70,
            top: 130,
            bottom: 0,
            width: width * .36,
            child: Image.asset(
              'assets/athif.png',
              fit: BoxFit.contain,
              alignment: Alignment.bottomCenter,
            ),
          ),
        Positioned(
          top: 30,
          right: 50,
          child: Row(
            children: [
              NavItem(text: 'Home'),
              NavItem(text: 'Resume', onTap: onResume),
              NavItem(text: 'Portfolio', onTap: onPortfolio),
              const SizedBox(width: 20),
              HireButton(text: "LET'S TALK", onTap: onContact),
            ],
          ),
        ),
        Positioned(
          left: 100,
          top: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hi, I am', style: GoogleFonts.montserrat(fontSize: 24)),
              const SizedBox(height: 10),
              Text(
                'Athif Mhd',
                style: GoogleFonts.montserrat(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Flutter Developer / UI-UX Designer',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  SocialButton(imagePath: 'assets/github.png', onTap: onGithub),
                  SocialButton(
                    imagePath: 'assets/linked.jpg',
                    onTap: onLinkedIn,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MobileHeroSection extends StatelessWidget {
  final VoidCallback onResume, onPortfolio, onContact, onGithub, onLinkedIn;
  const MobileHeroSection({
    super.key,
    required this.onResume,
    required this.onPortfolio,
    required this.onContact,
    required this.onGithub,
    required this.onLinkedIn,
  });

  @override
  Widget build(BuildContext context) => Column(
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
                      const NavItemSmall(text: 'Home'),
                      NavItemSmall(text: 'Resume', onTap: onResume),
                      NavItemSmall(text: 'Portfolio', onTap: onPortfolio),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              HireButtonSmall(text: "LET'S CHAT", onTap: onContact),
            ],
          ),
        ),
      ),
      Container(
        color: Colors.grey[300],
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hi, I am', style: GoogleFonts.montserrat(fontSize: 18)),
            const SizedBox(height: 9),
            Text(
              'Athif Mhd',
              style: GoogleFonts.montserrat(
                fontSize: 37,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 9),
            Text(
              'Flutter Developer / UI-UX Designer',
              style: GoogleFonts.montserrat(
                fontSize: 15,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                SocialButton(imagePath: 'assets/github.png', onTap: onGithub),
                SocialButton(imagePath: 'assets/linked.jpg', onTap: onLinkedIn),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

class AboutSection extends StatelessWidget {
  final VoidCallback onResume;
  const AboutSection({super.key, required this.onResume});
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    color: const Color(0xFF111111),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
    child: Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            child: Text(
              'ABOUT ME',
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
                'Detail-oriented Flutter Developer with a strong background in Computer Science and expertise in building user-focused, responsive mobile and web applications. Proven track record in UI/UX design, Flutter development, and API integration. Passionate about clean code, team leadership, and delivering intuitive digital experiences that drive user satisfaction.',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  color: Colors.white70,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'I’ve worked on team-based projects, including leading a design team, and I’m passionate about continuous learning and improving user experiences.',
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
          onPressed: onResume,
          child: const Text('-- CLICK HERE TO CHECK OUT MY RESUME --'),
        ),
      ],
    ),
  );
}

class PortfolioSection extends StatelessWidget {
  final Key sectionKey;
  final List<Map<String, String>> projects;
  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;
  final ValueChanged<Map<String, String>> onProjectTap;
  const PortfolioSection({
    super.key,
    required this.sectionKey,
    required this.projects,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.onProjectTap,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Container(
        width: double.infinity,
        color: const Color(0xFF111111),
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Text(
              'PORTFOLIO',
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
        key: sectionKey,
        width: double.infinity,
        color: const Color(0xFF111111),
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ['ALL', 'CODED', 'DESIGNED']
                  .map(
                    (filter) => _FilterItem(
                      text: filter,
                      isActive: selectedFilter == filter,
                      onTap: () => onFilterChanged(filter),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: 200,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: projects
                      .map(
                        (project) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: HoverProjectCard(
                            imagePath: project['image']!,
                            onTap: () => onProjectTap(project),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

class _FilterItem extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onTap;
  const _FilterItem({
    required this.text,
    required this.isActive,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
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

class ContactSection extends StatelessWidget {
  final Key sectionKey;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController,
      emailController,
      phoneController,
      messageController;
  final bool isSending;
  final VoidCallback onSubmit, onWhatsApp;
  const ContactSection({
    super.key,
    required this.sectionKey,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.messageController,
    required this.isSending,
    required this.onSubmit,
    required this.onWhatsApp,
  });

  String? _required(String? value, String message) =>
      value == null || value.trim().isEmpty ? message : null;
  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Please enter your email';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(email))
      return 'Please enter a valid email address';
    return null;
  }

  Widget _field({
    required String hint,
    required TextEditingController controller,
    required String? Function(String?) validator,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) => TextFormField(
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

  @override
  Widget build(BuildContext context) => Container(
    key: sectionKey,
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
                  'CONTACT',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Feel free to reach out for opportunities, collaborations, or just to connect.',
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
                  key: formKey,
                  child: Column(
                    children: [
                      _field(
                        hint: 'Enter your name',
                        controller: nameController,
                        validator: (v) =>
                            _required(v, 'Please enter your name'),
                      ),
                      const SizedBox(height: 20),
                      _field(
                        hint: 'Enter your email',
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateEmail,
                      ),
                      const SizedBox(height: 20),
                      _field(
                        hint: 'Phone number',
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (v) =>
                            _required(v, 'Please enter your phone number'),
                      ),
                      const SizedBox(height: 20),
                      _field(
                        hint: 'Your message',
                        controller: messageController,
                        maxLines: 5,
                        validator: (v) =>
                            _required(v, 'Please enter a message'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: isSending ? null : onSubmit,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: isSending
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.black,
                          ),
                        )
                      : Text(
                          'SUBMIT',
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
              Text(
                'REACH ME AT:',
                style: GoogleFonts.montserrat(color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                '+91 9746963938',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'WHATSAPP ME HERE:',
                style: GoogleFonts.montserrat(color: Colors.white),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: onWhatsApp,
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
  );
}

class NavItem extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  const NavItem({super.key, required this.text, this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(text, style: GoogleFonts.montserrat(color: Colors.white)),
    ),
  );
}

class NavItemSmall extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  const NavItemSmall({super.key, required this.text, this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        text,
        style: GoogleFonts.montserrat(color: Colors.white, fontSize: 13),
      ),
    ),
  );
}

class HireButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  const HireButton({super.key, required this.text, this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
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
}

class HireButtonSmall extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  const HireButtonSmall({super.key, required this.text, this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
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
}

class SocialButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;
  const SocialButton({super.key, required this.imagePath, required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
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

class HoverProjectCard extends StatefulWidget {
  final String imagePath;
  final VoidCallback onTap;
  const HoverProjectCard({
    super.key,
    required this.imagePath,
    required this.onTap,
  });
  @override
  State<HoverProjectCard> createState() => _HoverProjectCardState();
}

class _HoverProjectCardState extends State<HoverProjectCard> {
  bool _isHovering = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _isHovering = true),
    onExit: (_) => setState(() => _isHovering = false),
    child: GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 50),
        width: 280,
        height: 180,
        transform: Matrix4.identity()..scale(_isHovering ? 1.05 : 1.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: _isHovering
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
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
            errorBuilder: (_, __, ___) => const Center(child: Text('IMAGE')),
          ),
        ),
      ),
    ),
  );
}
