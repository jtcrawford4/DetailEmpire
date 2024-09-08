import SwiftUI

struct GameView: View {
    
    @StateObject var gameState = GameState()
    @StateObject var storeItems = StoreItems()
    @State private var selectedTab = 0

       var body: some View {
           
           HStack(spacing: 100){
               HStack{
                   Text("\(gameState.level)")
                       .font(.callout)
                       .fontWeight(.bold)
                       .foregroundColor(.white)
                   ProgressView("\(gameState.xp)/\(gameState.xpToNextLevel)", value: Float(Double(gameState.xp)/Double(gameState.xpToNextLevel)))
                       .progressViewStyle(.linear)
                       .tint(.pink)
                       .background(Color.black.opacity(0.5))
                       .foregroundColor(.white)
                       .cornerRadius(8)
                       .fontWeight(.bold)
               }
               VStack{
                   Button(action: {}, label:{
                       HStack {
                           Image(systemName: "dollarsign.circle")
                               .font(.system(size: 18))
                           Spacer()
                           Text("\(gameState.money, specifier: "%.2f")")
                               .fontWeight(.bold)
                               .foregroundColor(.white)
                       }
                       .font(.callout)
                       .padding([.vertical, .leading], 4)
                       .padding(.trailing, 10)
                   })
                   .background(Color.black.opacity(0.5))
                   .cornerRadius(8)
               }
           }
           .font(.caption)
           .padding(.bottom, 10)
           .padding([.leading, .trailing], 10)
           .background(.blue)
           .foregroundColor(.white)
           
           TabView(selection: $selectedTab) {
               WorkView()
                   .tabItem {
                       Image(systemName: "car.2.fill")
                       Text("Work")
                   }.tag(0)
               InventoryView()
                   .tabItem {
                       Image(systemName: "shippingbox")
                       Text("Inventory")
                   }.tag(1)
               StoreView()
                   .tabItem {
                       Image(systemName: "dollarsign.circle.fill")
                       Text("Store")
                   }.tag(2)
               EmployeeView()
                   .tabItem {
                       Image(systemName: "person.fill")
                       Text("Employee")
                   }.tag(3)
           }
           .environmentObject(gameState)
           .environmentObject(storeItems)
           .environmentObject(gameState.currentBuilding.vehicles[0])
           .environmentObject(gameState.inventory)
           .environmentObject(gameState.currentBuilding)
           .edgesIgnoringSafeArea(.all)
           .background(.cyan)
       }
}

#Preview {
    GameView()
}
