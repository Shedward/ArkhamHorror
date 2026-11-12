# Arkham Horror

Учебный проект на Swift для моделирования правил настольной игры Arkham Horror. Приложения для iOS и macOS собираются через `Arkham Horror.xcodeproj`. У каждого модуля свой `Package.swift`. Все пути и команды ниже даны относительно этой папки: из корня репозитория сначала выполни `cd Reference`.

## Где вносить изменения

| Задача | Куда смотреть |
| --- | --- |
| Игровая сцена, выбор кампании, действия игрока | `Applications/Game/Game/Sources/Game`. Точка входа приложения — `Applications/Game/GameApp.swift`. Пакетный `MainView` создаёт `GameScene` и запускает первый эпизод. Схемы — `Game (iOS)` и `Game (macOS)`. |
| Меню и экраны выбора истории и персонажей на SwiftUI | `Applications/ArkhamHorrorGame/ArkhamHorrorGame`. Это отдельное приложение со схемами `Arkham Horror (iOS)` и `Arkham Horror (macOS)`. |
| Кампании, игроки, правила хода и загрузка данных | `Domain/ArkhamHorror`. Общие типы, включая идентификаторы и навыки, лежат в `Domain/Common`. |
| Топология и геометрия карты | `Domain/Map`. За отображение поля, камеры и фигур в SceneKit отвечает `UI/Scenes`. |
| Карты событий и их действия | `Domain/Cards`. Общий язык выражений реализован в `Utils/Script`, разбор размеченного текста — в `Utils/FormattedText`. |
| Элементы интерфейса | `UI/HUD` содержит кнопки, коллекции и компоновку SpriteKit. Палитры, шрифтовые стили и иконки собраны в `UI/DesignSystem`. |
| Переиспользуемые алгоритмы | `Utils/Deck` — колоды и перемешивание, `Utils/Graph` — графы, `Utils/Prelude` — общие типы и функции. Для тестов есть `Utils/XCTestUtils`. |

## Эпизоды и игровые данные

- Для нового эпизода `Game` запусти, например, `python3 Scripts/make_game_episode InspectClue`. Используй новое имя в PascalCase. Скрипт копирует шаблон в `Applications/Game/Game/Sources/Game/Scene/Episodes` и перезаписывает одноимённые файлы. Заполни плейсхолдеры в `Episode` и `ViewModel`, затем вызови фабрику из `Module` в месте перехода. Пример готовой связки — `Campaign/SelectPath` внутри каталога эпизодов.
- За образец кампании возьми `Applications/Game/Game/Sources/Game/Resources/Campaigns/industrial_demo`. Пакет копирует дерево `Campaigns` целиком. `DirectoryCampaignLoader` ожидает `campaign.yml`, `map.yml` и `characters/*.yml`. Имя папки кампании должно совпадать с её `id`, а имя файла персонажа без расширения — с его `id`. Ссылки вида `//resources/campaignLogo.png` отсчитываются от папки кампании.
- Новую команду карты события добавляй в `Domain/Cards/Sources/Cards/Events/ActionExpressions` и регистрируй её парсер в `EventActionScriptParser.create()`. Положи пример в `Domain/Cards/Tests/CardsTests/Resources/TestData/events`. Тест `EventCardTests.testAllCards` разбирает каждый файл и сверяет его имя с идентификатором карты.

## Сборка и тесты

Тесты движка выражений можно запустить напрямую через SwiftPM. Пакет `Utils/Script` не требует внешних зависимостей.

```sh
swift test --package-path Utils/Script
```

Для сборки приложения и тестирования нескольких пакетов используй проект Xcode. План `TestPlans/UnitTests.xctestplan` подключён к обеим macOS-схемам и включает тесты из `Domain`, `Utils` и проверку загрузки демо-кампании из ресурсов `Game`. Точный список задан в `testTargets` плана.

```sh
xcodebuild -project 'Arkham Horror.xcodeproj' -scheme 'Game (macOS)' \
  -destination 'platform=macOS' build

xcodebuild -project 'Arkham Horror.xcodeproj' -scheme 'Game (macOS)' \
  -destination 'platform=macOS' -testPlan UnitTests test
```

Для запуска в Xcode выбери схему `Game (macOS)` и устройство **My Mac** либо `Game (iOS)` и симулятор iPhone. Нажми **Run**, выбери обложку **Industrial**, затем **Start**. Схемы `Arkham Horror` открывают отдельное SwiftUI-меню. Для локальных Debug-сборок macOS используется подпись «Sign to Run Locally».
