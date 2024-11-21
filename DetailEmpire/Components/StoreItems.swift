import Foundation

class StoreItems:ObservableObject{
    
    @Published var storeItems:[InventoryItem] = items.sorted {$0.levelUnlocked < $1.levelUnlocked}
    
}

    let items = [
        //Product
        InventoryItem(price:36.99,
                      name:"Bulk Microfiber Towels",
                      desc:"Economy towels (+2% detailing speed)",
                      levelUnlocked: 2, usesPerVehicle: 1, usesRemaining: 24, icon: "lasso.sparkles", purchased: false, startingItem: false,
                      speedMultiplier: 0.02, moneyMultiplier: 0, type: InventoryType.product, subType: InventorySubType.microfiber, replaceCategoryOnPurchase: true, tier: InventoryItemTier.common), //replace bargain towels
        InventoryItem(price:61.99,
                      name:"Edgeless Microfiber Towels",
                      desc:"Mid grade towels. Better results (+4% detailing speed, +2% earnings)",
                      levelUnlocked: 5, usesPerVehicle: 1, usesRemaining: 48, icon: "lasso.sparkles", purchased: false, startingItem: false,
                      speedMultiplier: 0.04, moneyMultiplier: 0.02, type: InventoryType.product, subType: InventorySubType.microfiber, replaceCategoryOnPurchase: true, tier: InventoryItemTier.uncommon),
        InventoryItem(price:100.99,
                      name:"Korean Microfiber Towels",
                      desc:"Premium plush towels. Best results (+5% detailing speed, +6% earnings)",
                      levelUnlocked: 8, usesPerVehicle: 1, usesRemaining: 24, icon: "lasso.sparkles", purchased: false, startingItem: false,
                      speedMultiplier: 0.05, moneyMultiplier: 0.06, type: InventoryType.product, subType: InventorySubType.microfiber, replaceCategoryOnPurchase: true, tier: InventoryItemTier.rare),
            //TODO coating towels
        InventoryItem(price:49.99,
                      name:"Super Wax",
                      desc:"Shinier cars bring more money (+3%)",
                      levelUnlocked: 3, usesPerVehicle: 1, usesRemaining: 12 /*8*/, icon: "lasso.sparkles", purchased: false, startingItem: false,
                      speedMultiplier: 0, moneyMultiplier: 0.03, type: InventoryType.product, subType: InventorySubType.exteriorCoating, replaceCategoryOnPurchase: true, tier: InventoryItemTier.uncommon), //replace regular wax
        
        
        //Equipment
        InventoryItem(price:149.99,
                      name:"Basic Polisher",
                      desc:"Increase efficiency by 2%",
                      levelUnlocked: 1, usesPerVehicle: 1, usesRemaining: 100, icon: "lasso.sparkles", purchased: false, startingItem: false, 
                      speedMultiplier: 0.02, moneyMultiplier: 0, type: InventoryType.equipment, replaceCategoryOnPurchase: false, tier: InventoryItemTier.common),
        InventoryItem(price:129.99,
                      name:"Basic Shop Vac",
                      desc:"Increase efficiency by 2%",
                      levelUnlocked: 3, usesPerVehicle: 1, usesRemaining: 150, icon: "lasso.sparkles", purchased: false, startingItem: false,
                      speedMultiplier: 0.02, moneyMultiplier: 0, type: InventoryType.equipment, subType: InventorySubType.vacuum, replaceCategoryOnPurchase: true, tier: InventoryItemTier.common), //TODO replace hand held vac when purchased. verify previous multiplier removed if applicable
        InventoryItem(price:449.99,
                      name:"Rupes Polisher",
                      desc:"Spins real fast",
                      levelUnlocked: 15, usesPerVehicle: 1, usesRemaining: 450, icon: "lasso.sparkles", purchased: false, startingItem: false, 
                      speedMultiplier: 0.15, moneyMultiplier: 0, type: InventoryType.equipment, replaceCategoryOnPurchase: false, tier: InventoryItemTier.common), //TODO replace basic polisher when purchased
        
        
        //Employee Training
        InventoryItem(price:999.99,
                      name:"Test Training",
                      desc:"Train detail workers",
                      levelUnlocked: 15, usesPerVehicle: -1, usesRemaining: -1, icon: "person.fill", purchased: false, startingItem: false,
                      speedMultiplier: 0.15, moneyMultiplier: 0, type: InventoryType.employee, replaceCategoryOnPurchase: false, tier: InventoryItemTier.common)
    ]
