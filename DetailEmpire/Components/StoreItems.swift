import Foundation

class StoreItems:ObservableObject{
    @Published var storeItems:[InventoryItem] = [
        InventoryItem(price:149.99,
                      name:"Test Purchased",
                      desc:"Test purchased desc",
                      levelUnlocked: 1, usesPerVehicle: 1, usesRemaining: 100, icon: "lasso.sparkles", purchased: true, startingItem: false, 
                      itemMultiplier: 0, type: InventoryType.product),
        InventoryItem(price:149.99,
                      name:"Basic Polisher",
                      desc:"Increase efficiency by 2%",
                      levelUnlocked: 1, usesPerVehicle: 1, usesRemaining: 100, icon: "lasso.sparkles", purchased: false, startingItem: false, 
                      itemMultiplier: 0.10, type: InventoryType.equipment),
        InventoryItem(price:349.99,
                      name:"Rupes Polisher",
                      desc:"Spins real fast",
                      levelUnlocked: 15, usesPerVehicle: 1, usesRemaining: 450, icon: "lasso.sparkles", purchased: false, startingItem: false, 
                      itemMultiplier: 0.30, type: InventoryType.equipment)
    ]
}

