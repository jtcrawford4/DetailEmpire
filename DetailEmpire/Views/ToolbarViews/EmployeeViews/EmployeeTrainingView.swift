import SwiftUI

struct EmployeeTrainingView: View {
    
    @EnvironmentObject var storeItems: StoreItems
    
    var body: some View {
        ScrollView{
            ForEach($storeItems.storeItems){ $item in
                if item.type == InventoryType.employee {
                    storeInventoryItemListing(item: $item)
                }
            }
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    @StateObject var gameState = GameState()
    @StateObject var storeItems = StoreItems()
    return EmployeeTrainingView()
        .environmentObject(gameState)
        .environmentObject(storeItems)
}
