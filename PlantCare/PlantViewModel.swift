import Foundation
import SwiftUI

class ReminderViewModel: ObservableObject {
    @Published var reminders: [Reminder] = []
    
    func addReminder(_ reminder: Reminder) {
        reminders.append(reminder)
    }
    
    func editReminder(_ updatedReminder: Reminder) {
        if let index = reminders.firstIndex(where: { $0.id == updatedReminder.id }) {
            reminders[index] = updatedReminder
        }
    }
    
    func deleteReminder(_ reminder: Reminder) {
        reminders.removeAll(where: { $0.id == reminder.id })
    }
    
    func toggleCompletion(for reminder: Reminder) {
        if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
            reminders[index].isCompleted.toggle()
        }
    }
}
