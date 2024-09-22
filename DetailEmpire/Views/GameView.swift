import SwiftUI

struct GameView: View {
    
    @StateObject var gameState = GameState()
    @StateObject var storeItems = StoreItems()
    @StateObject var buildings = Buildings()
    @State private var selectedTab = 0
    @State var displayMenuModal = false
    
    init() {
//        UITabBar.appearance().backgroundColor = UIColor.systemBlue
        UITabBar.appearance().unselectedItemTintColor = UIColor.black
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Oswald-Light", size: 10)!], for: .selected)
    }

    var body: some View {
        
        @State var inventoryEmpty = gameState.inventory.isAnyItemEmpty()
        @State var payrollDue = gameState.payrollDue
        
        VStack{
            HStack{
                HStack{
                    //TODO include a ticker for notifications
                        //payroll due, inventory manager purchased, etc
                    Text("\(gameState.level)")
                        .font(Font.custom("Oswald-Light", size: 28))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    ProgressView("\(gameState.xp)/\(gameState.xpToNextLevel)", value: Float(Double(gameState.xp)/Double(gameState.xpToNextLevel)))
                        .progressViewStyle(.linear)
                        .font(Font.custom("Oswald-Light", size: 14))
                        .tint(.pink)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(8)
                        .fontWeight(.semibold)
                        .scaleEffect(x: 1, y: 1, anchor: .center)
                        .foregroundColor(.white)
                }
                VStack{
                    Button(action: {
                        displayMenuModal.toggle()
                    }, label: {
                        Image("logo_white")
                            .resizable()
                            .frame(width: 30, height: 30)
                    })
                    .fullScreenCover(isPresented: $displayMenuModal, content: {
                        MenuModalView()
                    })
//                    .fullScreenCover(item: displayMenuModal, content:  MenuModalView())
//                    .fullScreenCover(isPresented: $displayMenuModal) {
//                        MenuModalView()
//                    }
//                    .fullScreenCover(isPresented: $displayMenuModal, content: MenuModalView.init)
                }
                .padding(.horizontal, 50)
                VStack{
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
                }
            }
            .padding(.bottom, 10)
            .padding([.leading, .trailing], 20)
            .background(.black)
        }
        TabView(selection: $selectedTab) {
            WorkView()
                .tabItem {
                    Image(systemName: "car.2.fill")
                    Text("Work")
                        .font(Font.custom("Oswald-Light", size: 10))
                }
                .tag(0)
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
                }
                .tag(2)
            EmployeeView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Employee")
                }
                .tag(3)
                .badge(payrollDue ? "!" : nil)
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

struct BackgroundBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {}
}

func openMainMenu() {
    if let window = UIApplication.shared.windows.first {
        window.rootViewController = UIHostingController(rootView: ContentView())
        window.makeKeyAndVisible()
    }
}

#Preview {
    GameView()
        .environmentObject(GameState())
}
