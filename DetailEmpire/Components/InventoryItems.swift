import Foundation

class InventoryItems:ObservableObject{
    @Published var inventoryItems:[InventoryItem] = [
        InventoryItem(price:0,
                      name:"Bucket", desc:"A bucket", levelUnlocked: 0, usesPerVehicle: -1, usesRemaining: -1, icon: "bubble.middle.bottom",
                      purchased: false, startingItem: true),
        InventoryItem(price:10,
                      name:"Basic Car Soap", desc:"It's soap", levelUnlocked: 0, usesPerVehicle: 1, usesRemaining: 1 /* 10 */, icon: "sparkles",
                      purchased: false, startingItem: true)
        //tire dressing
        //glass cleaner
        //brushes
        
    ]
    
    func itemEmpty() -> Bool{
        var empty = false
        for item in self.inventoryItems {
            if item.usesRemaining == 0 {
                empty = true
            }
        }
        return empty
    }
}
