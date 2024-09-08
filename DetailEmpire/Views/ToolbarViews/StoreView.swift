import SwiftUI

struct StoreView: View {
    
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var inventory: InventoryItems
    @EnvironmentObject var storeItems: StoreItems
    @State private var selectedTab = 0
        
    var body: some View {
        
//        @State var productToggled = true
//        @State var equipmentToggled = true
        
        VStack{
            Text("Store - add current metrics here")
            
            HStack(spacing: 0){
                ToggleButton(selectedButton: $selectedTab, tag: 0, text: "Products")
                ToggleButton(selectedButton: $selectedTab, tag: 1, text: "Equipment")
                ToggleButton(selectedButton: $selectedTab, tag: 2, text: "Buildings")
//                Button(action: {selectedTab = 0}, label: {
//                    Text("Products")
//                })
//                .padding(10)
//                .background(selectedTab == 0 ? .cyan : .blue)
//                .foregroundColor(.white)
//                .tag(0)
            }
            .padding(.bottom, 40)
            .clipped()
            .shadow(color: Color.black.opacity(0.20), radius: 4, x: 0, y: 6)
            
            switch(selectedTab){
            case 0:
                StoreProductView()
            case 1:
                StoreEquipmentView()
            default:
                StoreProductView() //TODO
            }
        }
    }
}

struct ToggleButton: View{
    
    @Binding var selectedButton: Int
    var tag: Int
    var text: String
    
    var body: some View{
        VStack{
            Button(action: {
                selectedButton = tag
            }, label: {
                Text(text)
                    .font(.caption)
                    .fontWeight(.bold)
            })
            .padding(10)
            .background(selectedButton == tag ? .cyan : .blue)
            .foregroundColor(.white)
            .tag(tag)
        }
    }
}

struct ImageOnCircle: View {
    
    let icon: String
    let radius: CGFloat
    let circleColor: Color
    let imageColor: Color // Remove this for an image in your assets folder.
    var squareSide: CGFloat {
        2.0.squareRoot() * radius
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(circleColor)
                .frame(width: radius * 2, height: radius * 2)
            
            // Use this implementation for an SF Symbol
            Image(systemName: icon)
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: squareSide, height: squareSide)
                .foregroundColor(imageColor)
            
            // Use this implementation for an image in your assets folder.
//            Image(icon)
//                .resizable()
//                .aspectRatio(1.0, contentMode: .fit)
//                .frame(width: squareSide, height: squareSide)
        }
    }
}

#Preview {
    @StateObject var gameState = GameState()
    @StateObject var storeItems = StoreItems()
    return StoreView()
        .environmentObject(gameState)
        .environmentObject(storeItems)
        .environmentObject(gameState.currentBuilding.vehicles[0])
        .environmentObject(gameState.inventory)
}
