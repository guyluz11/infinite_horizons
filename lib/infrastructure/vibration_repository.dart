part of 'package:infinite_horizons/domain/controllers/vibration_controller.dart';

class _VibrationRepository extends VibrationController {
  @override
  Future init() async => supported = Platform.isAndroid || Platform.isIOS;

  @override
  Future vibrate(VibrationType type) async {
    if (!supported) {
      return;
    }

    FeedbackType feedbackType;
    switch (type) {
      case VibrationType.light:
        feedbackType = FeedbackType.success;
      case VibrationType.medium:
        feedbackType = FeedbackType.warning;
      case VibrationType.heavy:
        feedbackType = FeedbackType.error;
    }

    Vibrate.feedback(feedbackType);
  }
}
