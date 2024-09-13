import Foundation

class Employee: Identifiable, ObservableObject {
    var uuid:UUID = UUID()
    var payPerVehicle: Double
    var hirePrice: Double
    var payOwed: Double
    var type:EmployeeType
    
    init(payPerVehicle: Double, hirePrice: Double, type:EmployeeType) {
        self.payPerVehicle = payPerVehicle
        self.hirePrice = hirePrice
        self.type = type
        self.payOwed = 0.00
    }
    
   static func getDefaultEmployeeHireCost(type:EmployeeType) -> Double {
        switch(type){
        case .general:
            return 1099.99
        case .manager:
            return 12999.99
        }
    }
    
    static func getNextEmployeeHireCost(employees: [Employee], type: EmployeeType) -> Double {
        let numEmployees = employees.count
        let costMultiplier = 3.25
        let defaultCost = getDefaultEmployeeHireCost(type: type)
        if numEmployees == 0 {
            return defaultCost
        } else {
            return defaultCost * (Double(numEmployees) * costMultiplier)
        }
    }
    
    //TODO next manager cost
    
    func trainEmployee(){
        //TODO
    }
    
    static func getEmployeeDesc(type: EmployeeType) -> String {
        switch(type){
        case .general:
            return "Details vehicles automatically"
        case .manager:
            return "Handles employee payroll" //workmans comp? insurance?
        }
    }
    
}

enum EmployeeType:String, CaseIterable, Identifiable {
    var id: String { return self.rawValue }
    case general = "General", manager = "Manager"//paint correct? //shop manager - handle rent/lease/property tax
}
