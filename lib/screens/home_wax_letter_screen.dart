import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import '../models/date_proposal.dart';
import '../widgets/animated_wax_letter.dart';

class HomeWaxLetterScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;
  final Locale currentLocale;

  const HomeWaxLetterScreen({
    super.key,
    required this.onLocaleChange,
    required this.currentLocale,
  });

  @override
  State<HomeWaxLetterScreen> createState() => _HomeWaxLetterScreenState();
}

class _HomeWaxLetterScreenState extends State<HomeWaxLetterScreen> {
  late ConfettiController _confettiController;
  bool _isOpened = true;
  int _declineIndex = 0;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  // Multilingual Data Mappings
  DateProposal get _currentProposal {
    final lang = widget.currentLocale.languageCode;
    if (lang == 'en') {
      return const DateProposal(
        id: '№ 2026-1018-07',
        title: 'Are you free\nthis weekend?',
        dateTimeText: 'Saturday, Oct 18 · 18:30',
        place: 'Seongsu Candle Bistro',
        dressCode: 'Casual Chic 🖤',
        memo: 'Truffle lasagna & natural wine reserved. Please come :)',
        imageUrl: '',
      );
    } else if (lang == 'ja') {
      return const DateProposal(
        id: '№ 2026-1018-07',
        title: '今週末、\n時間空いてる？',
        dateTimeText: '10月18日 (土) 18:30',
        place: '聖水洞 キャンドルビストロ',
        dressCode: 'カジュアルシック 🖤',
        memo: 'トリュフラザニアとワイン予約したよ！絶対来てね :)',
        imageUrl: '',
      );
    }
    return const DateProposal(
      id: '№ 2026-1018-07',
      title: '이번 주말에\n시간 어때?',
      dateTimeText: '10월 18일 토요일 18:30',
      place: '성수동 캔들 비스트로',
      dressCode: '캐주얼 시크 🖤',
      memo: '와인이랑 트러플 라자냐 예약 완료! 꼭 와줘 :)',
      imageUrl: '',
    );
  }

  String get _acceptBtnText {
    final lang = widget.currentLocale.languageCode;
    if (lang == 'en') return "Yes, I'd love to! ♥";
    if (lang == 'ja') return 'うん、絶対行く！ ♥';
    return '좋아, 무조건 갈래! ♥';
  }

  List<String> get _declineTexts {
    final lang = widget.currentLocale.languageCode;
    if (lang == 'en') {
      return [
        'Check calendar later',
        'Really...? 🥺',
        'I already reserved the table! 🍷',
        'My treat, still no? 😆',
        'Last chance! ♥',
      ];
    } else if (lang == 'ja') {
      return [
        '日程また確認するね',
        'え、本当に...？ 🥺',
        '美味しいワイン用意したのに！ 🍷',
        '奢るから行こうよ！ 😆',
        'ラストチャンスだよ！ ♥',
      ];
    }
    return [
      '일정 다시 잡자',
      '진짜 안 갈 거야? 🥺',
      '맛있는 와인도 준비했는데.. 🍷',
      '내가 다 살게! 그래도? 😆',
      '마지막 기회야! ♥',
    ];
  }

  String get _modalTitle {
    final lang = widget.currentLocale.languageCode;
    if (lang == 'en') return "It's a Date! 🥂";
    if (lang == 'ja') return 'デート約束成立！ 🥂';
    return '초대장 수락 완료! 🍷';
  }

  String get _modalDesc {
    final lang = widget.currentLocale.languageCode;
    if (lang == 'en') {
      return 'Acceptance notification sent.\nEvent added to your calendar automatically.';
    }
    if (lang == 'ja') {
      return 'お相手に承認通知が送信されました。\nカレンダーにも自動登録完了！';
    }
    return '상대방에게 수락 알림이 전송되었어요.\n아이폰 캘린더에 일정이 등록되었습니다.';
  }

  String get _modalBtnText {
    final lang = widget.currentLocale.languageCode;
    if (lang == 'en') return 'Awesome, see you!';
    if (lang == 'ja') return '確認 (完了)';
    return '확인 (성사 완료)';
  }

  void _onToggleEnvelope() {
    setState(() {
      _isOpened = !_isOpened;
    });
  }

  void _onWaxSealTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.currentLocale.languageCode == 'en'
              ? 'Wax seal inspected 🍷'
              : '왁스 실링 도장 터치됨 🍷',
          style: GoogleFonts.gowunBatang(),
        ),
        duration: const Duration(milliseconds: 900),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF870C23),
      ),
    );
  }

  void _onDeclineTap() {
    setState(() {
      _declineIndex = (_declineIndex + 1) % _declineTexts.length;
      // Playfully close the letter slightly if rejected
      _isOpened = false;
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) setState(() => _isOpened = true);
      });
    });
  }

  void _onAcceptTap() {
    _confettiController.play();

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        backgroundColor: const Color(0xFFFFFDF9),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF850E22),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x40850E22),
                      blurRadius: 16,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text('💌', style: TextStyle(fontSize: 28)),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                _modalTitle,
                style: GoogleFonts.gowunBatang(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF221713),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _modalDesc,
                textAlign: TextAlign.center,
                style: GoogleFonts.gowunBatang(
                  fontSize: 13,
                  color: const Color(0xFF6B5D55),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF850E22),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(
                    _modalBtnText,
                    style: GoogleFonts.gowunBatang(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Background Aesthetic Marble Grain
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFCF9F3),
                    Color(0xFFF4ECE1),
                    Color(0xFFEDE2D2),
                  ],
                ),
              ),
            ),
          ),

          // Confetti Particle Layer
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Color(0xFF850E22),
                Color(0xFFD4AF37),
                Color(0xFFE5A93C),
                Color(0xFFFFF0D4),
                Color(0xFF6B588E),
              ],
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Top App Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shall We',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1E1613),
                          letterSpacing: -0.5,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.75),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFFDCD2C3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            _buildLangButton('KO', const Locale('ko')),
                            _buildLangButton('EN', const Locale('en')),
                            _buildLangButton('JA', const Locale('ja')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Center Stage: Animated Wax Letter
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        AnimatedWaxLetter(
                          proposal: _currentProposal,
                          isOpened: _isOpened,
                          onToggle: _onToggleEnvelope,
                          onWaxSealTap: _onWaxSealTap,
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),

                // Bottom Action Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    children: [
                      // Accept Primary Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF850E22),
                            foregroundColor: Colors.white,
                            elevation: 8,
                            shadowColor: const Color(0xFF850E22).withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          onPressed: _onAcceptTap,
                          child: Text(
                            _acceptBtnText,
                            style: GoogleFonts.gowunBatang(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Decline Secondary Button
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: const Color(0xFFF7F2E9),
                            foregroundColor: const Color(0xFF382B24),
                            side: const BorderSide(
                              color: Color(0xFFD9CCBA),
                              width: 1.2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          onPressed: _onDeclineTap,
                          child: Text(
                            _declineTexts[_declineIndex],
                            style: GoogleFonts.gowunBatang(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
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

  Widget _buildLangButton(String text, Locale locale) {
    final isSelected = widget.currentLocale.languageCode == locale.languageCode;
    return GestureDetector(
      onTap: () {
        widget.onLocaleChange(locale);
        setState(() => _declineIndex = 0);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E1613) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: GoogleFonts.gowunBatang(
            color: isSelected ? Colors.white : const Color(0xFF75685E),
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
