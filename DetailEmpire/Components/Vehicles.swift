import Foundation

class Vehicles:ObservableObject{
    @Published var vehicles:[Vehicle] = [
        Vehicle(type: "Coupe", clicksToComplete:15, baseRevenue:200.00, xp: 15), //level unlock
        Vehicle(type: "Sedan", clicksToComplete:20, baseRevenue:250.00, xp: 20),
        Vehicle(type: "Truck", clicksToComplete:25, baseRevenue:325.00, xp: 25),
        Vehicle(type: "Van", clicksToComplete:30, baseRevenue:350.00, xp: 30),
        Vehicle(type: "SUV", clicksToComplete:32, baseRevenue:375.00, xp: 32)
        //bus
        //boat
        //rv
        //airplane
    ]
    
    func getVehicle() -> Vehicle {
        return vehicles.randomElement() ?? vehicles[0]
    }
    
}
