import Foundation

class Employee: Identifiable, ObservableObject {
    var uuid:UUID = UUID()
    var payPerVehiclePercentage: Double
//    var hirePrice: Double
    var payOwed: Double
    var type:EmployeeType
//    var metaData: EmployeeMetaData
    
    init(payPerVehiclePercentage: Double, /*hirePrice: Double,*/ type:EmployeeType) {
        self.payPerVehiclePercentage = payPerVehiclePercentage
//        self.hirePrice = hirePrice
        self.type = type
        self.payOwed = 0.00
    }
    
   static func getDefaultEmployeeHireCost(type:EmployeeType) -> Double {
        switch(type){
        case .detailer:
            return 1099.99
        case .generalManager:
            return 12999.99
        case .inventoryManager:
            return 25999.99
        case .shopManager:
            return 25999.99
            
        }
    }
    
    static func getNextEmployeeHireCost(employees: [Employee], type: EmployeeType) -> Double {
        var numEmployeesOfType = 0
        for emp in employees {
            if emp.type == type {
                numEmployeesOfType += 1
            }
        }
        let costMultiplier = 3.25
        let defaultCost = getDefaultEmployeeHireCost(type: type)
        if numEmployeesOfType == 0 {
            return defaultCost
        } else {
            return defaultCost * (Double(numEmployeesOfType) * costMultiplier)
        }
    }
    
    //TODO next manager cost
    
    func trainEmployee(){
        //TODO
    }
    
    //TODO these stats need to go somewhere else so they can be modified more easily - gamestate?
    static func getEmployeePayPerVehiclePercentageByType(type: EmployeeType) -> Double{
        switch(type){
        case .detailer:
            return 7.00
        case .generalManager, .inventoryManager, .shopManager: //TODO change shop manager to accountant?
            return 12.00
        }
    }
    
    static func getEmployeeDesc(type: EmployeeType) -> String {
        switch(type){
        case .detailer:
            return "Detail vehicles automatically"
        case .generalManager:
            return "Handles employee payroll" //workmans comp? insurance?
        case .inventoryManager:
            return "Automatically restock inventory"
        case.shopManager: //TODO accountant
            return "Handle property expenses"
        }
    }
    
}

enum EmployeeType:String, CaseIterable, Identifiable {
    var id: String { return self.rawValue }
    case detailer = "Detailer",
        generalManager = "General Manager",
        inventoryManager = "Inventory Manager",
        shopManager = "Shop Manager"
}
