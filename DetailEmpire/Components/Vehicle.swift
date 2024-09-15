import Foundation

class Vehicle:ObservableObject{
    var id:UUID
    @Published var type:String
    @Published var clicks:Double = 0
    @Published var clicksToComplete:Int
    @Published var percentComplete:Int = 0
    @Published var baseRevenue:Double
    @Published var xp:Int
    
    init(type:String, clicksToComplete:Int, baseRevenue:Double, xp:Int) {
        self.id = UUID()
        self.type = type
        self.clicks = 0
        self.clicksToComplete = clicksToComplete
        self.percentComplete = 0
        self.baseRevenue = baseRevenue
        self.xp = xp
    }
    
    func detail(gameState: GameState, inventory: [InventoryItem]){
        detailWithClicks(clicks: 1.00, gameState: gameState, inventory: inventory)
    }
    
    public func workerDetail(numWorkers: Int, gameState: GameState, inventory: [InventoryItem]){
        if numWorkers > 0 && !gameState.detailDisabled && !gameState.workersOnStrike {
            var clicks = Double(numWorkers) * gameState.workerDetailSpeed * (gameState.workerSpeedMultiplier > 0 ? gameState.workerSpeedMultiplier : 1)
            if gameState.payrollDue {
                clicks *= gameState.payrollEfficiencyPenalty
                gameState.workersOnStrike = gameState.vehiclesSincePayroll >= gameState.payrollStrikeThreshold
            }
            detailWithClicks(clicks: clicks, gameState: gameState, inventory: inventory)
        }
    }
    
    func isCompleted() -> Bool{
        return self.clicks >= Double(self.clicksToComplete)
    }
    
//    func getVehicleImageName() -> String {
//        switch(self.type){
//        case "Sedan":
//            return "icons8-car-50"
//        default:
//            return ""
//        }
//    }
    
    private func detailWithClicks(clicks: Double, gameState: GameState, inventory: [InventoryItem]){
        if(!gameState.detailDisabled){
            let inventorySpeedMultiplier = gameState.inventoryItemSpeedMultiplier > 0 ? gameState.inventoryItemSpeedMultiplier : 1
            self.clicks += clicks * inventorySpeedMultiplier
            self.percentComplete = Int(round((Double(self.clicks) / Double(self.clicksToComplete)) * 100))
            if self.isCompleted(){
                let workerMoneyMultiplier = gameState.workerMoneyMultiplier > 0 ? gameState.workerMoneyMultiplier : 1
                let inventoryItemMoneyMultiplier = gameState.inventoryItemMoneyMultiplier > 0 ? gameState.inventoryItemMoneyMultiplier : 1
                let totalRevenue = self.baseRevenue * workerMoneyMultiplier * inventoryItemMoneyMultiplier
                let employees = gameState.currentBuilding.employees
                for item in inventory {
                    item.use()
                    if item.type == InventoryType.equipment {
                        item.setEquipementCondition()
                    }
                }
                gameState.money += totalRevenue
                if employees.count > 0 {
                    gameState.vehiclesSincePayroll += 1
                    if !gameState.workersOnStrike {
                        gameState.payrollDue = gameState.vehiclesPerPayroll <= gameState.vehiclesSincePayroll
                        for employee in employees {
                            employee.payOwed += (totalRevenue * employee.payPerVehiclePercentage) / 100
                        }
                    }
                }
                gameState.xp += self.xp //TODO xp multiplier
                if gameState.xp >= gameState.xpToNextLevel {
                    gameState.level += 1
                    gameState.xpToNextLevel = Int(round(Double(gameState.xpToNextLevel) * 2.8))
                    gameState.totalXp += gameState.xp
                    gameState.xp = 0
                }
            }
        }
    }
    
}
