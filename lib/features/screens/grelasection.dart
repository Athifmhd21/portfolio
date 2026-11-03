import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GrelaScreen extends StatefulWidget {
  const GrelaScreen({super.key});

  @override
  State<GrelaScreen> createState() => _GrelaScreenState();
}

class _GrelaScreenState extends State<GrelaScreen> {
  static const Color _background = Color(0xFF1D1D1D);
  static const Color _foreground = Color(0xFFF5F5F5);
  static const Color _muted = Color(0xFFBDBDBD);

  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_GrelaPreview> _previews = const [
    _GrelaPreview(
      image: 'assets/grela1.png',
      heading: 'NEW and IMPROVED UI',
      description:
          'A cleaner and modern interface designed for a smoother and more engaging experience.',
      highlight: 'MODERN DESIGN',
    ),
    _GrelaPreview(
      image: 'assets/grela2.png',
      heading: 'HOW IT WORKS',
      description:
          'A simple step-by-step process that guides users through transforming their land, from the initial consultation and site assessment to design, installation and ongoing maintenance.',
      highlight: 'FOUR SIMPLE STEPS',
    ),
    _GrelaPreview(
      image: 'assets/grela3.png',
      heading: 'FREQUENTLY ASKED QUESTIONS',
      description:
          'A dedicated FAQ section that helps visitors understand Grela’s services, project timelines, irrigation solutions and maintenance support.',
      highlight: 'EASY ACCESS TO CONTACT',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final pageWidth = constraints.maxWidth;
            final isMobile = pageWidth < 600;
            final horizontalPadding = pageWidth < 400
                ? 22.0
                : pageWidth < 900
                ? 36.0
                : 64.0;

            return SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      isMobile ? 36 : 54,
                      horizontalPadding,
                      isMobile ? 36 : 54,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                }
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Welcome to Grela',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                  color: _muted,
                                  fontSize: isMobile ? 16 : 27,
                                ),
                              ),
                            ),
                            const SizedBox(width: 48),
                          ],
                        ),
                        SizedBox(height: isMobile ? 48 : 76),
                        _projectInfo('TYPE :', 'BUSINESS WEBSITE', isMobile),
                        SizedBox(height: isMobile ? 28 : 38),
                        _projectInfo('MY PART :', 'DESIGNING', isMobile),
                        SizedBox(height: isMobile ? 28 : 38),
                        _projectInfo('CLIENT :', 'GRELA', isMobile),
                        SizedBox(height: isMobile ? 42 : 68),
                        Text(
                          'GRELA is a landscape design company specializing in the development of sustainable and visually appealing outdoor spaces. Their services include garden planning, irrigation systems, and landscape maintenance, with a focus on combining functionality, aesthetics, and environmental responsibility.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            color: _muted,
                            fontSize: isMobile ? 14 : 18,
                            height: 1.6,
                          ),
                        ),
                        SizedBox(height: isMobile ? 48 : 68),
                        const _ProjectExpansionTile(
                          title: "WHAT'S THE PURPOSE?",
                          content:
                              'The purpose of this project is to present Grela and its landscape design services through a clear, engaging business website. The experience is designed to communicate the brand, showcase its work, and make information easy for visitors to explore.',
                        ),
                        SizedBox(height: isMobile ? 24 : 36),
                        const _ProjectExpansionTile(
                          title: 'FEATURES IMPLEMENTED',
                          content:
                              'The project focuses on a structured business website layout, responsive presentation across screen sizes, clear service information, and an intuitive browsing experience.',
                        ),
                        SizedBox(height: isMobile ? 48 : 64),

                        // SNEEK PEAK is a title, not a button.
                        Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 22 : 28,
                              vertical: isMobile ? 10 : 13,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: _foreground, width: 2),
                            ),
                            child: Text(
                              'S N E E K   P E A K',
                              style: GoogleFonts.montserrat(
                                color: _foreground,
                                fontSize: isMobile ? 11 : 14,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: isMobile ? 28 : 42),

                        // Swipeable three-slide showcase.
                        SizedBox(
                          height: isMobile ? 690 : 520,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: _previews.length,
                            onPageChanged: (index) {
                              setState(() => _currentPage = index);
                            },
                            itemBuilder: (context, index) {
                              return _GrelaPreviewCard(
                                preview: _previews[index],
                                isMobile: isMobile,
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              tooltip: 'Previous slide',
                              onPressed: _currentPage == 0
                                  ? null
                                  : () => _pageController.previousPage(
                                      duration: const Duration(
                                        milliseconds: 350,
                                      ),
                                      curve: Curves.easeInOut,
                                    ),
                              icon: const Icon(Icons.chevron_left, size: 30),
                              color: Colors.white,
                              disabledColor: Colors.white30,
                            ),
                            const SizedBox(width: 12),
                            ...List.generate(
                              _previews.length,
                              (index) => AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                width: _currentPage == index ? 22 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: _currentPage == index
                                      ? _foreground
                                      : _muted.withOpacity(0.45),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            IconButton(
                              tooltip: 'Next slide',
                              onPressed: _currentPage == _previews.length - 1
                                  ? null
                                  : () => _pageController.nextPage(
                                      duration: const Duration(
                                        milliseconds: 350,
                                      ),
                                      curve: Curves.easeInOut,
                                    ),
                              icon: const Icon(Icons.chevron_right, size: 30),
                              color: Colors.white,
                              disabledColor: Colors.white30,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _projectInfo(String label, String value, bool isMobile) {
    final style = GoogleFonts.montserrat(
      color: _foreground,
      fontSize: isMobile ? 15 : 18,
      fontWeight: FontWeight.w800,
      height: 1.25,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: style),
        Text(value, style: style),
      ],
    );
  }
}

class _GrelaPreview {
  const _GrelaPreview({
    required this.image,
    required this.heading,
    required this.description,
    required this.highlight,
  });

  final String image;
  final String heading;
  final String description;
  final String highlight;
}

class _GrelaPreviewCard extends StatelessWidget {
  const _GrelaPreviewCard({required this.preview, required this.isMobile});

  final _GrelaPreview preview;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      padding: EdgeInsets.all(isMobile ? 16 : 28),
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        border: Border.all(color: const Color(0xFF159BFF), width: 2.5),
        borderRadius: BorderRadius.circular(isMobile ? 24 : 32),
      ),
      child: isMobile
          ? Column(
              children: [
                Expanded(flex: 6, child: _previewImage(preview.image)),
                const SizedBox(height: 12),
                Expanded(flex: 5, child: _previewText()),
              ],
            )
          : Row(
              children: [
                Expanded(flex: 4, child: _previewImage(preview.image)),
                const SizedBox(width: 24),
                Expanded(flex: 6, child: _previewText()),
              ],
            ),
    );
  }

  Widget _previewImage(String imagePath) {
    return Center(
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Text(
            'Add screenshot here:\n$imagePath',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(color: Colors.black54, fontSize: 12),
          );
        },
      ),
    );
  }

  Widget _previewText() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              preview.heading,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: isMobile ? 15 : 23,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: isMobile ? 16 : 24),
            Text(
              preview.description,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: const Color(0xFF333333),
                fontSize: isMobile ? 13 : 19,
                height: 1.55,
              ),
            ),
            SizedBox(height: isMobile ? 22 : 48),
            Text(
              preview.highlight,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: isMobile ? 15 : 23,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectExpansionTile extends StatelessWidget {
  const _ProjectExpansionTile({required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFBDBDBD), width: 1.6),
          borderRadius: BorderRadius.circular(18),
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
          childrenPadding: const EdgeInsets.fromLTRB(22, 0, 22, 22),
          iconColor: const Color(0xFFBDBDBD),
          collapsedIconColor: const Color(0xFFBDBDBD),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          children: [
            Text(
              content,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: const Color(0xFFBDBDBD),
                fontSize: 14,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
