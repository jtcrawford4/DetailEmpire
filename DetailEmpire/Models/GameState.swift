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
    @Published var inventoryItemSpeedMultiplier = 0.00
    @Published var inventoryItemMoneyMultiplier = 0.00
    @Published var detailDisabled = false
    //Employee
        @Published var employees:[Employee]
        @Published var numDetailEmployees = 0
        @Published var generalManagerHired = false
        @Published var inventoryMangerHired = false
        @Published var shopManagerHired = false
    //Payroll
        @Published var payrollDue = false
        @Published var workersOnStrike = false
        @Published var vehiclesPerPayroll = 7
        @Published var payrollStrikeThreshold = 21
        @Published var payrollEmployeeQuitThreshold = 42
        @Published var vehiclesSincePayroll = 0
        @Published var payrollEfficiencyPenalty = 0.50 //when payroll missed, detailers are only half efficient
    @Published var workerDetailSpeed = 0.45
//    @Published var workerCostMultiplier = 
    @Published var workerSpeedMultiplier = 0.00
    @Published var workerMoneyMultiplier = 0.00
    //options
    //metrics
//    @Published var vehcilesDetailed = 0
//    @Published var totalMoneyEarned = 0.00
    
    var timer:Timer?
    
    init(){
        self.vehicleDetailMultipliers = 0.00
        self.employees = []
        self.currentBuilding = Buildings().getStartBuilding()
        self.inventory = InventoryItems()
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
    
    func getInventorySpeedMultiplierPercentage() -> Int {
        if self.inventoryItemSpeedMultiplier > 0 {
            return Int(((self.inventoryItemSpeedMultiplier - 1) * 100).rounded())
        }
        return 0
    }
    
    func getWorkerSpeedMultiplierPercentage() -> Int {
        if self.workerSpeedMultiplier > 0 {
            return Int(((self.workerSpeedMultiplier - 1) * 100).rounded())
        }
        return 0
    }
    
    func getPayrollOwed() -> Double {
        if self.currentBuilding.employees.count > 0 {
            var total = 0.00
            for emp in self.currentBuilding.employees {
                total += emp.payOwed
            }
            return total
        }
        return 0
    }
    
    //TODO should be in employees class?
    func resetPayrollOwed(){
        if self.currentBuilding.employees.count > 0 {
            for emp in self.currentBuilding.employees {
                emp.payOwed = 0.00
            }
            self.workersOnStrike = false
        }
    }
    
    //TODO should be in employees class?
    func getPayrollOwedByEmployeeType(type: EmployeeType) -> Double {
        if self.currentBuilding.employees.count > 0 {
            var total = 0.00
            for emp in self.currentBuilding.employees {
                if emp.type == type {
                    total += emp.payOwed
                }
            }
            return total
        }
        return 0
    }
    
    func resetWorkers(){
        self.currentBuilding.employees = []
        self.workersOnStrike = false
        self.payrollDue = false
        self.vehiclesSincePayroll = 0
        self.numDetailEmployees = 0
    }
    
}
