# MudeTab

Para utilizar o componente MudeTab é necessário que ele esteja englobado por um `DefaultTabController` que por sua vez necessita da propriedade `length` indicando qual a quantidade de tabs devem ser renderizadas.

O MudeTab utiliza como dependencia outro componente interno chamado `MudeTabItem`, sua instância fica assim:

```dart
MudeTab(
    tabs: [
    MudeTabItem(label: 'Label'),
    MudeTabItem(label: 'Label'),
    MudeTabItem(label: 'Label'),
  ],
)
```

O `MudeTab` tem as seguintes propriedades disponíveis.

```dart
required List<MudeTabItem> tabs,
bool isFixed = false,
bool isScrollable = true,
Function(int)? onPressed,
```

| Name         | Type                         | Required | Description                                                    |
| ------------ | ---------------------------- | -------- | -------------------------------------------------------------- |
| tabs         | List<MudeTabItem>            | true     | Lista de MudeTabItem                                           |
| isFixed      | bool                         | false    | Adiciona uma linha por toda a Tab                              |
| isScrollable | bool                         | false    | Determinar se a MudeTab utilizará scroll entre os MudeTabItems |
| onPressed    | ValueChanged(int)? onPressed | false    | Retornar o index da MudeTabItem selecionada                    |

O `MudeTabItem` tem as seguintes propriedades disponíveis.

```dart
required String label,
MudeIconData? icon,
bool showNotification = false,
```

| Name             | Type         | Required | Description                                           |
| ---------------- | ------------ | -------- | ----------------------------------------------------- |
| label            | String       | true     | Nome que ficará visível                               |
| icon             | MudeIconData | false    | MudeIcons que será mostrado                           |
| showNotification | bool         | false    | Indicador circular vermelho indicando uma notificação |

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
          title: Text('MudeTab'),
          elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MudeTab(
              tabs: [
                MudeTabItem(label: 'Tab A'),
                MudeTabItem(label: 'Tab B'),
                MudeTabItem(label: 'Tab C'),
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
