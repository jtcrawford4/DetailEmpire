import Foundation
    
enum EmployeeType:String, CaseIterable, Identifiable {
//    var id: Self {
//        return self
//    }
    var id : String { UUID().uuidString }
    case general = "General", manager = "Manager"//paint correct
}

func getDefaultEmployeeHireCost(type:EmployeeType) -> Double {
    switch(type){
    case .general:
        return 1.99
    case .manager:
        return 1000
    }
}
