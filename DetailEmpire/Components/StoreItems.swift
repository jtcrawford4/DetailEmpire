import Foundation

class StoreItems:ObservableObject{
    @Published var storeItems:[InventoryItem] = [
        InventoryItem(price:149.99,
                      name:"Test Purchased",
                      desc:"Test purchased desc",
                      levelUnlocked: 1, usesPerVehicle: 1, usesRemaining: 100, icon: "lasso.sparkles", purchased: true, startingItem: false, 
                      speedMultiplier: 0.02, moneyMultiplier: 0, type: InventoryType.product),
        InventoryItem(price:149.99,
                      name:"Basic Polisher",
                      desc:"Increase efficiency by 2%",
                      levelUnlocked: 1, usesPerVehicle: 1, usesRemaining: 100, icon: "lasso.sparkles", purchased: false, startingItem: false, 
                      speedMultiplier: 0.02, moneyMultiplier: 0, type: InventoryType.equipment),
        InventoryItem(price:129.99,
                      name:"Basic Shop Vac",
                      desc:"Increase efficiency by 2%",
                      levelUnlocked: 3, usesPerVehicle: 1, usesRemaining: 150, icon: "lasso.sparkles", purchased: false, startingItem: false,
                      speedMultiplier: 0.02, moneyMultiplier: 0, type: InventoryType.equipment), //TODO replace hand held vac when purchased. verify previous multiplier removed if applicable
        InventoryItem(price:449.99,
                      name:"Rupes Polisher",
                      desc:"Spins real fast",
                      levelUnlocked: 15, usesPerVehicle: 1, usesRemaining: 450, icon: "lasso.sparkles", purchased: false, startingItem: false, 
                      speedMultiplier: 0.15, moneyMultiplier: 0, type: InventoryType.equipment), //TODO replace basic polisher when purchased
        InventoryItem(price:999.99,
                      name:"Test Training",
                      desc:"Train detail workers",
                      levelUnlocked: 15, usesPerVehicle: -1, usesRemaining: -1, icon: "person.fill", purchased: false, startingItem: false,
                      speedMultiplier: 0.15, moneyMultiplier: 0, type: InventoryType.employee),
        InventoryItem(price:11999.99,
                      name:"Test Training2",
                      desc:"Train detail workers2",
                      levelUnlocked: 1, usesPerVehicle: -1, usesRemaining: -1, icon: "person.fill", purchased: false, startingItem: false,
                      speedMultiplier: 0.15, moneyMultiplier: 0, type: InventoryType.employee)
    ]
}

