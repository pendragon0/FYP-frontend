import 'package:dart_openai/dart_openai.dart';

var prompt = '';

// void response() async {}

final systemMessage= OpenAIChatCompletionChoiceMessageModel(
  role: OpenAIChatMessageRole.assistant,
  content: [OpenAIChatCompletionChoiceMessageContentItemModel.text(
    'You are professional doctor who can diagnose CBC reports.'
    ),
  ],
);

final userMessage= OpenAIChatCompletionChoiceMessageModel(
  role: OpenAIChatMessageRole.user,
  content: [OpenAIChatCompletionChoiceMessageContentItemModel.text(
    'Make a random CBC report diagnose.'
    ),
  ],
);

final requestMessage = [
  systemMessage,
  userMessage,
];


generatingText() async {
  OpenAI.apiKey = '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';
  OpenAIChatCompletionModel chatCompletion = await OpenAI.instance.chat.create(
    model: 'ft:gpt-3.5-turbo-0613:personal:medscanvb07:9P9zOpcu',
    // responseFormat: {'type': 'json_object'},
    seed: 6,
    messages: requestMessage,
    temperature: 1,
    maxTokens: 256,
    );

    print(chatCompletion.choices.first.message);
}

// print(chatCompletion.choices.first.message);0