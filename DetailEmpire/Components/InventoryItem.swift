import Foundation

class InventoryItem:Identifiable, ObservableObject{
    var id = UUID()
    var price:Double
    var name:String
    var desc:String
    var levelUnlocked:Int
    var usesPerVehicle:Int
    var usesRemaining:Int
    var usesPerContainer:Int
    var icon:String
    @Published var purchased:Bool
    var startingItem:Bool
    var speedMultiplier:Double
    var moneyMultiplier:Double
    var type: InventoryType
    @Published var equipmentCondition:Int = 100
    //color background for category?
    //special ability. different class? link by id?
    
    init(id: UUID = UUID(), price: Double, name: String, desc: String, levelUnlocked: Int, usesPerVehicle: Int, usesRemaining: Int, icon: String, purchased: Bool, startingItem: Bool, speedMultiplier: Double, moneyMultiplier: Double, type: InventoryType) {
        self.id = id
        self.price = price
        self.name = name
        self.desc = desc
        self.levelUnlocked = levelUnlocked
        self.usesPerVehicle = usesPerVehicle
        self.usesRemaining = usesRemaining
        self.usesPerContainer = self.usesRemaining
        self.icon = icon
        self.purchased = purchased
        self.startingItem = startingItem
        self.speedMultiplier = speedMultiplier
        self.moneyMultiplier = moneyMultiplier
        self.type = type
    }
    
    func purchaseFromStore(item:InventoryItem){
//        gameState.money -= self.price
        
    }
    
    func use(){
        if self.usesPerVehicle != -1 && self.usesRemaining != 0 {
            self.usesRemaining -= self.usesPerVehicle
        }
    }
    
    func refill(){
        self.usesRemaining = self.usesPerContainer
    }
    
    func setEquipementCondition(){
        if self.type == InventoryType.equipment && self.usesPerVehicle != -1 {
            let percent = Int(((Double(self.usesRemaining) / Double(self.usesPerContainer)) * 100).rounded())
            self.equipmentCondition = percent > 0 ? percent : 0
        }
    }
    
}

enum InventoryType: Identifiable{
    var id : UUID {return UUID()}
    case product, equipment, employee, unassigned
}
