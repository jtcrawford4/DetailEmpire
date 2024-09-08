import SwiftUI

struct GameView: View {
    
    @StateObject var gameState = GameState()
    @StateObject var storeItems = StoreItems()
    @State private var selectedTab = 0
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.systemBlue
        UITabBar.appearance().unselectedItemTintColor = UIColor.black
    }

       var body: some View {
           
           HStack(spacing: 100){
               HStack{
                   Text("\(gameState.level)")
                       .font(.callout)
                       .fontWeight(.bold)
                       .foregroundColor(.white)
                   ProgressView("\(gameState.xp)/\(gameState.xpToNextLevel)", value: Float(Double(gameState.xp)/Double(gameState.xpToNextLevel)))
                       .progressViewStyle(.linear)
//                       .progressViewStyle(BarProgressStyle(height: 20.0))
                       .tint(.pink)
                       .background(Color.black.opacity(0.5))
                       .cornerRadius(8)
                       .fontWeight(.bold)
//                       .frame(maxWidth: .infinity, alignment: .center)
                       .scaleEffect(x: 1, y: 1.25, anchor: .center)
               }
               VStack{
                   Button(action: {}, label:{
                       HStack {
                           Image(systemName: "dollarsign.circle")
                               .font(.system(size: 18))
                               .foregroundColor(.mint)
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
           .tint(.white)
//           .tabViewStyle(PageTabViewStyle())
//           .tint(LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .bottomTrailing, endPoint: .topLeading))
       }
}


#Preview {
    GameView()
}

struct BarProgressStyle: ProgressViewStyle {

    var color: Color = .purple
    var height: Double = 20.0
    var labelFontStyle: Font = .body

    func makeBody(configuration: Configuration) -> some View {

        let progress = configuration.fractionCompleted ?? 0.0

        GeometryReader { geometry in

            VStack(alignment: .leading) {

                configuration.label
                    .font(labelFontStyle)

                RoundedRectangle(cornerRadius: 8)
//                    .fill(Color(uiColor: .systemGray5))
                    .frame(height: height)
                    .frame(width: geometry.size.width)
                    .overlay(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(color)
                            .frame(width: geometry.size.width * progress)
                            .overlay {
                                if let currentValueLabel = configuration.currentValueLabel {

                                    currentValueLabel
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }
                            }
                    }

            }

        }
    }
}
