import SwiftUI
import Combine

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    
    func addTask(plantName: String, room: String, lightCondition: String, wateringDays: String, waterAmount: String) {
        let newTask = Task(plantName: plantName, room: room, lightCondition: lightCondition, wateringDays: wateringDays, waterAmount: waterAmount)
        tasks.append(newTask)
    }
}
