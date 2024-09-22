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
                        if item.type == InventoryType.product {
                            inventoryItemListing(item: $item)
                        }
                    }
                }
                .contentMargins(.horizontal, 10, for: .scrollContent)
            case 1:
                ScrollView{
                    ForEach($inventoryItems.inventoryItems){ $item in
                        if item.type == InventoryType.equipment {
                            inventoryItemListing(item: $item)
                        }
                    }
                }
                .contentMargins(.horizontal, 10, for: .scrollContent)
            default:
                ScrollView{
                    ForEach($inventoryItems.inventoryItems){ $item in
                        if item.type == InventoryType.product {
                            inventoryItemListing(item: $item)
                        }
                    }
                }
                .contentMargins(.horizontal, 10, for: .scrollContent)
            }
        }
//        .background(LinearGradient(gradient: Gradient(colors: [.black.opacity(0.7),.black.opacity(0.8),.black.opacity(0.8),.black,.black.opacity(0.7),.black.opacity(0.6), .black.opacity(0.6),.black.opacity(0.7)]), startPoint: .topLeading, endPoint: .bottom))
        .background(LinearGradient(colors: [.black.opacity(0.7),.black.opacity(0.5), .cyan.opacity(0.4)],
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
