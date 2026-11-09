import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/features/projects/model/project_model.dart';

class ProjectDetailsView extends StatefulWidget {
  const ProjectDetailsView({super.key, required this.project});

  final ProjectModel project;

  @override
  State<ProjectDetailsView> createState() => _ProjectDetailsViewState();
}

class _ProjectDetailsViewState extends State<ProjectDetailsView> {
  static const Color _background = Color(0xFF1D1D1D);
  static const Color _foreground = Color(0xFFF5F5F5);
  static const Color _muted = Color(0xFFBDBDBD);

  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;

    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final isMobile = width < 600;
            final horizontalPadding = width < 400
                ? 22.0
                : width < 900
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
                        _buildHeader(project.name, isMobile),
                        SizedBox(height: isMobile ? 48 : 76),
                        _ProjectInfo(
                          label: 'TYPE :',
                          value: project.type,
                          isMobile: isMobile,
                        ),
                        SizedBox(height: isMobile ? 28 : 38),
                        _ProjectInfo(
                          label: 'MY PART :',
                          value: project.role,
                          isMobile: isMobile,
                        ),
                        SizedBox(height: isMobile ? 28 : 38),
                        _ProjectInfo(
                          label: 'CLIENT :',
                          value: project.client,
                          isMobile: isMobile,
                        ),
                        SizedBox(height: isMobile ? 42 : 68),
                        Text(
                          project.description,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            color: _muted,
                            fontSize: isMobile ? 14 : 18,
                            height: 1.6,
                          ),
                        ),
                        SizedBox(height: isMobile ? 48 : 68),
                        _ProjectExpansionTile(
                          title: "WHAT'S THE PURPOSE?",
                          content: project.purpose,
                        ),
                        SizedBox(height: isMobile ? 24 : 36),
                        _ProjectExpansionTile(
                          title: 'FEATURES IMPLEMENTED',
                          content: project.features,
                        ),
                        SizedBox(height: isMobile ? 48 : 64),
                        _buildShowcaseTitle(isMobile),
                        SizedBox(height: isMobile ? 28 : 42),
                        SizedBox(
                          height: isMobile ? 690 : 520,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: project.previews.length,
                            onPageChanged: (index) {
                              setState(() => _currentPage = index);
                            },
                            itemBuilder: (context, index) {
                              return _ProjectPreviewCard(
                                preview: project.previews[index],
                                isMobile: isMobile,
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 18),
                        _buildPageControls(project.previews.length),
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

  Widget _buildHeader(String projectName, bool isMobile) {
    return Row(
      children: [
        IconButton(
          tooltip: 'Go back',
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          icon: const Icon(Icons.arrow_back, color: _foreground),
        ),
        Expanded(
          child: Text(
            'Welcome to $projectName',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: _muted,
              fontSize: isMobile ? 16 : 27,
            ),
          ),
        ),
        const SizedBox(width: 48),
      ],
    );
  }

  Widget _buildShowcaseTitle(bool isMobile) {
    return Center(
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
    );
  }

  Widget _buildPageControls(int pageCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          tooltip: 'Previous slide',
          onPressed: _currentPage == 0
              ? null
              : () => _pageController.previousPage(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOut,
                ),
          icon: const Icon(Icons.chevron_left, size: 30),
          color: Colors.white,
          disabledColor: Colors.white30,
        ),
        const SizedBox(width: 12),
        ...List.generate(
          pageCount,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 4),
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
          onPressed: _currentPage == pageCount - 1
              ? null
              : () => _pageController.nextPage(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOut,
                ),
          icon: const Icon(Icons.chevron_right, size: 30),
          color: Colors.white,
          disabledColor: Colors.white30,
        ),
      ],
    );
  }
}

class _ProjectInfo extends StatelessWidget {
  const _ProjectInfo({
    required this.label,
    required this.value,
    required this.isMobile,
  });

  final String label;
  final String value;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final style = GoogleFonts.montserrat(
      color: const Color(0xFFF5F5F5),
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

class _ProjectPreviewCard extends StatelessWidget {
  const _ProjectPreviewCard({required this.preview, required this.isMobile});

  final ProjectPreview preview;
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

class _ProjectExpansionTile extends StatefulWidget {
  const _ProjectExpansionTile({required this.title, required this.content});

  final String title;
  final String content;

  @override
  State<_ProjectExpansionTile> createState() => _ProjectExpansionTileState();
}

class _ProjectExpansionTileState extends State<_ProjectExpansionTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFBDBDBD), width: 1.5),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ExpansionTile(
          onExpansionChanged: (value) {
            setState(() => _expanded = value);
          },
          tilePadding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 28,
            vertical: isMobile ? 5 : 10,
          ),
          childrenPadding: EdgeInsets.fromLTRB(
            isMobile ? 18 : 30,
            0,
            isMobile ? 18 : 30,
            isMobile ? 18 : 24,
          ),
          trailing: AnimatedRotation(
            turns: _expanded ? 0.5 : 0,
            duration: const Duration(milliseconds: 200),
            child: const Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFF9E9E9E),
              size: 25,
            ),
          ),
          title: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: isMobile ? 12 : 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          children: [
            Text(
              widget.content,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: const Color(0xFFBDBDBD),
                fontSize: isMobile ? 12 : 15,
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
