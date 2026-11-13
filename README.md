# DistrictDeck

DistrictDeck — рабочее название движка для сюжетных настольных игр с игровым полем, ходами и колодами событий.

Открой [DistrictDeck.xcworkspace](DistrictDeck.xcworkspace/) в Xcode 27.2, выбери схему **DistrictDeck** и **My Mac** или симулятор iPhone, затем нажми Run. Стартовый экран показывает название приложения.

## Структура

- [Apps/DistrictDeck](Apps/DistrictDeck/) — точка входа общего SwiftUI-приложения для iOS 16+ и macOS 13+.
- [Packages](Packages/) — дерево локальных Swift-пакетов. Первый пакет, [DistrictDeckUI](Packages/App/DistrictDeckUI/Package.swift), содержит стартовый экран.
- [project.xcproj](DistrictDeck.xcodeproj/project.xcproj) — конфигурация приложения в штатном формате JSON Xcode 27.

## Как добавить пакет

Создай каталог на нужном уровне, например `Packages/Engine/Rules/Cards/`, и выполни в нём `swift package init --type library --name Cards`. Если пакет использует платформенные API, укажи поддерживаемые версии в его `Package.swift`. Workspace подхватывает пакеты внутри `Packages/` по структуре папок.

Чтобы использовать `Cards` в `DistrictDeckUI`, добавь `.package(path: "../../Engine/Rules/Cards")` в `dependencies` манифеста `DistrictDeckUI`, а `.product(name: "Cards", package: "Cards")` — в зависимости его таргета. SwiftPM считает путь от папки манифеста потребителя. Приложение получит транзитивную зависимость при сборке.

Если продукт нужен непосредственно таргету приложения, его можно подключить из корня командой Xcode 27.2:

```sh
xcrun xcodeproj pkg add-local Packages/Engine/Rules/Cards --product Cards --target DistrictDeck
```

## Сборка из терминала

```sh
xcodebuild -workspace DistrictDeck.xcworkspace -scheme DistrictDeck -destination 'platform=macOS' build
xcodebuild -workspace DistrictDeck.xcworkspace -scheme DistrictDeck -destination 'generic/platform=iOS Simulator' build
```

## Референс

Предыдущий прототип Arkham Horror сохранён в [Reference](Reference/).

- [Сборка и запуск прототипа](Reference/AGENTS.md#сборка-и-тесты)
- [Архитектурное ревью и материалы для переноса](Reference/docs/architecture-review.md)
