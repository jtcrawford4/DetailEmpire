import Foundation

class InventoryItems:ObservableObject{
    @Published var inventoryItems:[InventoryItem] = [
        InventoryItem(price:0, name:"Bucket", desc:"A bucket", levelUnlocked: 0, usesPerVehicle: -1, usesRemaining: -1, icon: "bubble.middle.bottom", purchased: false, startingItem: true)
//        InventoryItem(price:349.99, name:"Rupes Polisher", desc:"Spins real fast", levelUnlocked: 0, usesPerVehicle: -1, icon: "lasso.sparkles", purchased: false, startingItem: false)
    ]
}
