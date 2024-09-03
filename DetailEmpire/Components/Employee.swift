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
    
}
