# Shall We? (우리 만날래?) 🍷💌

> **성수동 힙스터 감성 티켓 기반의 데이트 신청 & 초대장 앱 (iOS & Android)**  
> 윈도우에서 개발하고 맥북 없이 GitHub Actions 클라우드로 아이폰/안드로이드 앱을 즉시 빌드합니다.

---

## ✨ 핵심 기능

1. **🎟️ 빈티지 모던 감성 티켓 UI**
   - 실사 캔들 비스트로 포토와 절취선 티켓 디자인
   - 바코드 및 장소, 시간, 드레스코드 뱃지
2. **🌐 3개국어 다국어(i18n) 시스템**
   - 한국어 (`ko`), 영어 (`en`), 일본어 (`ja`) 실시간 전환 지원
   - 아이폰 시스템 언어 자동 감지
3. **🎉 수락 시 축하 폭죽(Confetti) & 캘린더 등록**
   - 상대방이 "좋아, 무조건 갈래!" 수락 시 화면 가득 폭죽 애니메이션
   - Apple Calendar / Google Calendar 자동 연동
4. **😆 장난꾸러기 거절 버튼**
   - "일정 다시 잡자"를 누를 때마다 유쾌하게 도망치며 멘트가 바뀌는 바이럴 장치
5. **☁️ GitHub Actions 클라우드 빌드**
   - 맥북을 사지 않아도 GitHub에 코드를 푸시하면 가상 macOS 러너에서 자동으로 아이폰 앱(`.ipa`)과 안드로이드(`.apk`)를 무료로 빌드

---

## 📂 프로젝트 구조

```text
shall_we_app/
├── .github/
│   └── workflows/
│       └── build_ios.yml       # GitHub Actions iOS/Android 자동 빌드 워크플로우
├── lib/
│   ├── l10n/
│   │   ├── app_ko.arb          # 한국어 사전
│   │   ├── app_en.arb          # 영어 사전
│   │   └── app_ja.arb          # 일본어 사전
│   ├── models/
│   │   └── date_proposal.dart  # 데이트 초대장 데이터 모델
│   ├── screens/
│   │   └── home_ticket_screen.dart # 메인 티켓 화면 & 인터랙션
│   ├── widgets/
│   │   └── ticket_card.dart    # 감성 티켓 위젯
│   └── main.dart               # 앱 진입점 및 테마/다국어 세팅
├── l10n.yaml                   # Flutter 다국어 코드 생성 설정
├── pubspec.yaml                # Flutter 패키지 의존성
└── README.md
```

---

## 🚀 GitHub Actions로 아이폰 앱 빌드하기

1. 이 저장소를 GitHub에 푸시합니다:
   ```bash
   git add .
   git commit -m "feat: Shall We date proposal app v1.0.0"
   git push origin master
   ```
2. GitHub 저장소의 **Actions** 탭으로 이동합니다.
3. `Build iOS & Android Apps (No Mac Required)` 워크플로우가 자동으로 실행되며, 약 3~5분 후 완료됩니다.
4. **Artifacts** 섹션에서 `ShallWe-iOS-App` 및 `ShallWe-Android-APK`를 즉시 다운로드할 수 있습니다!
