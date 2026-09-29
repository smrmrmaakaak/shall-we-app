import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../models/date_proposal.dart';
import '../widgets/ticket_card.dart';

class HomeTicketScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;
  final Locale currentLocale;

  const HomeTicketScreen({
    super.key,
    required this.onLocaleChange,
    required this.currentLocale,
  });

  @override
  State<HomeTicketScreen> createState() => _HomeTicketScreenState();
}

class _HomeTicketScreenState extends State<HomeTicketScreen> {
  late ConfettiController _confettiController;
  int _declineCount = 0;

  DateProposal get _currentProposal {
    final lang = widget.currentLocale.languageCode;
    if (lang == 'en') {
      return const DateProposal(
        id: '№ 2026-1018-07',
        title: 'Shall we go on\na date this weekend?',
        dateTimeText: 'Oct 18 (Sat) 18:30',
        place: 'Seongsu Candle Bistro',
        dressCode: 'Casual Chic 🖤',
        memo: 'Their truffle lasagna & natural wine are amazing! Reserved our table, please come :)',
        imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=800&q=80',
      );
    } else if (lang == 'ja') {
      return const DateProposal(
        id: '№ 2026-1018-07',
        title: '今週末、\nデートしませんか？',
        dateTimeText: '10月18日 (土) 18:30',
        place: '聖水洞 キャンドルビストロ',
        dressCode: 'カジュアルシック 🖤',
        memo: 'ここのトリュフラザニアとワインが本当に美味しいの！予約できたから絶対来てね :)',
        imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=800&q=80',
      );
    }
    return const DateProposal(
      id: '№ 2026-1018-07',
      title: '이번 주말,\n나랑 데이트할래?',
      dateTimeText: '10월 18일 (토) 18:30',
      place: '성수동 캔들 비스트로',
      dressCode: '캐주얼 시크 🖤',
      memo: '여기 와인이랑 트러플 라자냐 진짜 맛있대! 예약 성공했으니까 꼭 와줘 :)',
      imageUrl: 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=800&q=80',
    );
  }

  List<String> get _currentDeclineTexts {
    final lang = widget.currentLocale.languageCode;
    if (lang == 'en') {
      return [
        'Check calendar later',
        'Really...? 🥺',
        'The pasta is incredible!',
        'My treat, still no?',
        'Last chance! 😆',
      ];
    } else if (lang == 'ja') {
      return [
        '日程また確認するね',
        'え、本当に...？ 🥺',
        'パスタとワイン最高なのに！',
        '奢るから行こうよ！',
        'ラストチャンスだよ！ 😆',
      ];
    }
    return [
      '일정 다시 잡자',
      '진짜루...? 🥺',
      '파스타랑 와인 진짜 맛있는데?',
      '내가 다 살 건데도 안 갈 거야?',
      '마지막 기회야! 😆',
    ];
  }

  String get _acceptButtonText {
    final lang = widget.currentLocale.languageCode;
    if (lang == 'en') return 'Yes, absolutely!';
    if (lang == 'ja') return 'うん、絶対行く！';
    return '좋아, 무조건 갈래!';
  }

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

  void _onAccept() {
    _confettiController.play();
    final lang = widget.currentLocale.languageCode;
    final dialogTitle = lang == 'en' ? "It's a Date! 🎉" : (lang == 'ja' ? 'デート約束成立！ 🎉' : '데이트 약속 성사!');
    final dialogDesc = lang == 'en'
        ? 'Acceptance notification sent.\nAdded to your calendar automatically!'
        : (lang == 'ja'
            ? 'お相手に承認通知が送信されました。\nカレンダーにも自動登録完了！'
            : '상대방에게 수락 완료 알림이 전송되었습니다.\n아이폰 캘린더에 일정이 자동 등록됩니다!');
    final dialogBtn = lang == 'en' ? 'Great, see you!' : (lang == 'ja' ? '確認 (完了)' : '확인 (완료)');

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🎉', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 12),
              Text(
                dialogTitle,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              Text(
                dialogDesc,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600, height: 1.5),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(dialogBtn, style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onDecline() {
    setState(() {
      _declineCount = (_declineCount + 1) % _currentDeclineTexts.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentLang = widget.currentLocale.languageCode.toUpperCase();

    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Row(
          children: [
            Text(
              'Shall We',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: 22,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(width: 4),
            CircleAvatar(radius: 3, backgroundColor: Colors.redAccent),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade300),
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
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [Colors.red, Colors.pink, Colors.purple, Colors.amber, Colors.blue],
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TicketCard(
                          proposal: _currentProposal,
                          onAccept: _onAccept,
                          onDecline: _onDecline,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.white,
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  ),
                                  onPressed: _onAccept,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _acceptButtonText,
                                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                                      ),
                                      const SizedBox(width: 6),
                                      const Text('♥', style: TextStyle(color: Colors.pinkAccent, fontSize: 16)),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              AnimatedScale(
                                scale: _declineCount == 0 ? 1.0 : 0.95,
                                duration: const Duration(milliseconds: 200),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 48,
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.grey.shade700,
                                      side: BorderSide(color: Colors.grey.shade300),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                    ),
                                    onPressed: _onDecline,
                                    child: Text(
                                      _currentDeclineTexts[_declineCount % _currentDeclineTexts.length],
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
      onTap: () => widget.onLocaleChange(locale),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade600,
            fontSize: 10,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
