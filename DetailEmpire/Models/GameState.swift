import Foundation

class GameState: ObservableObject{
//    var employee = Employee()
    @Published var level = 1
    @Published var xp = 0
    @Published var money = 0.00
//    @Published var moneyPerSecond = 0.00
//    @Published var employees = 0
    @Published var xpToNextLevel = 500
    @Published var vehicleDetailMultipliers = 0.00
    @Published var clickMulitplier = 0.00
    @Published var employees:[Employee]
//    @Published var employeeTypes: [for et in Employee().]
//    @Published var numEmployee = 0
    @Published var employeeSpeedMultiplier = 0.00
    @Published var employeeMoneyMultiplier = 0.00
    //vehicle
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
//        self.moneyPerSecond = 0.00
//        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {_ in self.tick()})
//        self.employees = 0
        self.vehicleDetailMultipliers = 0.00
        self.employees = []
//        self.numEmployee = 0
//        self.employeeTypes = [EmployeeType.allCases]
        self.currentVehicle = Vehicles().getVehicle()
        self.inventory = InventoryItems()
        self.detailDisabled = false
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {_ in self.tick()})
    }
    
    func tick(){
//        if self.employees.count > 0 && self.currentVehicle != nil{
//            self.currentVehicle!.workerDetail(numWorkers: employees.count)
//        }
        
//        if self.employees.count > 0 {
        self.currentVehicle.isCompleted() ? self.currentVehicle = Vehicles().getVehicle() : nil
        self.currentVehicle.workerDetail(numWorkers: employees.count, gameState: self, inventory: self.inventory.inventoryItems)
//        }
        
//        Vehicle().workerDetail(numWorkers: self.employees.count)
//        self.money += moneyPerSecond
//        if self.numEmployee > 0 {
//            vehicle
//        }
        
    }
    
//    func setCv(vehicle: Vehicle){
//        self.currentVehicle = vehicle
//    }
    
//    let myEnumArray = [MyEnum.a, MyEnum.b, MyEnum.c] /// create an instance property
//
//        enum MyEnum: String, CaseIterable {
//            case a, b, c
//        }
    
//    enum EmployeeType: CaseIterable {
//        case general, manager //paint correct
//    }
//    
//    func getDefaultEmployeeHireCost(type:EmployeeType) -> Double {
//        switch(type){
//        case .general:
//            return 1.99
//        case .manager:
//            return 1000
//        }
//    }
    
}
