import SwiftUI

struct StoreView: View {
    
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var inventory: InventoryItems
    @EnvironmentObject var storeItems: StoreItems
    @State private var selectedTab = 0
        
    var body: some View {
        
        VStack{
//            Text("Store - add current metrics here")
            HStack(spacing: 0){
//                ControlGroup{
//                    Button(action: {}, label: {Text("test1")})
//                    Button(action: {}, label: {Text("test2")})
//                    Button(action: {}, label: {Text("test3")})
//                }
//                .cornerRadius(8)
//                .background(.white)
                
                ToggleButton(selectedButton: $selectedTab, tag: 0, text: "Products")
                ToggleButton(selectedButton: $selectedTab, tag: 1, text: "Equipment")
                ToggleButton(selectedButton: $selectedTab, tag: 2, text: "Buildings")
            }
            .padding(.bottom, 40)
            
            switch(selectedTab){
            case 0:
                StoreProductView()
            case 1:
                StoreEquipmentView()
            case 2:
                StoreBuildingView()
            default:
                StoreProductView()
            }
        }
//        .background(LinearGradient(colors: [.pink, .cyan],
//                    startPoint: .topLeading,
//                    endPoint: .bottomTrailing))
        .background(LinearGradient(colors: [.black.opacity(0.7),.black.opacity(0.5), .pink.opacity(0.4)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing))
    }
}

#Preview {
    @StateObject var gameState = GameState()
    @StateObject var storeItems = StoreItems()
    @StateObject var buildings = Buildings()
    return StoreView()
        .environmentObject(gameState)
        .environmentObject(storeItems)
        .environmentObject(gameState.currentBuilding.vehicles[0])
        .environmentObject(gameState.inventory)
        .environmentObject(buildings)
}
