import SwiftUI

struct InventoryView: View {
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var inventoryItems: InventoryItems
    @State private var showingItemInfo = false
    
    //TODO tab view, tools vs products (products, interior vs ext)
    var body: some View {
        
        //TODO refill all button
        //TODO product vs equipment
        VStack{
            ScrollView{
                ForEach(inventoryItems.inventoryItems){ item in
                    
                    @State var lowProduct = item.usesRemaining < 5 && item.usesRemaining != -1
                    @State var outOfProduct = item.usesRemaining == 0
//                    let bgColor:Color = outOfProduct ? .red : (lowProduct ? .yellow : .white)
                    
                    let outOfProductGradient = LinearGradient(colors: [.red, .white],
                                                              startPoint: .trailing,
                                                              endPoint: .leading)
                    let lowProductGradient = LinearGradient(colors: [.yellow, .white],
                                                              startPoint: .trailing,
                                                              endPoint: .leading)
                    let normalGradiet = LinearGradient(colors: [.white, .white],
                                                              startPoint: .trailing,
                                                              endPoint: .leading)
                    
                    let bgGradient:LinearGradient = outOfProduct ? outOfProductGradient : (lowProduct ? lowProductGradient : normalGradiet)
                    
                    HStack{
                        VStack{
                            if lowProduct && !outOfProduct {
                                ImageOnCircle(icon: "exclamationmark.triangle", radius: 20, circleColor: .clear, imageColor: .orange)
                            }else if outOfProduct{
                                ImageOnCircle(icon: "exclamationmark.octagon", radius: 20, circleColor: .clear, imageColor: .red)
                            }else{
                                ImageOnCircle(icon: "\(item.icon)", radius: 20, circleColor: .green, imageColor: .white)
                            }
                        }
                        .padding(.trailing, 6)
                        VStack(alignment: .leading){
                            Text("\(item.name.uppercased())")
                                .font(Font.custom("Oswald-Light", size: 18))
                                .fontWeight(.semibold)
                            Text("\(item.desc)")
                                .font(Font.custom("Oswald-Light", size: 14))
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        VStack{
                            //info icon to show detail view/usages/unlock/etc
                            if item.usesRemaining != -1 {
                                if item.usesRemaining == 0 {
                                    Button(action: {
                                        item.refill()
                                        gameState.money -= item.price
                                        gameState.detailDisabled = gameState.inventory.isAnyItemEmpty()
                                    }, label: {
//                                        Text("test")
                                        VStack{
                                            Text("REFILL")
                                                .font(Font.custom("Oswald-Light", size: 12))
                                                .fontWeight(.semibold)
                                            Image(systemName: "cart.badge.plus")
                                        }
                                    })
                                    .padding([.leading,.trailing], 25)
                                    .padding([.top,.bottom], 4)
                                    .background(.red)
                                    .foregroundColor(.white)
                                    .disabled(gameState.money < item.price)
                                    .cornerRadius(8)
//                                    .clipped()
//                                    .shadow(color: Color.black.opacity(0.95), radius: 4, x: 2, y: 2)
//                                    .border(.white.opacity(0.5), width: 1)
//                                    .frame(maxWidth: 90)
                                }else{
                                    Text("USES REMAINING")
                                        .font(Font.custom("Oswald-Light", size: 12))
//                                        .font(.caption)
                                    Text("\(item.usesRemaining)")
                                        .font(Font.custom("Oswald-Light", size: 16))
                                        .fontWeight(.semibold)
                                }
                            }else{
                                Text("USES REMAINING")
                                    .font(Font.custom("Oswald-Light", size: 12))
//                                    .font(.caption)
                                Image(systemName: "infinity")
                                    .font(.system(size:16))
                                    .fontWeight(.semibold)
                                    .padding(.top, 1)
                            }
                        }
//                        .buttonStyle(.bordered)
                        .cornerRadius(5)
                    }
                    .padding(.horizontal, 10)
                    .frame(height : 60)
//                    .background(.white)
//                    .background(bgColor)
                    .background(bgGradient)
                    .cornerRadius(8)
                    .clipped()
                    .shadow(color: Color.black.opacity(0.15), radius: 4, x: 2, y: 2)
                }
                .padding(.horizontal, 10)
            }
            .background(LinearGradient(colors: [.orange, .cyan],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing))
        }
    }
}

#Preview {
    @StateObject var gameState = GameState()
    @StateObject var storeItems = StoreItems()
    return InventoryView()
        .environmentObject(gameState)
        .environmentObject(StoreItems())
        .environmentObject(gameState.currentBuilding.vehicles[0])
        .environmentObject(gameState.inventory)
}
