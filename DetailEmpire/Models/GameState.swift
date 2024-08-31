import Foundation

class GameState: ObservableObject{
    @Published var level = 1
    @Published var xp = 0
    @Published var money = 0.00
    @Published var moneyPerSecond = 0.00
    @Published var employees = 0
    
    var timer:Timer?
    
    init(){
        self.level = 1
        self.xp = 0
        self.money = 0
        self.moneyPerSecond = 0.00
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: {_ in self.tick()})
        self.employees = 0
    }
    
    func tick(){
        self.money += moneyPerSecond
    }
}
