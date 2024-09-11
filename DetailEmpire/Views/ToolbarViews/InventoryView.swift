import SwiftUI

struct InventoryView: View {
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var inventoryItems: InventoryItems
    @State private var showingItemInfo = false
    @State private var selectedTab = 0
    
    var body: some View {
        
        //TODO refill all button
        VStack{
            Text("Inventory - add current metrics here")
            HStack(spacing: 0){
                ToggleButton(selectedButton: $selectedTab, tag: 0, text: "Products")
                ToggleButton(selectedButton: $selectedTab, tag: 1, text: "Equipment")
            }
            .padding(.bottom, 40)
            
            switch(selectedTab){
            case 0:
                ScrollView{
                    ForEach($inventoryItems.inventoryItems){ $item in
                        if item.type == InventoryItem.InventoryType.product {
                            inventoryItemListing(item: $item)
                        }
                    }
                }
                .contentMargins(.horizontal, 10, for: .scrollContent)
            case 1:
                ScrollView{
                    ForEach($inventoryItems.inventoryItems){ $item in
                        if item.type == InventoryItem.InventoryType.equipment {
                            inventoryItemListing(item: $item)
                        }
                    }
                }
                .contentMargins(.horizontal, 10, for: .scrollContent)
            default:
                ScrollView{
                    ForEach($inventoryItems.inventoryItems){ $item in
                        if item.type == InventoryItem.InventoryType.product {
                            inventoryItemListing(item: $item)
                        }
                    }
                }
                .contentMargins(.horizontal, 10, for: .scrollContent)
            }
        }
        .background(LinearGradient(colors: [.orange, .cyan],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing))
    }
       
}

#Preview {
    @StateObject var gameState = GameState()
    @StateObject var storeItems = StoreItems()
    return InventoryView()
        .environmentObject(gameState)
        .environmentObject(StoreItems())
        .environmentObject(gameState.currentBuilding.vehicles[0])
        .environmentObject(gameState.inventory)
}
