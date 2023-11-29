// toast메시지를 띄우는 페이지
// 기존 TOAST 패키지는 부족한 기능이 있어서 직접 만들어서 사용

import 'imports.dart';

class ToastWidget extends StatelessWidget {
  final String message;

  const ToastWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.4,
      left: MediaQuery.of(context).size.width * 0.1,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: AppColor.blueColor,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Font',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

void myShowToast(context, message) {
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => ToastWidget(message: message),
  );
  Overlay.of(context)?.insert(overlayEntry);

  // 일정 시간이 지난 후 Toast를 제거
  Future.delayed(Duration(seconds: 1), () {
    overlayEntry.remove();
  });
}
