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
    
    func getDefaultEmployeeHireCost(type:EmployeeType) -> Double {
        switch(type){
        case .general:
            return 199.99
        case .manager:
            return 999.99
        }
    }
    
    func getNextEmployeeHireCost(employees: [Employee]) -> Double {
        return 1.00 //TODO by type
    }
    
    func trainEmployee(){
        //TODO
    }
    
}

enum EmployeeType:String, CaseIterable, Identifiable {
    var id: String { return self.rawValue }
    case general = "General", manager = "Manager"//paint correct
}
