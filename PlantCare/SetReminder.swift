import SwiftUI

// Define the Reminder struct here
struct Reminder: Identifiable {
    var id = UUID()  // Unique identifier for each reminder
    var plantName: String
    var room: SetReminder.roomOptions
    var light: SetReminder.LightCondition
    var waterDays: SetReminder.WateringDaysOptions
    var waterAmount: SetReminder.WaterOptions
    var isCompleted: Bool = false
}

struct SetReminder: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var plantName: String = ""
    @State private var selectedRoom: roomOptions = .bedroom
    @State private var selectedLight: LightCondition = .fullSun
    @State private var selectedWateringDay: WateringDaysOptions = .daily
    @State private var selectedWaterAmount : WaterOptions = .one
    
//    @State private var reminders: [Reminder] = []
    @Binding var reminders: [Reminder]
    @State private var navigateToReminders = false
    
    enum roomOptions: String, CaseIterable {
        case bedroom = "Bedroom"
        case livingroom = "Living Room"
        case kitchen = "Kitchen"
        case balcony = "Balcony"
        case bathroom = "Bathroom"
    }
    
    enum LightCondition: String, CaseIterable {
        case fullSun = "Full Sun"
        case partialSun = "Partial Sun"
        case lowLight = "Low Light"

        var icon: String {
            switch self {
            case .fullSun:
                return "sun.max"
            case .partialSun:
                return "cloud.sun"
            case .lowLight:
                return "moon"
            }
        }
    }
    
    enum WateringDaysOptions: String, CaseIterable {
        case daily = "Every day"
        case twodaily = "Every 2 days"
        case threedaily = "Every 3 days"
        case weekly = "Once a week"
        case tendays = "Every 10 days"
        case twoweek = "Every 2 weeks"
    }
    
    enum WaterOptions: String, CaseIterable {
        case one = "20-50 ml"
        case two = "50-100 ml"
        case three = "100-200 ml"
        case four = "200-300 ml"
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Button(action: { dismiss() })
                    {
                        Text("Cancel")
                            .foregroundColor(Color(red: 41/255, green: 223/255, blue: 168/255))
                            .padding(0.0)
                            .frame(width: 55.0)
                    }
                    
                    Spacer()
                    
                    Text("Set Reminder")
                        .fontWeight(.bold)
                        .padding(-5.0)
                        .frame(width: 106.0)
                    
                    Spacer()
                    
                    Button(action: {
                        // Add new reminder to list
                        let newReminder = Reminder(plantName: plantName.isEmpty ? "Pothos" : plantName, room: selectedRoom, light: selectedLight, waterDays: selectedWateringDay, waterAmount: selectedWaterAmount)
                        reminders.append(newReminder)
                        
                        // Reset input fields
                        plantName = ""
                        selectedRoom = .bedroom
                        selectedLight = .fullSun
                        selectedWateringDay = .daily
                        selectedWaterAmount = .one
                        
                        // Trigger navigation to reminder list
//                        navigateToReminders = true
                        dismiss()
                    }) {
                        Text("Save")
                            .foregroundColor(Color(red: 41/255, green: 223/255, blue: 168/255))
                    }
                }
                .padding()
                
                // Inputs for adding a new reminder
                VStack{
                    HStack{
                        Text("Plant Name ")
                        TextField("Pothos", text: $plantName)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
                
                VStack{
                    HStack{
                        Label("Room", systemImage: "location")
                        Spacer()
                        Picker("Room", selection: $selectedRoom) {
                            ForEach(roomOptions.allCases, id: \.self) { room in
                                Text(room.rawValue)
                                    .tag(room)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                    HStack{
                        Label("Light", systemImage: selectedLight.icon)
                        Spacer()
                        Picker("Light", selection: $selectedLight) {
                            ForEach(LightCondition.allCases, id: \.self) { light in
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
                
                VStack{
                    HStack{
                        Label("Watering Days", systemImage: "drop")
                        Spacer()
                        Picker("waterDays", selection: $selectedWateringDay) {
                            ForEach(WateringDaysOptions.allCases, id: \.self) { waterDays in
                                Text(waterDays.rawValue).tag(waterDays)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                    HStack{
                        Label("Water", systemImage: "drop")
                        Spacer()
                        Picker("water", selection: $selectedWaterAmount) {
                            ForEach(WaterOptions.allCases, id: \.self) { water in
                                Text(water.rawValue).tag(water)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
                Spacer()
                
                // Trigger the navigation using the simplified method
//                NavigationLink(destination: StartApp(reminders: reminders), isActive: $navigateToReminders) {
//                    EmptyView()
//                }
            }
            .padding(.top)
        }
    }
}



#Preview {
    @State var mockReminders: [Reminder] = [
           Reminder(plantName: "Pothos", room: .bedroom, light: .fullSun, waterDays: .daily, waterAmount: .one)
       ]
       
       // Pass the state as a binding to the SetReminder preview
       return SetReminder(reminders: .constant(mockReminders)) 
}
