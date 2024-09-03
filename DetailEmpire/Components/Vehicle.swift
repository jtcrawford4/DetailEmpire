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
    
    func detail(){
        self.clicks += 1 //TODO use gamestate multipliers etc
//        self.clicks += 1 + (1 * (Double(numWorkers) * 0.10)) //TODO separate player click vs worker click
        self.percentComplete = Int(round((Double(self.clicks) / Double(self.clicksToComplete)) * 100))
    }
    
    func workerDetail(numWorkers: Int){
        self.clicks += (Double(numWorkers) * 0.10)
    }
        
    func isCompleted() -> Bool{
        return self.clicks >= Double(self.clicksToComplete)
    }
    
}
