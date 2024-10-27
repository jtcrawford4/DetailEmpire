import SwiftUI

class GradientTabBarController: UITabBarController {

        let gradientlayer = CAGradientLayer()

        override func viewDidLoad() {
            super.viewDidLoad()
            setGradientBackground(colorOne: .yellow, colorTwo: .red)
        }

        func setGradientBackground(colorOne: UIColor, colorTwo: UIColor)  {
            gradientlayer.frame = tabBar.bounds
            gradientlayer.colors = [colorOne.cgColor, colorTwo.cgColor]
            gradientlayer.locations = [0, 1]
            gradientlayer.startPoint = CGPoint(x: 1.0, y: 0.0)
            gradientlayer.endPoint = CGPoint(x: 0.0, y: 0.0)
            self.tabBar.layer.insertSublayer(gradientlayer, at: 0)
        }
}

struct GameView: View {
    
    @StateObject var gameState = GameState()
    @StateObject var storeItems = StoreItems()
    @StateObject var buildings = Buildings()
    @State private var selectedTab = 2
    @State var displayMenuModal = false
    @State var debugEnabled = false
    
    init() {
//        let gradientlayer = CAGradientLayer()
//        gradientlayer.frame = tabBar.bounds
//        gradientlayer.colors = [Color.white, Color.green]
//        layerGradient.frame = CGRect(x: 0, y: 0, width: tabBar.bounds.width,height: tabBar.bounds.height)
//        gradientlayer.locations = [0, 1]
//        gradientlayer.startPoint = CGPoint(x: 1.0, y: 0.0)
//        gradientlayer.endPoint = CGPoint(x: 0.0, y: 0.0)
//        UITabBar.appearance().backgroundColor = UIColor.gray
//        UITabBar.appearance().shadowImage = UIImage(named: "tab-shadow")?.withRenderingMode(.alwaysTemplate)
        UITabBar.appearance().unselectedItemTintColor = UIColor.black
//        UITabBar.appearance().layer.addSublayer(gradientlayer)
//            .layer.insertSublayer(layerGradient, at:0)

//        UITabBar.appearance().isTranslucent = true
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
                        MenuModalView(gameState: gameState, debugEnabled: $debugEnabled)
                    })
                }
                .padding(.horizontal, 30)
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
            EmployeeView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Employee")
                }
                .tag(0)
                .badge(payrollDue ? "!" : nil)
            InventoryView()
                .tabItem {
                    Image(systemName: "shippingbox")
                    Text("Inventory")
                }
                .tag(1)
                .badge(inventoryEmpty ? "!" : nil)
            WorkView()
                .tabItem {
                    Image(systemName: "car.2.fill")
                    Text("Work")
                        .font(Font.custom("Oswald-Light", size: 10))
                }
                .tag(2)
            StoreView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Store")
                }
                .tag(3)
            FinanceView()
                .tabItem {
                    Image(systemName: "dollarsign.circle.fill")
                    Text("Finance")
                }
                .tag(4)
            
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
