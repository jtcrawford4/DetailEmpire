import SwiftUI

struct StoreView: View {
    
    @ObservedObject var gameState = GameState()
    @ObservedObject var inventory = InventoryItems()
    @ObservedObject var storeItems = StoreItems()
    
//    struct BlueButtonStyle: ButtonStyle {
//        func makeBody(configuration: Self.Configuration) -> some View {
//            configuration.label
//                .foregroundColor(configuration.isPressed ? Color.blue : Color.white)
//                .background(configuration.isPressed ? Color.white : Color.blue)
//                .cornerRadius(4)
//                .padding()
//        }
//    }
    
    //TODO tab view, tools vs products (products, interior vs ext)
    var body: some View {
        //TODO separate items from iventory vs store buy
//        for idx in 0..<storeItems.storeItems.count {
//            storeItems.storeItems[idx].isSelected = false
//        }
        List(storeItems.storeItems){
            item in
            
            @State var insufficientFunds = item.price > gameState.money
            
            HStack{
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    Text("\(item.desc)")
                        .font(.caption)
                }
                Spacer()
                VStack{
                    //info icon to show detail view/usages/unlock/etc
                    if item.purchased || item.startingItem {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.green)
                    }else{
                        if gameState.level >= item.levelUnlocked{
                            Button("$ \(item.price, specifier: "%.2f")", action: {
                                gameState.money -= item.price
                                item.purchased = true
                                inventory.addItem(item: item)
                            })
                                .background(insufficientFunds ? .gray : .green)
                                .foregroundColor(.white)
                                .disabled(insufficientFunds)
                                .font(.subheadline)
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
            }
        }
    }
}

#Preview {
    StoreView()
}
