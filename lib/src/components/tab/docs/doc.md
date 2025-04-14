# ExpenseTab

Para utilizar o componente ExpenseTab é necessário que ele esteja englobado por um `DefaultTabController` que por sua vez necessita da propriedade `length` indicando qual a quantidade de tabs devem ser renderizadas.

O ExpenseTab utiliza como dependencia outro componente interno chamado `ExpenseTabItem`, sua instância fica assim:

```dart
ExpenseTab(
    tabs: [
    ExpenseTabItem(label: 'Label'),
    ExpenseTabItem(label: 'Label'),
    ExpenseTabItem(label: 'Label'),
  ],
)
```

O `ExpenseTab` tem as seguintes propriedades disponíveis.

```dart
required List<ExpenseTabItem> tabs,
bool isFixed = false,
bool isScrollable = true,
Function(int)? onPressed,
```

| Name         | Type                         | Required | Description                                                          |
| ------------ | ---------------------------- | -------- | -------------------------------------------------------------------- |
| tabs         | List<ExpenseTabItem>         | true     | Lista de ExpenseTabItem                                              |
| isFixed      | bool                         | false    | Adiciona uma linha por toda a Tab                                    |
| isScrollable | bool                         | false    | Determinar se a ExpenseTab utilizará scroll entre os ExpenseTabItems |
| onPressed    | ValueChanged(int)? onPressed | false    | Retornar o index da ExpenseTabItem selecionada                       |

O `ExpenseTabItem` tem as seguintes propriedades disponíveis.

```dart
required String label,
ExpenseIconData? icon,
bool showNotification = false,
```

| Name             | Type            | Required | Description                                           |
| ---------------- | --------------- | -------- | ----------------------------------------------------- |
| label            | String          | true     | Nome que ficará visível                               |
| icon             | ExpenseIconData | false    | ExpenseIcons que será mostrado                        |
| showNotification | bool            | false    | Indicador circular vermelho indicando uma notificação |

Como usar:

```dart
class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('ExpenseTab'),
          elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ExpenseTab(
              tabs: [
                ExpenseTabItem(label: 'Tab A'),
                ExpenseTabItem(label: 'Tab B'),
                ExpenseTabItem(label: 'Tab C'),
              ],
              children: [
                Container(),
                Container(),
                Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```
