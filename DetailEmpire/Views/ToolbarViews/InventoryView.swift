import SwiftUI

struct InventoryView: View {
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var inventoryItems: InventoryItems
    @State private var showingItemInfo = false
    
    //TODO tab view, tools vs products (products, interior vs ext)
    var body: some View {
            
        //TODO separate items from iventory vs store buy
        List(inventoryItems.inventoryItems){
            item in
            HStack{
//                Image(systemName: "\(item.icon)")
                VStack(alignment: .leading) {
                    HStack{
                        Text(item.name)
                            .font(.headline)
//                        Button("info.circle") {
//                            showingItemInfo = true
//                        }
                    }
                    Text("\(item.desc)")
                        .font(.caption)
                }
                Spacer()
                VStack{
                    if item.usesRemaining != -1 {
                        if item.usesRemaining == 0 {
                            Button(action: {
                                item.refill()
                                gameState.money -= item.price
                                gameState.detailDisabled = gameState.inventory.isAnyItemEmpty()
                            }, label: {
                                Image(systemName: "cart.badge.plus")
                            })
                                .padding([.leading,.trailing], 20)
                                .padding([.top,.bottom], 8)
                                .background(.red)
                                .foregroundColor(.white)
                                .disabled(gameState.money < item.price)
                                .cornerRadius(8)
                                .frame(maxWidth: 90)
                        }else{
                            Text("Uses remaining")
                                .font(.caption)
                            Text("\(item.usesRemaining)")
                        }
                    }else{
                        Text("Uses remaining")
                            .font(.caption)
                        Image(systemName: "infinity")
                            .font(.system(size:16))
                            .padding(.top, 1)
                    }       
                }
            }
//            .background(
//                LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .bottomTrailing, endPoint: .topLeading)
//            )
            
            
            
//            .background(
//                MeshGradient (
//                    width: 3, height: 3, points: [
//                        .init(0, 0),
//                        .init(0.5, 0),
//                        .init(1, 0),
//                        .init(0, 0.5),
//                        .init(0.3, 0.5),
//                        .init(1, 0.5),
//                        .init(0, 1),
//                        .init(0.5, 1),
//                        .init(1, 1)
//                    ],
//                    colors: [ .red, .purple, .indigo, .orange, .cyan, .blue, .yellow, .green, .mint ]
//                )
//            )
//            .background(
//                LinearGradient(stops: [
//                    .init(color: .white, location: 0.45),
//                    .init(color: .black, location: 0.55),
//                ], startPoint: .topLeading, endPoint: .bottomTrailing)
                
//                LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
//            )

            
        }
    }
}

#Preview {
    @StateObject var gameState = GameState()
    @StateObject var storeItems = StoreItems()
    return InventoryView()
        .environmentObject(gameState)
        .environmentObject(StoreItems())
        .environmentObject(gameState.currentVehicle)
        .environmentObject(gameState.inventory)
}
