import SwiftUI

struct StoreProductView: View {
    
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var inventory: InventoryItems
    @EnvironmentObject var storeItems: StoreItems
    
    var body: some View {
        
        ScrollView{
            ForEach($storeItems.storeItems){ $item in
                if item.type == InventoryType.product {
                    storeInventoryItemListing(item: $item)
                }
            }
        }
        .contentMargins(.horizontal, 10, for: .scrollContent)
//            .contentMargins(.vertical, 10, for: .scrollContent)
    }
}

#Preview {
    @StateObject var gameState = GameState()
    @StateObject var storeItems = StoreItems()
    return StoreProductView()
        .environmentObject(gameState)
        .environmentObject(storeItems)
        .environmentObject(gameState.inventory)
}
