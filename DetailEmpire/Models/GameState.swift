import Foundation

class GameState: ObservableObject{
    @Published var level = 1
    @Published var xp = 0
    @Published var money = 0.00
    @Published var xpToNextLevel = 500
    @Published var vehicleDetailMultipliers = 0.00
    @Published var clickMulitplier = 0.00
    @Published var employees:[Employee]
    @Published var employeeSpeedMultiplier = 0.00
    @Published var employeeMoneyMultiplier = 0.00
    @Published var currentVehicle: Vehicle
    @Published var inventory: InventoryItems
    @Published var detailDisabled: Bool
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
        self.currentVehicle = Vehicles().getVehicle()
        self.inventory = InventoryItems()
        self.detailDisabled = false
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {_ in self.tick()})
    }
    
    func tick(){
        self.currentVehicle.isCompleted() ? self.currentVehicle = Vehicles().getVehicle() : nil
        self.currentVehicle.workerDetail(numWorkers: employees.count, gameState: self, inventory: self.inventory.inventoryItems)
    }
    
}
