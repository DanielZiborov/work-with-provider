import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Complex {
  var valueOne = 0;
  var valueTwo = 0;
}

class Model extends ChangeNotifier {
  var one = 0;
  var two = 0;
  final complex = Complex();

  void inc1() {
    one += 1;
    notifyListeners();
  }

  void inc2() {
    two += 1;
    notifyListeners();
  }

  void inc3() {
    complex.valueOne += 1;
    notifyListeners();
  }

  void inc4() {
    complex.valueTwo += 1;
    notifyListeners();
  }
}

class ForExample extends ChangeNotifier {
  var one = 0;

  void inc1() {
    one += 1;
    notifyListeners();
  }
}

class Wrapper {
  final Model model;
  final ForExample forExample;
  Wrapper(this.model, this.forExample);
}

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Model()),
        ChangeNotifierProvider(create: (_) => ForExample()),
        ProxyProvider2(
          update: (
            BuildContext context,
            Model model,
            ForExample forExample,
            prev,
          ) {
            return Wrapper(model, forExample);
          },
        ),
      ],
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    final model = context.read<Model>();
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
              onPressed: model.inc3,
              child: const Text("complex1"),
            ),
            ElevatedButton(
              onPressed: model.inc4,
              child: const Text("complex2"),
            ),
            const _OneWidget(),
            const _TwoWidget(),
            const _ThreeWidget(),
            const _FourWidget(),
            Consumer<Model>(builder: (context, model, _) {
              return Text("${model.one}");
            }),
            Consumer2<Model,ForExample>(builder: (context,model,forExample,_){
              return Text("${model.one}");
            }),
          ],
        ),
      ),
    );
  }
}

class _OneWidget extends StatelessWidget {
  const _OneWidget();

  @override
  Widget build(BuildContext context) {
    final value = context.select((Model value) => value.one);
    return Text('$value');
  }
}

class _TwoWidget extends StatelessWidget {
  const _TwoWidget();

  @override
  Widget build(BuildContext context) {
    final value = context.select((Model value) => value.two);
    return Text('$value');
  }
}

class _ThreeWidget extends StatelessWidget {
  const _ThreeWidget();

  @override
  Widget build(BuildContext context) {
    final value = context.select((Model value) => value.complex.valueOne);
    return Text("$value");
  }
}

class _FourWidget extends StatelessWidget {
  const _FourWidget();

  @override
  Widget build(BuildContext context) {
    final value = context.watch<Wrapper>().forExample.one;
    return Text("$value");
  }
}
