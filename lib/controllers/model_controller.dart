import 'package:dart_openai/dart_openai.dart';
import 'package:projm/controllers/prompt_handler.dart';
import 'package:projm/models/shareddata.dart';



// void response() async {}

Future<String> generatingText() async {

String prompt = createPrompt(testResults);
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
    prompt
    ),
  ],
);

final requestMessage = [
  systemMessage,
  userMessage,
];

OpenAI.apiKey = 'your api key';
OpenAIChatCompletionModel chatCompletion = await OpenAI.instance.chat.create(
  model: 'ft:gpt-3.5-turbo-0613:personal:medscanvb07:9P9zOpcu',
  // responseFormat: {'type': 'json_object'},
  seed: 6,
  messages: requestMessage,
  temperature: 1,
  maxTokens: 256,
  );

  print('PROMPT ENTERED*********: $prompt');
  // print(chatCompletion.choices.first.message);

  String? diagnosis = chatCompletion.choices.first.message.content?[0].text;
  return diagnosis ?? 'Could not diagnose';
}

// print(chatCompletion.choices.first.message);0