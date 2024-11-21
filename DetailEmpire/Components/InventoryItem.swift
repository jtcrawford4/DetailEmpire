import Foundation
import SwiftUI

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
    var subType: InventorySubType?
    var replaceCategoryOnPurchase:Bool
    @Published var equipmentCondition:Int = 100
    var tier: InventoryItemTier
    //color background for category?
    //special ability. different class? link by id?
    
    init(id: UUID = UUID(), price: Double, name: String, desc: String, levelUnlocked: Int, usesPerVehicle: Int, usesRemaining: Int, icon: String, purchased: Bool, startingItem: Bool, speedMultiplier: Double, moneyMultiplier: Double, type: InventoryType, subType: InventorySubType? = nil, replaceCategoryOnPurchase: Bool, tier: InventoryItemTier) {
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
        self.subType = subType
        self.replaceCategoryOnPurchase = replaceCategoryOnPurchase
        self.tier = tier
    }
    
    func purchaseFromStore(item:InventoryItem, inventory: InventoryItems, gameState: GameState){
        if item.replaceCategoryOnPurchase && item.subType != nil {
            let matchedItems = inventory.inventoryItems.filter{$0.subType == item.subType}
            for item in matchedItems {
                if item.moneyMultiplier > 0 && gameState.inventoryItemMoneyMultiplier > 0 {
                    gameState.inventoryItemMoneyMultiplier -= item.moneyMultiplier
                }
                if item.speedMultiplier > 0 && gameState.inventoryItemSpeedMultiplier > 0{
                    gameState.inventoryItemSpeedMultiplier -= item.speedMultiplier
                }
            }
            inventory.inventoryItems = inventory.inventoryItems.filter{$0.subType != item.subType}
        }
        gameState.money -= item.price
        item.purchased = true
        gameState.inventoryItemMoneyMultiplier += item.moneyMultiplier
        gameState.inventoryItemSpeedMultiplier += item.speedMultiplier
        inventory.addItem(item: item)
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
    
    func getItemTierColor(tier: InventoryItemTier) -> Color {
        switch tier {
            case .common:
                return .black
            case .uncommon:
                return .green
            case .rare:
                return .orange
            case .epic:
                return .purple
        }
    }
    
}

enum InventoryType: Identifiable{
    var id : UUID {return UUID()}
    case product, equipment, employee, unassigned
}

enum InventorySubType: Identifiable{
    var id : UUID {return UUID()}
    case microfiber, exteriorCoating, vacuum
}

enum InventoryItemTier: Identifiable{
    var id : UUID {return UUID()}
    case common, uncommon, rare, epic
}
