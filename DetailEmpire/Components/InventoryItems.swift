import Foundation

class InventoryItems:ObservableObject{
    @Published var inventoryItems:[InventoryItem] = [
        InventoryItem(price:0,
                      name:"Bucket", desc:"A bucket", levelUnlocked: 0, usesPerVehicle: -1, usesRemaining: -1, icon: "bubble.middle.bottom",
                      purchased: false, startingItem: true, type: InventoryItem.InventoryType.equipment),
        InventoryItem(price:0,
                      name:"Test Product", desc:"Test Low", levelUnlocked: 0, usesPerVehicle: 1, usesRemaining: 1, icon: "bubble.middle.bottom",
                      purchased: false, startingItem: true, type: InventoryItem.InventoryType.product),
        InventoryItem(price:0,
                      name:"Test Product2", desc:"Test empty", levelUnlocked: 0, usesPerVehicle: 1, usesRemaining: 0, icon: "bubble.middle.bottom",
                      purchased: false, startingItem: true, type: InventoryItem.InventoryType.product),
        InventoryItem(price:11.99,
                      name:"Basic Car Soap", desc:"It's soap", levelUnlocked: 0, usesPerVehicle: 1, usesRemaining: 10, icon: "sparkles",
                      purchased: false, startingItem: true, type: InventoryItem.InventoryType.product),
        InventoryItem(price:19.99,
                      name:"Tire Dressing", desc:"Back to Black", levelUnlocked: 0, usesPerVehicle: 1, usesRemaining: 50, icon: "sparkles",
                      purchased: false, startingItem: true, type: InventoryItem.InventoryType.product),
        InventoryItem(price:6.99,
                      name:"Glass Cleaner", desc:"Invisible glass", levelUnlocked: 0, usesPerVehicle: 1, usesRemaining: 15, icon: "sparkles",
                      purchased: false, startingItem: true, type: InventoryItem.InventoryType.product)
        //brushes
        
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
