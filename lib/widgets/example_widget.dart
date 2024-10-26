import 'package:flutter/material.dart';

class Model extends ChangeNotifier {
  var one = 0;
  var two = 0;

  void inc1() {
    one += 1;
    notifyListeners();
  }

  void inc2() {
    two += 1;
    notifyListeners();
  }
}

class ModelProvider extends InheritedNotifier {
  final Model model;
  const ModelProvider({
    super.key,
    required this.model,
    required super.child,
  }) : super(notifier: model);

  static ModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ModelProvider>();
  }

  static ModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ModelProvider>()
        ?.widget;
    return widget is ModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(ModelProvider oldWidget) {
    return true;
  }
}

class ExampleWidget extends StatefulWidget {
  const ExampleWidget({super.key});

  @override
  State<ExampleWidget> createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  final model = Model();
  @override
  Widget build(BuildContext context) {
    return ModelProvider(
      model: model,
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    final model = ModelProvider.read(context)!.model;
    return Scaffold(
      appBar: AppBar(title: const Text("Example of work")),
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: model.inc1,
              child: const Text("one"),
            ),
            ElevatedButton(
              onPressed: model.inc2,
              child: const Text("two"),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("complex"),
            ),
            const _OneWidget(),
            const _TwoWidget(),
            const _ThreeWidget(),
            const _FourWidget(),
          ],
        ),
      ),
    );
  }
}

class _OneWidget extends StatelessWidget {
  const _OneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final value = ModelProvider.watch(context)!.model.one;
    return Text('$value');
  }
}

class _TwoWidget extends StatelessWidget {
  const _TwoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final value = ModelProvider.watch(context)!.model.two;
    return Text('$value');
  }
}

class _ThreeWidget extends StatelessWidget {
  const _ThreeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("0");
  }
}

class _FourWidget extends StatelessWidget {
  const _FourWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("0");
  }
}
