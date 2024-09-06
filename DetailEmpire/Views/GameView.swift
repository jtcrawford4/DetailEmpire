import SwiftUI

struct GameView: View {
    
    @StateObject var gameState = GameState()
    @StateObject var storeItems = StoreItems()
    @State private var selectedTab = 0

       var body: some View {
           HStack{
               Text("Level \(gameState.level)")
               Spacer()
               Text("XP: \(gameState.xp)/\(gameState.xpToNextLevel)")
               Spacer()
               Text("$\(gameState.money, specifier: "%.2f")")
           }
           .font(.caption)
           .padding([.leading,.trailing], 50)
           .padding(.bottom, 10)
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
           .environmentObject(gameState.currentVehicle)
           .environmentObject(gameState.inventory)
           .edgesIgnoringSafeArea(.all)
       }
}

#Preview {
    GameView()
}
