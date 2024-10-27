import Foundation

class StoreItems:ObservableObject{
    
    @Published var storeItems:[InventoryItem] = items.sorted {$0.levelUnlocked < $1.levelUnlocked}
    
}

    let items = [
        //Product
        InventoryItem(price:149.99,
                      name:"Test Purchased",
                      desc:"Test purchased desc",
                      levelUnlocked: 1, usesPerVehicle: 1, usesRemaining: 100, icon: "lasso.sparkles", purchased: true, startingItem: false, 
                      speedMultiplier: 0.02, moneyMultiplier: 0, type: InventoryType.product, tier: InventoryItemTier.rare),
        InventoryItem(price:49.99,
                      name:"Super Wax",
                      desc:"Shinier cars bring more money (+3%)",
                      levelUnlocked: 3, usesPerVehicle: 1, usesRemaining: 12 /*8*/, icon: "lasso.sparkles", purchased: false, startingItem: false,
                      speedMultiplier: 0, moneyMultiplier: 0.03, type: InventoryType.product, tier: InventoryItemTier.uncommon), //replace regular wax
        
        
        //Equipment
        InventoryItem(price:149.99,
                      name:"Basic Polisher",
                      desc:"Increase efficiency by 2%",
                      levelUnlocked: 1, usesPerVehicle: 1, usesRemaining: 100, icon: "lasso.sparkles", purchased: false, startingItem: false, 
                      speedMultiplier: 0.02, moneyMultiplier: 0, type: InventoryType.equipment, tier: InventoryItemTier.common),
        InventoryItem(price:129.99,
                      name:"Basic Shop Vac",
                      desc:"Increase efficiency by 2%",
                      levelUnlocked: 3, usesPerVehicle: 1, usesRemaining: 150, icon: "lasso.sparkles", purchased: false, startingItem: false,
                      speedMultiplier: 0.02, moneyMultiplier: 0, type: InventoryType.equipment, tier: InventoryItemTier.common), //TODO replace hand held vac when purchased. verify previous multiplier removed if applicable
        InventoryItem(price:129.99,
                      name:"Basic Shop Vac (TEST)",
                      desc:"Increase efficiency by 2%",
                      levelUnlocked: 1, usesPerVehicle: 1, usesRemaining: 150, icon: "lasso.sparkles", purchased: false, startingItem: false,
                      speedMultiplier: 0.02, moneyMultiplier: 0, type: InventoryType.equipment, tier: InventoryItemTier.epic),
        InventoryItem(price:449.99,
                      name:"Rupes Polisher",
                      desc:"Spins real fast",
                      levelUnlocked: 15, usesPerVehicle: 1, usesRemaining: 450, icon: "lasso.sparkles", purchased: false, startingItem: false, 
                      speedMultiplier: 0.15, moneyMultiplier: 0, type: InventoryType.equipment, tier: InventoryItemTier.common), //TODO replace basic polisher when purchased
        
        
        //Employee Training
        InventoryItem(price:999.99,
                      name:"Test Training",
                      desc:"Train detail workers",
                      levelUnlocked: 15, usesPerVehicle: -1, usesRemaining: -1, icon: "person.fill", purchased: false, startingItem: false,
                      speedMultiplier: 0.15, moneyMultiplier: 0, type: InventoryType.employee, tier: InventoryItemTier.common),
        InventoryItem(price:11999.99,
                      name:"Test Training2",
                      desc:"Train detail workers2",
                      levelUnlocked: 1, usesPerVehicle: -1, usesRemaining: -1, icon: "person.fill", purchased: false, startingItem: false,
                      speedMultiplier: 0.15, moneyMultiplier: 0, type: InventoryType.employee, tier: InventoryItemTier.common)
    ]
