import Foundation

class InventoryItem:Identifiable{
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
    var itemMultiplier:Double?
    var clickMultiplier:Double?
    
    init(id: UUID = UUID(), price: Double, name: String, desc: String, levelUnlocked: Int, usesPerVehicle: Int, usesRemaining: Int, icon: String, purchased: Bool, startingItem: Bool, itemMultiplier: Double? = nil, clickMultiplier: Double? = nil) {
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
        self.itemMultiplier = itemMultiplier
        self.clickMultiplier = clickMultiplier
    }
    
    func purchaseFromStore(item:InventoryItem){
//        gameState.money -= self.price
        
    }
    
    func use(){
        if self.usesPerVehicle != -1 {
            self.usesRemaining -= self.usesPerVehicle
        }
    }
    
    func refill(){
        self.usesRemaining = self.usesPerContainer
    }

}
