import SwiftUI

struct InventoryView: View {
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var inventoryItems: InventoryItems
    @State private var showingItemInfo = false
    
    //TODO tab view, tools vs products (products, interior vs ext)
    var body: some View {
        
        VStack{
            ScrollView{
                ForEach(inventoryItems.inventoryItems){ item in
                    
                    @State var lowProduct = item.usesRemaining < 5 && item.usesRemaining != -1
                    @State var outOfProduct = item.usesRemaining == 0
                    let bgColor:Color = outOfProduct ? .red : lowProduct ? .orange : .clear
                    
                    VStack{
                        //                    Text("\(item.name)")
                        HStack{
                            if lowProduct && !outOfProduct {
                                Image(systemName: "exclamationmark.circle")
                                    .fontWeight(.light)
                                    .font(.system(size: 24))
                                    .foregroundColor(.yellow)
                            }
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
                        .padding([.trailing, .leading], 25)
                    }
                    //                .containerRelativeFrame(
                    //                    [.horizontal],
                    //                    alignment: .topLeading
                    //                )
                    .padding(.vertical, 15)
                    //                .background(Color.red, ignoresSafeAreaEdges: [])
                    .background(bgColor)
                    //                .border(Color.gray, width: 2)
                }
                //            .frame(width: .infinity)
            }
        }
            
        //TODO separate items from iventory vs store buy
//        List(inventoryItems.inventoryItems){
//            item in
//            
//            @State var lowProduct = item.usesRemaining < 5 && item.usesRemaining != -1
//            @State var outOfProduct = item.usesRemaining == 0
//            let bgColor:Color = outOfProduct ? .red : lowProduct ? .orange : .clear
//            
//            HStack{
//                if lowProduct && !outOfProduct {
//                    Image(systemName: "exclamationmark.circle")
//                        .fontWeight(.light)
//                        .font(.system(size: 24))
//                        .foregroundColor(.yellow)
//                }
//                VStack(alignment: .leading) {
//                    HStack{
//                        Text(item.name)
//                            .font(.headline)
////                        Button("info.circle") {
////                            showingItemInfo = true
////                        }
//                    }
//                    Text("\(item.desc)")
//                        .font(.caption)
//                }
//                Spacer()
//                VStack{
//                    if item.usesRemaining != -1 {
//                        if item.usesRemaining == 0 {
//                            Button(action: {
//                                item.refill()
//                                gameState.money -= item.price
//                                gameState.detailDisabled = gameState.inventory.isAnyItemEmpty()
//                            }, label: {
//                                Image(systemName: "cart.badge.plus")
//                            })
//                                .padding([.leading,.trailing], 20)
//                                .padding([.top,.bottom], 8)
//                                .background(.red)
//                                .foregroundColor(.white)
//                                .disabled(gameState.money < item.price)
//                                .cornerRadius(8)
//                                .frame(maxWidth: 90)
//                        }else{
//                            Text("Uses remaining")
//                                .font(.caption)
//                            Text("\(item.usesRemaining)")
//                        }
//                    }else{
//                        Text("Uses remaining")
//                            .font(.caption)
//                        Image(systemName: "infinity")
//                            .font(.system(size:16))
//                            .padding(.top, 1)
//                    }       
//                }
//            }
//                    .listRowBackground(bgColor)
//                    .foregroundColor(bgColor == Color.clear ? .black : .white)
////                    .padding(.vertical, 50)
////                    .listRowSeparatorTint(.black)
//                    .listRowSeparator(.hidden)
////                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 2)
//            
////            .environment(\.defaultMinListRowHeight, 250) //minimum row height
////            .tint(.red)
////            .tint(lowProduct ? .orange : .clear)
//            //            .background(lowProduct ? .orange : .clear)
//            
////            .background(
////                LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .bottomTrailing, endPoint: .topLeading)
////            )
//            
//            
//            
////            .background(
////                MeshGradient (
////                    width: 3, height: 3, points: [
////                        .init(0, 0),
////                        .init(0.5, 0),
////                        .init(1, 0),
////                        .init(0, 0.5),
////                        .init(0.3, 0.5),
////                        .init(1, 0.5),
////                        .init(0, 1),
////                        .init(0.5, 1),
////                        .init(1, 1)
////                    ],
////                    colors: [ .red, .purple, .indigo, .orange, .cyan, .blue, .yellow, .green, .mint ]
////                )
////            )
////            .background(
////                LinearGradient(stops: [
////                    .init(color: .white, location: 0.45),
////                    .init(color: .black, location: 0.55),
////                ], startPoint: .topLeading, endPoint: .bottomTrailing)
//                
////                LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
////            )
//
//            
//        }
//        .environment(\.defaultMinListRowHeight, 80) //minimum row height
//        .listRowBackground(Color.red)
//        .listRowSeparator(.hidden)
//        .background(.red)

        
        //TODO refill all button
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
