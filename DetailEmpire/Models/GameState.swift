import Foundation

class GameState: ObservableObject{
    @Published var level = 1
    @Published var xp = 0
    @Published var totalXp = 0
    @Published var money = 0.00
    @Published var xpToNextLevel = 500
    @Published var vehicleDetailMultipliers = 0.00
    @Published var clickMulitplier = 0.00
    @Published var currentBuilding: Building
    @Published var inventory: InventoryItems
    @Published var detailDisabled: Bool
    @Published var employees:[Employee]
    @Published var workerDetailSpeed = 0.30
//    @Published var workerCostMultiplier = 
    @Published var workerSpeedMultiplier = 0.00
    @Published var workerMoneyMultiplier = 0.00
    //options
    //metrics
//    @Published var vehcilesDetailed = 0
//    @Published var totalMoneyEarned = 0.00
    
    var timer:Timer?
    
    init(){
        self.level = 1
        self.xp = 0
        self.money = 0
        self.vehicleDetailMultipliers = 0.00
        self.employees = []
        self.currentBuilding = Buildings().getStartBuilding()
        self.inventory = InventoryItems()
        self.detailDisabled = false
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {_ in self.tick()})
    }
    
    func tick(){
        let vehicle = self.currentBuilding.vehicles[0]
        vehicle.isCompleted() ? self.currentBuilding.vehicles = [Vehicles().getVehicle()] : nil
        self.detailDisabled = vehicle.isCompleted() && !self.inventory.isAnyItemEmpty()
        if(!self.detailDisabled && !self.inventory.isAnyItemEmpty() && !self.currentBuilding.vehicles[0].isCompleted()) {
            vehicle.workerDetail(numWorkers: self.currentBuilding.employees.count, gameState: self, inventory: self.inventory.inventoryItems)
        }
    }
    
}
