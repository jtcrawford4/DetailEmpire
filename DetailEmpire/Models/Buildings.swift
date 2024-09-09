import Foundation

class Buildings: ObservableObject {
    @Published var buildings:[Building] = [
        Building(name: "Home Garage", vehicleSlots: 1, workerSlots: 2, unlockLevel: -1, price: -1, employees: [], purchased: true, icon: "house.fill"),
        Building(name: "Test Building", vehicleSlots: 0, workerSlots: 0, unlockLevel: 1, price: 10000, employees: [], purchased: false, icon: "house.fill"),
        Building(name: "Abandoned Service Shop", vehicleSlots: 2, workerSlots: 6, unlockLevel: 5, price: 10000, employees: [], purchased: false, icon: "circle.grid.cross")
    ]
    
    func getStartBuilding() -> Building {
        return self.buildings[0]
    }
}
