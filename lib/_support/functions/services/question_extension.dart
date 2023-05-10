part of 'functions_service.dart';

extension QuestionExtension on FunctionsService {
  Future<BasicAnswerModel> answerQuestion(String question) async {
    final res = await client.post(
      'v1/question/basic',
      data: {'question': question},
    );

    return BasicAnswerModel.fromJson(res.data['data']);
  }
}
