//
//  Vehicle2.swift
import Foundation

class Vehicle:ObservableObject{
    var id:UUID
    @Published var type:String
    @Published var clicks:Int = 0
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
    
    func detail(){
        self.clicks += 1 //TODO use gamestate multipliers etc
        self.percentComplete = Int(round((Double(self.clicks) / Double(self.clicksToComplete)) * 100))
    }
        
    func isCompleted() -> Bool{
        return self.clicks == self.clicksToComplete
    }
    
//    func calcPercentComplete() -> Int {
//        return Int(round((Double(self.clicks) / Double(self.clicksToComplete)) * 100))
//    }
    
}
