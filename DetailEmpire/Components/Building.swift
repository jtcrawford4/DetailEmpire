import Foundation

class Building: Identifiable, ObservableObject{
    @Published var id: UUID
    @Published var name: String
    @Published var vehicleSlots: Int
    @Published var workerSlots: Int
    @Published var vehicles: [Vehicle]
    @Published var unlockLevel: Int
    @Published var price: Double
    @Published var employees: [Employee]
//    @Published var managerSlots: Int
    //building level, bonus xp/money
    
    init(name: String, vehicleSlots: Int, workerSlots: Int, unlockLevel: Int, price: Double, employees: [Employee]) {
        self.id = UUID()
        self.name = name
        self.vehicleSlots = vehicleSlots
        self.workerSlots = workerSlots
        self.vehicles = [Vehicles().getVehicle()] //TODO for multiples
        self.unlockLevel = unlockLevel
        self.price = price
        self.employees = employees
    }
    
}
