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

struct ToggleButton: View{
    
    @Binding var selectedButton: Int
    var tag: Int
    var text: String
    
    var body: some View{
        
        @State var isSelected = selectedButton == tag
        VStack{
            Button(action: {
                selectedButton = tag
            }, label: {
                Text(text).textCase(.uppercase)
                    .font(Font.custom("Oswald-Light", size: 14))
//                    .font(.caption)
                    .fontWeight(.semibold)
//                    .foregroundColor(isSelected ? .white : .black)
            })
            .padding(10)
//            .background(isSelected ? .yellow : .pink.opacity(0.5))
//            .foregroundColor(isSelected ? .black : .white)
            .foregroundColor(isSelected ? .white : .black)
            .foregroundColor(.white)
            .tag(tag)
            if isSelected {
                Divider()
                    .frame(width: 75, height: 2)
                    .cornerRadius(4)
//                    .background(.black)
                    .background(.white)
                    .padding(.vertical, -10)
            }
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
    @StateObject var buildings = Buildings()
    return StoreView()
        .environmentObject(gameState)
        .environmentObject(storeItems)
        .environmentObject(gameState.currentBuilding.vehicles[0])
        .environmentObject(gameState.inventory)
        .environmentObject(buildings)
}
