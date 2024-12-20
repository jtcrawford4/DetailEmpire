import Foundation

class InventoryItems:ObservableObject{
    @Published var inventoryItems:[InventoryItem] = [
        InventoryItem(price:0,
                      name:"Bucket", desc:"A bucket", levelUnlocked: 0, usesPerVehicle: -1, usesRemaining: -1, icon: "bubble.middle.bottom",
                      purchased: false, startingItem: true, speedMultiplier: 0, moneyMultiplier: 0, type: InventoryType.equipment, replaceCategoryOnPurchase: false,
                      tier: InventoryItemTier.common),
        InventoryItem(price:39.99,
                      name:"Hand-held Shop Vac", desc:"Maximum effort. Minimal suction", levelUnlocked: 0, usesPerVehicle: 1, usesRemaining: 40, icon: "bubble.middle.bottom",
                      purchased: false, startingItem: true, speedMultiplier: 0, moneyMultiplier: 0, type: InventoryType.equipment, subType: InventorySubType.vacuum, replaceCategoryOnPurchase: false,
                      tier: InventoryItemTier.common),
        InventoryItem(price:15.98,
                      name:"Bargain Terry Towels", desc:"Warehouse store special. Could scratch rocks", levelUnlocked: 0, usesPerVehicle: 2, usesRemaining: 36, icon: "sparkles",
                      purchased: false, startingItem: true, speedMultiplier: 0, moneyMultiplier: 0, type: InventoryType.product, subType: InventorySubType.microfiber, replaceCategoryOnPurchase: false, tier: InventoryItemTier.common),
//        InventoryItem(price:39.99,
//                      name:"Test Broken", desc:"test", levelUnlocked: 0, usesPerVehicle: 1, usesRemaining: 0, icon: "bubble.middle.bottom",
//                      purchased: false, startingItem: true, speedMultiplier: 0, moneyMultiplier: 0, type: InventoryType.equipment),
//        InventoryItem(price:39.99,
//                      name:"Test Worn", desc:"test2", levelUnlocked: 0, usesPerVehicle: 1, usesRemaining: 2, icon: "bubble.middle.bottom",
//                      purchased: false, startingItem: true, speedMultiplier: 0, moneyMultiplier: 0, type: InventoryType.equipment),
//        InventoryItem(price:100.99,
//                      name:"Test Product", desc:"Test Low", levelUnlocked: 0, usesPerVehicle: 1, usesRemaining: 1, icon: "bubble.middle.bottom",
//                      purchased: false, startingItem: true, speedMultiplier: 0, moneyMultiplier: 0, type: InventoryType.product),
//        InventoryItem(price:12.99,
//                      name:"Test Product2", desc:"Test empty", levelUnlocked: 0, usesPerVehicle: 1, usesRemaining: 0, icon: "bubble.middle.bottom",
//                      purchased: false, startingItem: true, speedMultiplier: 0, moneyMultiplier: 0, type: InventoryType.product),
        InventoryItem(price:11.99,
                      name:"Basic Car Soap", desc:"It's soap", levelUnlocked: 0, usesPerVehicle: 1, usesRemaining: 10, icon: "sparkles",
                      purchased: false, startingItem: true, speedMultiplier: 0, moneyMultiplier: 0, type: InventoryType.product, replaceCategoryOnPurchase: false,
                      tier: InventoryItemTier.common),
        InventoryItem(price:19.99,
                      name:"Tire Dressing", desc:"Back to Black", levelUnlocked: 0, usesPerVehicle: 1, usesRemaining: 50, icon: "sparkles",
                      purchased: false, startingItem: true, speedMultiplier: 0, moneyMultiplier: 0, type: InventoryType.product, replaceCategoryOnPurchase: false,
                      tier: InventoryItemTier.common),
        InventoryItem(price:6.99,
                      name:"Glass Cleaner", desc:"Invisible glass", levelUnlocked: 0, usesPerVehicle: 1, usesRemaining: 15, icon: "sparkles",
                      purchased: false, startingItem: true, speedMultiplier: 0, moneyMultiplier: 0, type: InventoryType.product, replaceCategoryOnPurchase: false,
                      tier: InventoryItemTier.common),
        InventoryItem(price:12.99,
                      name:"Paste Wax", desc:"Wax on, wax off", levelUnlocked: 0, usesPerVehicle: 1, usesRemaining: 8, icon: "sparkles",
                      purchased: false, startingItem: true, speedMultiplier: 0, moneyMultiplier: 0, type: InventoryType.product, subType: InventorySubType.exteriorCoating, replaceCategoryOnPurchase: false,
                      tier: InventoryItemTier.common)
        //brushes
        //wax -> sealant -> ceramic -> ppf
        
    ]
    
    func isAnyItemEmpty() -> Bool{
        for item in self.inventoryItems {
            if item.usesRemaining == 0 {
                return true
            }
        }
        return false
    }
    
    func addItem(item:InventoryItem){
        inventoryItems.append(item)
    }
}
