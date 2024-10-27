import SwiftUI

struct EditReminder: View {
    @Environment(\.dismiss) var dismiss

    // Binding to the reminder being edited
    @Binding var reminder: Reminder
    
    // Binding to the reminders list to allow deletion
    @Binding var reminders: [Reminder]
    
    var body: some View {
        NavigationStack {
            Spacer()
            VStack {
                HStack {
                    Button(action: { dismiss() }) {
                        Text("Cancel")
                            .foregroundColor(Color(red: 41/255, green: 223/255, blue: 168/255))
                            .padding(0.0)
                            .frame(width: 55.0)
                    }
                    
                    Spacer()
                    
                    Text("Edit Reminder")
                        .fontWeight(.bold)
                        .padding(-5.0)
                        .frame(width: 106.0)
                    
                    Spacer()
                    
                    Button(action: {
                        // You can perform any additional actions to save or update the reminder here
                        dismiss()
                    }) {
                        Text("Save")
                            .foregroundColor(Color(red: 41/255, green: 223/255, blue: 168/255))
                    }
                }
                .padding()
                
                // Inputs for editing the reminder
                VStack {
                    HStack {
                        Text("Plant Name ")
                        TextField("Pothos", text: $reminder.plantName)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
                
                VStack {
                    HStack {
                        Label("Room", systemImage: "location")
                        Spacer()
                        Picker("Room", selection: $reminder.room) {
                            ForEach(SetReminder.roomOptions.allCases, id: \.self) { room in
                                Text(room.rawValue)
                                    .tag(room)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                    HStack {
                        Label("Light", systemImage: reminder.light.icon)
                        Spacer()
                        Picker("Light", selection: $reminder.light) {
                            ForEach(SetReminder.LightCondition.allCases, id: \.self) { light in
                                Text(light.rawValue)
                                    .tag(light)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
                
                VStack {
                    HStack {
                        Label("Watering Days", systemImage: "drop")
                        Spacer()
                        Picker("Water Days", selection: $reminder.waterDays) {
                            ForEach(SetReminder.WateringDaysOptions.allCases, id: \.self) { waterDays in
                                Text(waterDays.rawValue).tag(waterDays)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                    HStack {
                        Label("Water", systemImage: "drop")
                        Spacer()
                        Picker("Water Amount", selection: $reminder.waterAmount) {
                            ForEach(SetReminder.WaterOptions.allCases, id: \.self) { waterAmount in
                                Text(waterAmount.rawValue).tag(waterAmount)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
                

                VStack {
                    Button(action: {
                        if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
                            reminders.remove(at: index)
                        }
                        dismiss()
                    }) {
                        Text("Delete Reminder")
                            .bold()
                            .foregroundColor(.red)
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
            }
            Spacer()
            .padding(.top)
        }
    }
}

#Preview {
    @State var mockReminders: [Reminder] = [
        Reminder(plantName: "Pothos", room: .bedroom, light: .fullSun, waterDays: .daily, waterAmount: .one)
    ]
    
    // Pass the state as a binding to the EditReminder preview
    return EditReminder(reminder: .constant(mockReminders[0]), reminders: .constant(mockReminders))
}
