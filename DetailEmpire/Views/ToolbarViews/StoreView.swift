import SwiftUI

struct StoreView: View {
    
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var inventory: InventoryItems
    @EnvironmentObject var storeItems: StoreItems
    @State private var selectedTab = 0
        
    var body: some View {
        
        VStack{
            Text("Store - add current metrics here")
            
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
//            .clipped()
//            .shadow(color: Color.black.opacity(0.20), radius: 4, x: 0, y: 6)
//            .background(.pink.opacity(0.5))
            
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
        .background(LinearGradient(colors: [.pink, .cyan],
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
