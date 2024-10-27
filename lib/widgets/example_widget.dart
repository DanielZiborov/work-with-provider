import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Model {
  final int one;
  final int two;

  Model({
    required this.one,
    required this.two,
  });
}

class ExampleWidget extends StatefulWidget {
  const ExampleWidget({super.key});

  @override
  State<ExampleWidget> createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  var model = Model(one: 0, two: 0);

  void inc1() {
    model = Model(one: model.one + 1, two: model.two);
    setState(() {});
  }

  void inc2() {
    model = Model(one: model.one, two: model.two + 1);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: this,
      child: Provider.value(
        value: model,
        child: const _View(),
      ),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    final state = context.read<_ExampleWidgetState>();
    return Scaffold(
      appBar: AppBar(title: const Text("Example of work")),
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: state.inc1,
              child: const Text("one"),
            ),
            ElevatedButton(
              onPressed: state.inc2,
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
    final value = context.watch<Model>().one;
    return Text('$value');
  }
}

class _TwoWidget extends StatelessWidget {
  const _TwoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final value = context.watch<Model>().two;
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
