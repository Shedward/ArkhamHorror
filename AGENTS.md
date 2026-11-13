# DistrictDeck

Основной workspace — `DistrictDeck.xcworkspace`, схема приложения — `DistrictDeck`. Точка входа лежит в `Apps/DistrictDeck`, локальные Swift-пакеты — в `Packages/`. Для зависимости между пакетами укажи относительный путь в `Package.swift` потребителя. Подключение продукта непосредственно к приложению и команды сборки описаны в [README](README.md).

Для `$todo` используй [Documentation/Tasks/](Documentation/Tasks/) как папку задач. При запуске доски из корня передавай `--tasks Documentation/Tasks`. Согласованные принципы проекта записывай в [Documentation/Principles.md](Documentation/Principles.md).

В [Reference/](Reference/) находится предыдущий прототип: обращайся к нему за примерами реализации, игровыми данными и тестами. Его [инструкции по сборке](Reference/AGENTS.md) относятся только к референсу.
