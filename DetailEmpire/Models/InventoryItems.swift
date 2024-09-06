import Foundation

class InventoryItems{
     var items:[InventoryItem] = [
        InventoryItem(price:0,
                      name:"Bucket", desc:"A bucket", levelUnlocked: 0, usesPerVehicle: -1, usesRemaining: -1, usesPerContainer: -1, 
                      icon: "bubble.middle.bottom",
                      purchased: false, startingItem: true, isEquipment: false),
        InventoryItem(price:11.99,
                      name:"Basic Car Soap", desc:"It's soap", levelUnlocked: 0, usesPerVehicle: 1, usesRemaining: 10, usesPerContainer: 10,
                      icon: "sparkles",
                      purchased: false, startingItem: true, isEquipment: false),
        InventoryItem(price:19.99,
                      name:"Tire Dressing", desc:"Back to Black", levelUnlocked: 0, usesPerVehicle: 1, usesRemaining: 50, usesPerContainer: 50,
                      icon: "sparkles",
                      purchased: false, startingItem: true, isEquipment: false),
        InventoryItem(price:6.99,
                      name:"Glass Cleaner", desc:"Invisible glass", levelUnlocked: 0, usesPerVehicle: 1, usesRemaining: 15, usesPerContainer: 15, 
                      icon: "sparkles",
                      purchased: false, startingItem: true, isEquipment: false)
        //brushes
        
    ]
    
    func isAnyItemEmpty(items: [InventoryItem]) -> Bool{
        for item in items {
            if item.usesRemaining == 0 {
                return true
            }
        }
        return false
    }
    
    //TODO refactor so this is not needed
    func addItem(item:InventoryItem){
        items.append(item)
    }
}
