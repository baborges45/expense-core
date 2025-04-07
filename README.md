# Mude Flutter Core

Biblioteca `core` do `Design System Mude` responsável por disponibilizar acesso a todos os componentes e tokens do Design System.

## Índice

- [Instalação](#instalação)
- [Configuração](#configuração)
- [Exemplo](#exemplo)
- [Entendendo Componentes](#entendendo-componentes)
  - [Arquitetura de Pastas](#arquitetura-de-pastas)
  - [Nomenclatura de Propriedades](#nomenclatura-de-propriedades)
  - [Acessibilidade](#acessibilidade)
- [Entendendo Tokens](#entendendo-tokens)
  - [Funcionamento](#funcionamento)
  - [Criando um novo componente a partir de Tokens](#criando-um-novo-componente-a-partir-de-tokens)
- [Qualidade de Código](#qualidade-de-código)
  - [Plugins VSCode](#plugins-vscode)
  - [Dart Analyze e DCM](#dart-analyze-e-dcm)
  - [Cobertura de Testes](#cobertura-de-testes)
  - [Relatório de Métricas](#relatório-de-métricas)
- [Dependências](#dependências)
  - [Suporte](#suporte)
  - [Externas](#externas)
  - [Desenvolvimento](#desenvolvimento)

## Instalação

Instale a `lib core` em uma pasta ao lado do projeto em que ela será utilizada.

```sh
git clone https://github.com/design-system-as-a-service/mude-flutter-core.git
```

ou

```sh
git clone git@github.com:design-system-as-a-service/mude-flutter-core.git
```

## Configuração

Adicione a `lib core` e a lib [provider](https://pub.dev/packages/provider) como depêndencia no `pubspec.yaml` do seu projeto:

```yaml
dependencies:
  flutter:
    sdk: flutter

  # ...

  provider: ^6.0.5 # lib provider

  mude_core:
    path: ../mude-flutter-core # lib core
```

No arquivo `main.dart`, antes de chamar o primeiro widget na função `main()`, adicione o `MultiProvider` e referencie o provider `ThemeManager` da `lib core` conforme o exemplo abaixo:

```dart

import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(                            // MultiProvider
      providers: [
        ChangeNotifierProvider(
          create: (_) => MudeThemeManager(      // ThemeManager
            theme: MudeThemeOptions.defaultt,   // definição de tema
            mode: MudeThemeMode.light,          // definição de modo
          ),
        )
      ],
      child: const MyApp(),                   // o primeiro widget
    ),
  );
}
```

Pronto, agora você já pode utilizar os tokens e componentes da `lib core` e fazer alterações de temas e modo automaticamente!

## Exemplo

Veja como é simples utilizar os tokens e componentes da `lib core`:

```dart
import 'package:mude_core/core.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);   // permite acesso à todos os tokens
    var spacingTokens = tokens.globals.shapes.spacing;
    var colorTokens = tokens.alias.color;

    return Scaffold(
      backgroundColor: colorTokens.elements.bgColor01,   // token de cor
      body: Padding(
        padding: EdgeInsets.all(spacingTokens.s4x),      // token de espaçamento
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MudeHeading("Login"),                          // componente de Header
            SizedBox(height: spacingTokens.s4x),
            MudeInputTextContainer(                        // componente de InputText
              label: 'E-mail',
            ),
            SizedBox(height: spacingTokens.s2x),         // token de espaçamento
            MudeInputPasswordContainer(                    // componente de InputPassword
              label: 'Senha',
            ),
            SizedBox(height: spacingTokens.s4x),         // token de espaçamento
            MudeButton(                                    // componente de Button
              label: 'Login',
              onPressed: () {/* go to Home Page */},
              type: MudeButtonType.blocked,
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## Entendendo Componentes

### Arquitetura de Pastas

Cada componente está organizado seguindo o modelo de arquitetura abaixo:

```js
├── src
│   ├── component_name
│       ├── mixins
│       ├── models
│       ├── types
│       ├── widgets
│       ├── component_name.dart
```

> Nem todos os componentes possuirão todas as pastas. Elas foram criadas ou não de acordo com a necessidade de cada um.

`mixins`

Os mixins são usados como potencializadores e gerenciadores de classes que compartilham funções em comum em várias partes do mesmo componente.

`models`

Os models são usados para ajudar a pessoa desenvolvedora a inserir exatamente os dados que o componente precisa.

`types`

Os types são usados para criar possibilidades de manipulação do componente, como tamanhos, tipos e estilos.

`widgets`

Os widgets são partes menores do componente.
Quando necessário, usamos a abordagem de [part](https://dart.dev/guides/language/effective-dart/usage) para evitar que esse widget seja exportado juntamente com os demais componentes.

`component_name.dart`

Arquivo centralizador de todo o código criado para o componente.

### Nomenclatura de Propriedades

Veja abaixo as principais convenções de nomenclaturas utilizadas no projeto para facilitar a criação e manutenção de novos componentes:

| Propriedade | Type      | Função                                         |
| ----------- | --------- | ---------------------------------------------- |
| disabled    | bool      | Desabilitar ou não o componente                |
| enabled     | bool      | Habilitar ou não o componente                  |
| inverse     | bool      | Inverter ou não as cores do componente         |
| actived     | bool      | Ativar ou não o componente                     |
| loading     | bool      | Ativar ou desativar o loading em um componente |
| items       | List\<T\> | Adicionar filhos/itens ao componente           |

#### Considerações gerais de nomenclatura

`show`

Toda propriedade iniciada com `show` indica se é ou não para mostrar alguma informação no componente. Ex: showNotification, showIcon, showBadge, etc.

`onChanged`

Toda função com retorno de alteração em um componente tem por padrão o nome `onChanged` e retorna um `value` com o valor exato do item. A tipagem `ValueChanged<T>` é usada como padrão.

`onPressed`

Toda função de ação tem por padrão o nome `onPressed` e é sem retorno.

`icon`

Toda propriedade `icon` é por padrão do tipo `MudeIconData`, contendo as seguintes propriedades:

```dart
 class MudeIconData {
    final String package; // nome do pacote onde está o asset
    final String path;    // caminho do asset dentro da biblioteca
    final String name;    // nome do asset para consumação
 }
```

> A tipagem do ícone vem da `lib de suporte ds_assets`.

### Acessibilidade

Por padrão, a maioria dos componentes trazem duas propriedades opcionais de acessibilidade:

```
- semanticsLabel
- semanticsHint
```

Para utilizar, basta atribuí-las ao componente da seguinte forma:

```dart
 MudeButton(
    label: 'Comprar',
    onPressed: () {},
    semanticsLabel: "Botão de Comprar",                      // semanticsLabel
    semanticsHint: "Efetua a compra dos itens do carrinho"   // semanticsHint
  ),
```

> O código da acessibilidade dos componentes é testada de acordo com a documentação padrão do [Flutter](https://docs.flutter.dev/accessibility-and-localization/accessibility?tab=desktop).

Também levamos em consideração o comportamento dos componentes nos seguintes pontos:

- [Contrastes de cores](https://docs.flutter.dev/accessibility-and-localization/accessibility?tab=voiceover#sufficient-contrast)
- Tamanho dos elementos interativos
- [Leitores de tela](https://docs.flutter.dev/accessibility-and-localization/accessibility?tab=voiceover#screen-readers) (TalkBack e VoiceOver)
- [Fator Escala](https://docs.flutter.dev/accessibility-and-localization/accessibility?tab=voiceover#large-fonts)

## Entendendo Tokens

### Funcionamento

Os tokens representam todas as cores, espaçamentos, tamanhos, características de bordas, sombras e opacidades disponíveis no Design System. Os componentes são construídos a partir dos tokens.

Utilize a classe `MudeThemeManager` via `provider` para encontrar os tokens:

```dart
var tokens = Provider.of<MudeThemeManager>(context);
```

Na variável `tokens` encontre todas as possibilidades de tokens agrupadas:

```dart
var globalTokens = tokens.globals;
var aliasTokens = tokens.alias;
var componentTokens = tokens.components;
```

Em `tokens.globals` temos as propriedades:

```dart
tokens.globals.border;     // tamanhos e raios de bordas
tokens.globals.opacity;    // opacidades
tokens.globals.shadow;     // sombras
tokens.globals.size;       // tamanhos
tokens.globals.spacing;    // espaçamentos
```

Em `tokens.alias` temos as propriedades:

```dart
tokens.alias.colors;       // Todas as cores
tokens.alias.defaultt;     // opções default de cores ou bordas
tokens.alias.mixin;        // mixin de propriedades
```

> Os `tokens.components` são criados a partir da necessidade de cada Design System, não sendo possível mapeá-los no momento.

### Criando um novo componente a partir de Tokens

Veja como é simples criar um novo componente utilizando tokens:

```dart
class MyRoundedContainer extends StatelessWidget {
  const MyRoundedContainer({super.key});

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context); // permite acesso à todos os tokens
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    return Container(
      width: globalTokens.shapes.size.s8x,             // largura do Container com size.s8x
      height: globalTokens.shapes.size.s8x,            // altura do Container com size.s8x
      decoration: BoxDecoration(
        color: aliasTokens.color.elements.bgColor02,   // cor do Container com elements.bgColor02
        borderRadius: BorderRadius.circular(
          globalTokens.shapes.border.radiusCircular,   // bordar circular do Container com radiusCircular
        ),
      ),
      child: Center(
        child: MudeIcon(icon: MudeIcons.PlaceholderLine),  // ícone MudeIcons.PlaceholderLine
      ),
    );
  }
}
```

## Qualidade de Código

### Plugins VSCode

Para manter um padrão instale no [VsCode](https://code.visualstudio.com/) os seguintes plugins:

| Name                                                                                                     | Função                                       |
| -------------------------------------------------------------------------------------------------------- | -------------------------------------------- |
| [Flutter](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)                         | Padrão Flutter                               |
| [Dart](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code)                          | Padrão Flutter                               |
| [Flutter Coverage](https://marketplace.visualstudio.com/items?itemName=Flutterando.flutter-coverage)     | Auxiliar na cobertura de testes              |
| [Flutter Gutters](https://marketplace.visualstudio.com/items?itemName=ryanluker.vscode-coverage-gutters) | Vsualizar linhas que faltam aplicar teste    |
| [DCM](https://marketplace.visualstudio.com/items?itemName=dcmdev.dcm-vscode-extension)                   | Metrificar a qualidade e padronizar o código |

### Derry

Instale o [derry](https://pub.dev/packages/derry) globalmente para executar os comandos das próximas etapas apropriadamente:

```sh
dart pub global activate derry
```

### Dart Analyze e DCM

Para manter a qualidade e bons padrões de código, utilizamos o [DCM statically analyzes](https://dcm.dev/) incorporado ao [Dart Analyze](https://dart.dev/tools/dart-analyze). Isso nos permite realizar melhorias em tempo de codificação.

Utilize o comando abaixo para executar o DCM:

```sh
derry dcm
```

As regras utilizadas atualmente são:

```js
avoid-passing-async-when-sync-expected
avoid-redundant-async
avoid-unnecessary-type-assertions
avoid-unnecessary-type-casts
avoid-unrelated-type-assertions
avoid-unused-parameters
avoid-nested-conditional-expressions
newline-before-return
no-boolean-literal-compare
no-empty-block
prefer-trailing-comma
prefer-conditional-expressions
no-equal-then-else
prefer-moving-to-variable
```

> Acompanhe todas as regras [aqui](analysis_options.yaml)

### Cobertura de Testes

Veja abaixo como gerar um relatório de testes completo:

> Necessário instalar o `lcov` que será usado para transformar os dados em html. Também indicamos adicionar a extenção `Flutter Gutters` e `Flutter Coverage` ao VSCode.

```sh
derry coverage
```

> Todos os componentes são testados e tenta manter o mínimo de 90% de cobertura.

### Relatório de Métricas

Veja abaixo como gerar um relatório de métricas:

```sh
derry metrics
```

> Será criada uma pasta chamada [metrics](metrics) com todos os dados necessários do relatório.

## Dependências

### Suporte

| Biblioteca                                                 | Versão | Função                            |
| ---------------------------------------------------------- | ------ | --------------------------------- |
| [ds_tokens](https://github.com/Meiuca/mude-flutter-tokens) | v0.0.2 | Contém os tokens do Design System |
| [ds_assets](https://github.com/Meiuca/mude-flutter-assets) | v0.0.2 | Contém os assets do Design System |

### Externas

| Biblioteca                                          | Versão | Função                                                         |
| --------------------------------------------------- | ------ | -------------------------------------------------------------- |
| [provider](https://pub.dev/packages/provider)       | ^6.0.5 | Compartilhar as informações do componente por toda a aplicação |
| [flutter_svg](https://pub.dev/packages/flutter_svg) | ^2.0.1 | Exibir arquivos em svgs                                        |
| [intl](https://pub.dev/packages/intl)               | ~      | Formatar de moedas e datas                                     |

### Desenvolvimento

| Biblioteca                                                        | Versão | Função                                   |
| ----------------------------------------------------------------- | ------ | ---------------------------------------- |
| [flutter_lints](https://pub.dev/packages/flutter_lints)           | ^2.0.0 | Manter padrão no código.                 |
| [dart_code_metrics](https://pub.dev/packages/dart_code_metrics)   | ^5.7.3 | Manter padrão e boas práticas no código. |
| [network_image_mock](https://pub.dev/packages/network_image_mock) | ^2.1.1 | Testar imagens com requisição externa.   |
