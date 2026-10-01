# Moment Route Training

Moment Route 팀의 개발·협업 과정을 처음부터 한 번 경험해 보는 작은 Flutter 앱입니다.

프로그래밍 시험이 아니며, **화면과 코드가 연결되는 방식을 직접 발견하고 작은 변경을 GitHub Pull Request로 공유하는 것**이 목표입니다.

## 이 훈련에서 하게 되는 일

전체 과정은 다음과 같습니다.

**프로젝트 받기 → 앱 실행 → 화면 둘러보기 → 개인 Branch 만들기 → 관련 코드 찾기 → 코드 읽기 → 변경 결과 예상 → 작은 수정 → 앱에서 결과 확인 → Commit → Push → Pull Request**

문서의 역할은 다음과 같습니다.

- **README.md**: 프로젝트를 받고 실행하기 위한 준비 안내
- **ONBOARDING.md**: 앱을 실행한 뒤 진행하는 실제 훈련 미션

먼저 이 README를 따라 앱을 실행하세요.

앱이 정상적으로 실행되면 [ONBOARDING.md](ONBOARDING.md)의 Mission 1부터 진행합니다.

> `main` Branch에서 과제 코드를 수정하지 마세요.  
> 앱을 먼저 확인한 뒤 ONBOARDING 안내에 따라 자신의 Branch를 만들고 작업합니다.

AI를 사용해도 됩니다. 다만 AI에게 전체 과정을 대신 맡기기보다, **화면을 직접 보고 관련 코드를 찾아 읽고 내가 무엇을 바꾸는지는 이해한 상태로 진행하는 것**이 이 훈련의 목적입니다.

---

## 준비할 프로그램

- Flutter SDK
- Android Studio
  - Android SDK와 Emulator 설치에 사용합니다.
- Visual Studio Code
  - 이 문서는 **VS Code 기준**으로 설명합니다.
  - Android Studio에서 코드를 편집해도 괜찮습니다.
- Git
- GitHub 계정
- 선택 사항: USB 케이블로 연결할 Android 휴대폰

Flutter를 처음 설치한다면 [Flutter 공식 설치 안내](https://docs.flutter.dev/get-started/install)를 따라 설치하세요.

설치가 끝나면 새 터미널을 열고 다음 명령을 실행합니다.

```bash
flutter doctor
```

`✓`는 해당 항목이 준비되었다는 뜻입니다.

Android 관련 항목에 문제가 표시된다면 안내 문장을 읽고 필요한 Android SDK나 라이선스 설정을 마치세요.

Android에서 실행할 예정이라면 다른 플랫폼까지 모두 준비할 필요는 없습니다.

---

## GitHub에서 프로젝트 처음 받기

이미 `moment-route-training` 프로젝트 폴더를 받은 상태라면 이 부분을 건너뛰고 **프로젝트 실행하기**로 이동해도 됩니다.

### 1. 프로젝트를 저장할 폴더 선택하기

문서나 개발 프로젝트를 보관할 폴더를 하나 선택합니다.

아직 `moment-route-training` 폴더를 직접 만들 필요는 없습니다. `git clone` 명령이 같은 이름의 폴더를 자동으로 만듭니다.

### 2. 선택한 폴더에서 PowerShell 열기

Windows 파일 탐색기로 선택한 폴더를 연 뒤 빈 공간을 마우스 오른쪽 버튼으로 누르고 **터미널에서 열기**를 선택합니다.

메뉴가 없다면 PowerShell을 연 다음 `cd` 명령으로 원하는 폴더까지 이동해도 됩니다.

현재 위치를 확인하려면 다음 명령을 실행합니다.

```powershell
Get-Location
```

### 3. GitHub repository clone하기

```powershell
git clone https://github.com/moment-route/moment-route-training.git
```

`git clone`은 GitHub에 있는 기준 프로젝트를 내 컴퓨터로 복사하는 명령입니다.

명령이 끝나면 현재 위치 아래에 `moment-route-training` 폴더가 생성됩니다.

GitHub 로그인이나 저장소 접근 권한을 요구한다면 팀장에게 자신의 GitHub 계정에 저장소 접근 권한이 있는지 확인하세요.

### 4. 생성된 프로젝트 폴더로 이동하기

```powershell
cd .\moment-route-training
```

`cd`는 터미널의 현재 위치를 다른 폴더로 이동하는 명령입니다.

### 5. 현재 위치 확인하기

```powershell
Get-Location
Get-ChildItem
```

`Get-Location` 결과의 마지막 폴더 이름이 `moment-route-training`인지 확인합니다.

`Get-ChildItem`은 현재 폴더의 파일 목록을 보여줍니다.

목록에 다음 파일이 보이면 올바른 위치입니다.

- `README.md`
- `ONBOARDING.md`
- `pubspec.yaml`

### 6. VS Code에서 프로젝트 열기

```powershell
code .
```

`code .`은 현재 폴더를 VS Code로 엽니다.

`code` 명령을 찾을 수 없다는 오류가 나오면 VS Code를 직접 실행한 뒤:

**File → Open Folder**

에서 `moment-route-training` 폴더를 선택하세요.

---

## 프로젝트 실행하기

VS Code에서 프로젝트를 열었다면:

**Terminal → New Terminal**

로 터미널을 엽니다.

터미널의 현재 위치가 `moment-route-training` 폴더인지 확인한 뒤 다음 명령을 순서대로 실행합니다.

```bash
flutter pub get
flutter devices
flutter run
```

각 명령의 역할은 다음과 같습니다.

- `flutter pub get`: 앱 실행에 필요한 Flutter 패키지를 준비합니다.
- `flutter devices`: 현재 앱을 실행할 수 있는 휴대폰이나 Emulator를 보여줍니다.
- `flutter run`: 선택한 기기에서 앱을 실행합니다.

기기가 여러 개라면 실행할 기기를 선택하라는 안내가 나올 수 있습니다.

앱 실행 중 코드를 저장하면 대부분의 작은 변경은 바로 반영됩니다.

반영되지 않는다면 실행 중인 터미널에서:

- `r`: Hot Reload
- `R`: 앱 다시 시작

을 사용할 수 있습니다.

---

## Android 휴대폰 연결하기

1. 휴대폰 설정에서 **개발자 옵션**을 활성화합니다.
2. 보통 **휴대전화 정보 → 소프트웨어 정보 → 빌드 번호**를 여러 번 누르면 활성화됩니다.
3. 개발자 옵션에서 **USB 디버깅**을 켭니다.
4. USB 케이블로 컴퓨터와 휴대폰을 연결합니다.
5. 휴대폰에 USB 디버깅 허용 창이 뜨면 허용합니다.
6. 터미널에서 다음 명령을 실행합니다.

```bash
flutter devices
```

휴대폰 이름이 보이는지 확인한 뒤:

```bash
flutter run
```

을 실행합니다.

기종에 따라 설정 메뉴 이름은 조금 다를 수 있습니다.

실제 Android 휴대폰이 없다면 Android Studio의 **Device Manager**에서 Emulator를 만들고 실행한 뒤 `flutter devices`를 다시 확인하세요.

---

## 실행이 안 될 때 먼저 확인할 것

1. 현재 터미널 위치가 `moment-route-training` 폴더인지 확인합니다.
2. `flutter doctor`에서 Android 관련 오류가 있는지 확인합니다.
3. `flutter devices`에 실행할 기기가 표시되는지 확인합니다.
4. 실제 휴대폰을 사용한다면 화면이 잠겨 있지 않은지 확인합니다.
5. USB 디버깅을 허용했는지 확인합니다.
6. `flutter pub get`을 다시 실행합니다.
7. 오류 메시지의 첫 부분을 천천히 읽어봅니다.

오류 내용이 어렵다면 AI나 팀원에게 오류 메시지를 보여주고:

- 이 오류가 무슨 뜻인지
- 무엇부터 확인해야 하는지

를 물어봐도 괜찮습니다.

환경 준비가 끝나고 앱이 실행됐다면 [ONBOARDING.md](ONBOARDING.md)의 Mission 1부터 진행하세요.