import Foundation

struct Reminder: Identifiable {
    var id = UUID()
    var plantName: String
    var room: SetReminder.roomOptions
    var light: SetReminder.LightCondition
    var waterDays: SetReminder.WateringDaysOptions
    var waterAmount: SetReminder.WaterOptions
    var isCompleted: Bool = false
}

