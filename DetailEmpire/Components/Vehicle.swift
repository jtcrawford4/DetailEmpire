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
    
    func detail(gameState: GameState, inventory: [InventoryItem]){
        detailWithClicks(clicks: 1.00, gameState: gameState, inventory: inventory)
    }
    
    public func workerDetail(numWorkers: Int, gameState: GameState, inventory: [InventoryItem]){
        if numWorkers > 0 {
            detailWithClicks(clicks: (Double(numWorkers) * 0.10), gameState: gameState, inventory: inventory)
        }
    }
    
    func isCompleted() -> Bool{
        return self.clicks >= Double(self.clicksToComplete)
    }
    
//    func getVehicleImageName() -> String {
//        switch(self.type){
//        case "Sedan":
//            return "icons8-car-50"
//        default:
//            return ""
//        }
//    }
    
    private func detailWithClicks(clicks: Double, gameState: GameState, inventory: [InventoryItem]){
        if(!gameState.detailDisabled){
            self.clicks += clicks
            self.percentComplete = Int(round((Double(self.clicks) / Double(self.clicksToComplete)) * 100))
            if self.isCompleted(){
                for item in inventory {
                    item.use()
                    if item.usesRemaining == 0 {
                        gameState.detailDisabled = true
                    }
                }
                gameState.money += self.baseRevenue
                gameState.xp += self.xp
                if gameState.xp >= gameState.xpToNextLevel {
                    gameState.level += 1
                    gameState.xpToNextLevel = Int(round(Double(gameState.xpToNextLevel) * 2.8))
                }
            }
        }
    }
    
}
