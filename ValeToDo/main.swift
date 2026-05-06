//
//  main.swift
//  ValeToDo
//
//  Created by Валерия Пономарева on 06.05.2026.
//

import Foundation

// MARK: - Модель задачи
struct Task {
    let id = UUID()          // ✅ уникальный идентификатор (auto генерируется)
    let title: String        // ✅ название задачи (не изменяется после создания)
    var isCompleted: Bool    // ✅ статус (можно менять)
}

// MARK: - Команды
enum Command: String {   // raw value типа String
    case addTask = "add task"   // raw value == "add task"
    case showAll = "show all tasks" // Raw value — это строка, которую вводит user, чтобы выбрать команду.
    case showCompleted = "show completed tasks" // Raw value - одно предопределённое значение на кейс
    case showUncompleted = "show uncompleted tasks" // Raw value —> кейс всегда связан с одной и той же let
    case deleteTask = "delete task"
    case changeStatus = "change status"
}

// MARK: - Менеджер задач
class TaskManager { // ✅ класс — это ссылочный тип (reference type)
    private(set) var tasks: [Task] = [] // private(set) — геттер публичный (читать можно везде), сеттер приватный (менять можно только ВНУТРИ класса). Это защита массива от случайных изменений ИЗВНЕ.
    
    func add(_ title: String) {   // ✅ функция с одним параметром типа String
        let trimmed = title.trimmingCharacters(in: .whitespaces)   // ✅ удаляет пробелы в начале и конце
        guard !trimmed.isEmpty else {      // ✅ проверка на пустую строку
            print("❌ Title cannot be empty")
            return
        }
        tasks.append(Task(title: trimmed, isCompleted: false))  // ✅ создаёт задачу и добавляет в массив
        print("✅ Added: \"\(trimmed)\"")
    }
    
    func displayAll() {   // ✅ метод класса TaskManager
        guard !tasks.isEmpty else {   // ✅ проверка на пустой массив → ранний выход
            print("📭 No tasks")
            return
        }
        print("\n📋 All tasks:")      // ✅ \n — новая строка, 📋 — визуальный маркер
        tasks.enumerated().forEach { index, task in   // ✅ enumerated()  даёт индекс и элемент + forEach
            let status = task.isCompleted ? "✅" : "❌"   // ✅ тернарный оператор для статуса
            print("\(index + 1). \(status) \"\(task.title)\"")   // ✅ индекс+1, статус, название в кавычках
        }
    }
    
    func showCompleted() {
        let completed = tasks.filter { $0.isCompleted } // оставляем только завершённые задачи
        guard !completed.isEmpty else { // проверка массива на пустоту
            print("✅ No completed tasks")
            return
        }
        print("\n✅ Completed tasks:") // \n — новая строка
        completed.enumerated().forEach { index, task in // замыкание: индекс + задача → печать
            print("\(index + 1). ✅ \"\(task.title)\"")
        }
    }
    
    func showUncompleted() {
        let uncompleted = tasks.filter { !$0.isCompleted } // замыкание: оставляем только невыполненные задачи
        guard !uncompleted.isEmpty else {
            print("❌ No uncompleted tasks")
            return
        }
        print("\n❌ Uncompleted tasks:")
        uncompleted.enumerated().forEach { index, task in // замыкание: индекс + задача → печать
            print("\(index + 1). ❌ \"\(task.title)\"")
        }
    }
    
    func delete(at index: Int) -> Bool { // метод 'удаляем по индексу массива' возвращает булево значение
        guard index >= 0 && index < tasks.count else { return false } // если соответствует индекс диапазону
        let removed = tasks.remove(at: index) // создаем константу для хранения удаленной задачи
        print("🗑️ Deleted: \"\(removed.title)\"")
        return true
    }
    
    func toggleStatus(at index: Int) -> Bool { // переключаем статус задачи
        guard index >= 0 && index < tasks.count else { return false } // безопасно проверяем
        tasks[index].isCompleted.toggle() // если индекс внутри диапазона - переключаем на false
        let status = tasks[index].isCompleted ? "✅" : "❌" // создали константу со значением доступ к масиву по индексу задача выполнена/нет - тернарный оператор
        print("🔄 Status changed to \(status): \"\(tasks[index].title)\"")
        return true // возвращаем true — успешное переключение статуса
    }
    
    func isEmpty() -> Bool {
        tasks.isEmpty
    }
}

// MARK: - Основная программа
print("🎯 Welcome to ValeToDo!")
print("""
Commands:
📋 Commands:
  ➕ add task
  👁️ show all tasks
  ✅ show completed tasks
  ❌ show uncompleted tasks
  🗑️ delete task
  🔄 change status
  ➡️ exit
""")

let manager = TaskManager() // создали экземпляр класса

while true { // запустили цикл - выполняется, пока условие истинно
    print("\n> ", terminator: "") // новая строка + разделитель
    guard let input = readLine()?.trimmingCharacters(in: .whitespaces), !input.isEmpty else { continue }
    // читаем строку, удаляем пробелы по краям, если строка пустая или nil → повторяем цикл
    if input == "exit" { break } // выход из цикла
    
    guard let command = Command(rawValue: input) else {  // преобразует строку в enum Command
        print("❌ Unknown command: \"\(input)\"") // Если команда неизвестна → печатаем ошибку и подсказку
        print("Try: add task | show all tasks | exit")
        continue
    }
    
    switch command { // пишем свич? 'команда' с кейсами
    case .addTask:
        print("📝 Enter title:")
        guard let title = readLine()?.trimmingCharacters(in: .whitespaces), !title.isEmpty else {
            print("❌ Title cannot be empty") // безопасно разворачиваем и читаем строку + удаляем пробелы по краям + если строка юзера пуста / nil -> повторяем цикл
            continue // прерываем текущую итерацию цикла, начинаем сначала (печатаем меню)
        }
        manager.add(title) // вызываем метод у экземпляра manager
        
    case .showAll:
        manager.displayAll() // вызываем метод у экземпляра manager
        
    case .showCompleted:
        manager.showCompleted()
        
    case .showUncompleted:
        manager.showUncompleted()
        
    case .deleteTask:
        guard !manager.isEmpty() else {
            print("📭 No tasks to delete")
            continue
        }
        manager.displayAll() // вызываем метод у экземпляра класса
        print("🗑️ Enter number:")
        guard let input = readLine(), let number = Int(input), number > 0, number <= manager.tasks.count else { //
            print("❌ Invalid number")
            continue
        }
        _ = manager.delete(at: number - 1) // вызываем метод, но возвращаемое значение функции игнорируем
        
    case .changeStatus:
        guard !manager.isEmpty() else {
            print("📭 No tasks to update")
            continue
        }
        manager.displayAll()
        print("🔄 Enter number:")
        guard let input = readLine(), let number = Int(input), number > 0, number <= manager.tasks.count else {
            print("❌ Invalid number")
            continue
        }
        _ = manager.toggleStatus(at: number - 1)
    }
}

print("👋 Goodbye!")
     

