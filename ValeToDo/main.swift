//
//  main.swift
//  ValeToDo
//
//  Created by Валерия Пономарева on 06.05.2026.
//

import Foundation

// MARK: - Модель задачи
struct Task {
    let id = UUID()
    let title: String
    var isCompleted: Bool
}

// MARK: - Команды
enum Command: String {
    case addTask = "add task"
    case showAll = "show all tasks"
    case showCompleted = "show completed tasks"
    case showUncompleted = "show uncompleted tasks"
    case deleteTask = "delete task"
    case changeStatus = "change status"
}

// MARK: - Менеджер задач
class TaskManager {
    private(set) var tasks: [Task] = []
    
    func add(_ title: String) {
        let trimmed = title.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else {
            print("❌ Title cannot be empty")
            return
        }
        tasks.append(Task(title: trimmed, isCompleted: false))
        print("✅ Added: \"\(trimmed)\"")
    }
    
    // Универсальный метод печати (статус вычисляется внутри)
    private func printTasks(_ tasks: [Task], title: String) {
        guard !tasks.isEmpty else {
            print("📭 \(title)")
            return
        }
        print("\n\(title):")
        tasks.enumerated().forEach { index, task in
            let emoji = task.isCompleted ? "✅" : "❌"
            print("\(index + 1). \(emoji) \"\(task.title)\"")
        }
    }
    
    func displayAll() {
        printTasks(tasks, title: "📋 All tasks")
    }
    
    func showCompleted() {
        printTasks(tasks.filter { $0.isCompleted }, title: "✅ Completed tasks")
    }
    
    func showUncompleted() {
        printTasks(tasks.filter { !$0.isCompleted }, title: "❌ Uncompleted tasks")
    }
    
    func delete(at index: Int) -> Bool {
        guard tasks.indices.contains(index) else { return false }
        let removed = tasks.remove(at: index)
        print("🗑️ Deleted: \"\(removed.title)\"")
        return true
    }
    
    func toggleStatus(at index: Int) -> Bool {
        guard tasks.indices.contains(index) else { return false }
        tasks[index].isCompleted.toggle()
        let status = tasks[index].isCompleted ? "✅" : "❌"
        print("🔄 Status changed to \(status): \"\(tasks[index].title)\"")
        return true
    }
    
    func isEmpty() -> Bool {
        tasks.isEmpty
    }
}

// MARK: - Основная программа
let manager = TaskManager()

print("""
Commands:
  ➕ add task
  👁️ show all tasks
  ✅ show completed tasks
  ❌ show uncompleted tasks
  🗑️ delete task
  🔄 change status
  🚪 exit
""")

while true {
    print("\n> ", terminator: "")
    guard let input = readLine()?.trimmingCharacters(in: .whitespaces), !input.isEmpty else { continue }
    
    if input == "exit" {
        print("👋 Goodbye!")
        break
    }
    
    guard let command = Command(rawValue: input) else {
        print("❌ Unknown command: \"\(input)\"")
        continue
    }
    
    switch command {
    case .addTask:
        print("📝 Enter title: ", terminator: "")
        guard let title = readLine()?.trimmingCharacters(in: .whitespaces), !title.isEmpty else {
            print("❌ Title cannot be empty")
            continue
        }
        manager.add(title)
        
    case .showAll:
        manager.displayAll()
        
    case .showCompleted:
        manager.showCompleted()
        
    case .showUncompleted:
        manager.showUncompleted()
        
    case .deleteTask, .changeStatus:
        guard !manager.isEmpty() else {
            print("📭 No tasks")
            continue
        }
        manager.displayAll()
        print(command == .deleteTask ? "🗑️ Delete number: " : "🔄 Change number: ", terminator: "")
        guard let input = readLine(), let num = Int(input), (1...manager.tasks.count).contains(num) else {
            print("❌ Invalid number")
            continue
        }
        if command == .deleteTask {
            _ = manager.delete(at: num - 1)
        } else {
            _ = manager.toggleStatus(at: num - 1)
        }
    }
}
     

