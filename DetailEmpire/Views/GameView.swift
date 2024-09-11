import SwiftUI

struct GameView: View {
    
    @StateObject var gameState = GameState()
    @StateObject var storeItems = StoreItems()
    @StateObject var buildings = Buildings()
    @State private var selectedTab = 0
    
    init() {
//        UITabBar.appearance().backgroundColor = UIColor.systemBlue
        UITabBar.appearance().unselectedItemTintColor = UIColor.black
    }

    var body: some View {
        
        @State var inventoryEmpty = gameState.inventory.isAnyItemEmpty()
        
        VStack {
            HStack(){
                HStack{
                    Text("\(gameState.level)")
                        .font(Font.custom("Oswald-Light", size: 28))
//                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    //TODO circle level progress?
                    ProgressView("\(gameState.xp)/\(gameState.xpToNextLevel)", value: Float(Double(gameState.xp)/Double(gameState.xpToNextLevel)))
                        .progressViewStyle(.linear)
                        .font(Font.custom("Oswald-Light", size: 14))
//                        .font(.callout)
                    //                       .progressViewStyle(BarProgressStyle(height: 20.0))
                        .tint(.pink)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(8)
                        .fontWeight(.semibold)
                        .scaleEffect(x: 1, y: 1, anchor: .center)
                        .foregroundColor(.white)
                }
                Spacer(minLength: 100)
                VStack{
                    Button(action: {}, label:{
                        HStack {
                            Image(systemName: "dollarsign.circle")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                            Spacer()
                            Text("\(gameState.money, specifier: "%.2f")")
                                .font(Font.custom("Oswald-Light", size: 14))
                                .fontWeight(.semibold)
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
            .padding(.bottom, 10)
            .padding([.leading, .trailing], 20)
//            .frame(height: 60)
            .background(.black)
//            .background(LinearGradient(gradient: Gradient(colors: [.mint, .pink.opacity(0.4), .mint]), startPoint: .bottomLeading, endPoint: .topTrailing))
        }
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
                }
                .tag(1)
                .badge(inventoryEmpty ? "!" : nil)
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
//            }
//            .toolbar {
//                ToolbarItem(placement: .bottomBar) {
//                    HStack {
//                        Text("This is a toolbar")
//                           .bold()
//                        Spacer()
//                        Image(systemName: "play.fill")
//                        Image(systemName: "forward.fill")
//                    }
//                }
//            }
        }
        .environmentObject(gameState)
        .environmentObject(storeItems)
        .environmentObject(gameState.currentBuilding.vehicles[0])
        .environmentObject(gameState.inventory)
        .environmentObject(gameState.currentBuilding)
        .environmentObject(buildings)
        .padding(.top, -10)
        .tint(.white)
    }
}


#Preview {
    GameView()
}
