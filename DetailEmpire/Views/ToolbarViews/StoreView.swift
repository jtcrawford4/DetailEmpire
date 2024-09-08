import SwiftUI

struct StoreView: View {
    
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var inventory: InventoryItems
    @EnvironmentObject var storeItems: StoreItems
        
    //TODO tab view, tools vs products (products, interior vs ext)
    var body: some View {
        //TODO separate items from iventory vs store buy
        
        VStack{
            ScrollView{
                ForEach(storeItems.storeItems){ item in
                    @State var insufficientFunds = item.price > gameState.money
                    
                    HStack{
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text("\(item.desc)")
                                .font(.caption)
                        }
                        .padding(.leading, 15)
                        .foregroundColor(.white)
                        Spacer()
                        VStack{
                            //info icon to show detail view/usages/unlock/etc
                            if item.purchased || item.startingItem {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.green)
                            }else{
                                if gameState.level >= item.levelUnlocked{
                                    Button(action: {
                                        gameState.money -= item.price
                                        item.purchased = true
                                        inventory.addItem(item: item)
                                    }) {
                                        HStack {
                                            Text("BUY")
                                                .fontWeight(.bold)
                                                .foregroundColor(.green)
                                            //                                        Image(systemName: "dollarsign.circle")
                                            Text("$\(item.price, specifier: "%.2f")")
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                        }
                                    }
                                    //                                Button({
                                    //                                    HStack{
                                    //                                        Image(systemName: "dollarsign.circle")
                                    //                                        Text("$ \(item.price, specifier: "%.2f")")
                                    //                                    }
                                    //                                }, action: {
                                    //                                    gameState.money -= item.price
                                    //                                    item.purchased = true
                                    //                                    inventory.addItem(item: item)
                                    //                                })
                                    .border(.green, width: 2)
                                    //                                .background(insufficientFunds ? .gray : .green)
                                    //                                .background(.green)
                                    .background(Color.green.opacity(0.5))
                                    .foregroundColor(.white)
                                    .disabled(insufficientFunds)
                                    .font(.subheadline)
                                    //                                .cornerRadius(0)
                                }else{
                                    Text("Required level")
                                        .font(.caption)
                                        .foregroundColor(.red)
                                    Text("\(item.levelUnlocked)")
                                        .font(.headline)
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        .buttonStyle(.bordered)
                        .cornerRadius(5)
                        .padding(.trailing, 15)
                    }
                    .padding(.vertical, 15)
                    .background(.red)
                }
            }
        }
        
        
//        List(storeItems.storeItems){
//            item in
//            
//            @State var insufficientFunds = item.price > gameState.money
//            
//            HStack{
//                VStack(alignment: .leading) {
//                    Text(item.name)
//                        .font(.headline)
//                    Text("\(item.desc)")
//                        .font(.caption)
//                }
//                Spacer()
//                VStack{
//                    //info icon to show detail view/usages/unlock/etc
//                    if item.purchased || item.startingItem {
//                        Image(systemName: "checkmark.circle.fill")
//                            .font(.system(size: 20, weight: .bold))
//                            .foregroundColor(.green)
//                    }else{
//                        if gameState.level >= item.levelUnlocked{
//                            Button("$ \(item.price, specifier: "%.2f")", action: {
//                                gameState.money -= item.price
//                                item.purchased = true
//                                inventory.addItem(item: item)
//                            })
//                                .background(insufficientFunds ? .gray : .green)
//                                .foregroundColor(.white)
//                                .disabled(insufficientFunds)
//                                .font(.subheadline)
//                        }else{
//                            Text("Required level")
//                                .font(.caption)
//                                .foregroundColor(.red)
//                            Text("\(item.levelUnlocked)")
//                                .font(.headline)
//                                .foregroundColor(.red)
//                        }
//                    }
//                }
//                .buttonStyle(.bordered)
//                .cornerRadius(5)
//            }
//        }
    }
}

#Preview {
    @StateObject var gameState = GameState()
    @StateObject var storeItems = StoreItems()
    return StoreView()
        .environmentObject(gameState)
        .environmentObject(storeItems)
        .environmentObject(gameState.currentBuilding.vehicles[0])
        .environmentObject(gameState.inventory)
}
