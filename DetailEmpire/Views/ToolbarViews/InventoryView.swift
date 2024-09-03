import SwiftUI

struct InventoryView: View {
    @ObservedObject var gameState = GameState()
    @ObservedObject var inventoryItems = InventoryItems()
    @State private var showingItemInfo = false
    
    //TODO tab view, tools vs products (products, interior vs ext)
    var body: some View {
            
        //
       
        
        //
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
//                if item.purchased || item.startingItem{
//                    Image(systemName: "checkmark.circle.fill")
//                        .font(.system(size: 20, weight: .bold))
                    //TODO this should be uses remaining
//                }else{
//                    Button("$ \(item.price, specifier: "%.2f")", action: item.buy)
//                        .background(.green)
//                        .foregroundColor(.white)
//                        .padding(10)
//                }
                
//                Group{
//                    Button(action: {
//                        self.gameState.purchase(pointGenerator: pointGenerator)
//                    }){Text("Purchase")}
//                        .buttonStyle(BorderlessButtonStyle())
//                        .disabled(self.gameState.points < pointGenerator.price)
//                }
            }
        }
    }
}

#Preview {
    InventoryView()
}
