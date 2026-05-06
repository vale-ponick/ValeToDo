//
//  Untitled.swift
//  ValeToDo
//
//  Created by Валерия Пономарева on 06.05.2026.
//
## 🔥 Особенности этой версии

- 🧹 Минималистичный менеджер задач
- 🧠 Команды через `enum`
- 🖨️ Единый метод печати `printTasks`
- 🔁 Общая логика выбора номера для удаления и изменения статуса
- 🎨 Подсветка статуса эмодзи (✅ / ❌)

## 🚀 Пример работы


Commands:
  ➕ add task
  👁️ show all tasks
  ✅ show completed tasks
  ❌ show uncompleted tasks
  🗑️ delete task
  🔄 change status
  🚪 exit

> add task
📝 Enter title: buy milk
✅ Added: "buy milk"

> show all tasks

📋 All tasks:
1. ❌ "buy milk"

> change status
📋 All tasks:
1. ❌ "buy milk"
🔄 Change number: 1
🔄 Status changed to ✅: "buy milk"

> exit
👋 Goodbye!
📦 Структура
Task — структура задачи (id, title, isCompleted)

Command — enum команд (rawValue String)

TaskManager — класс с логикой (добавление, удаление, отображение, смена статуса)

main.swift — ввод/вывод, цикл обработки команд

📦 Структура проекта
Файл    Описание
main.swift    Точка входа, цикл обработки команд
TaskManager    Логика: добавление, удаление, отображение, смена статуса
Task    Структура задачи (id, title, isCompleted)
Command    Перечисление команд (String raw values)
🧪 Запуск
Открой ValeToDo.xcodeproj или main.swift

Нажми Cmd + R (Run)

Вводи команды в консоль

✍️ Автор
Валерия Поник (vale-ponick)
Проект создан в рамках изучения Swift.

📅 2026
