part of 'package:infinite_horizons/domain/vibration_controller.dart';

class _VibrationRepository extends VibrationController {
  @override
  Future initialize() async {
    canVibrate = await Vibrate.canVibrate;
  }

  late bool canVibrate;

  @override
  Future vibrate(VibrationType type) async {
    if (!canVibrate) {
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
