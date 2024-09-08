import Foundation

class Buildings: ObservableObject {
    @Published var buildings:[Building] = [
        Building(name: "Home Garage", vehicleSlots: 1, workerSlots: 2, unlockLevel: -1, price: -1)
    ]
    
    func getStartBuilding() -> Building {
        return self.buildings[0]
    }
}
