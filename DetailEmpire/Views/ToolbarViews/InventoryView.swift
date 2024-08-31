import SwiftUI

struct InventoryView: View {
        
    @ObservedObject var inventoryItems = InventoryItems()
    
    //TODO tab view, tools vs products (products, interior vs ext)
    var body: some View {
//        Text("Current Inventory2")
//            .font(.headline)
            
        //TODO separate items from iventory vs store buy
        List(inventoryItems.inventoryItems){
            item in
            HStack{
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    Text("\(item.desc)")
                        .font(.caption)
//                    Text("$ \(item.price)")
//                    Text("Price: \(item.price)")
                }
                Spacer()
                VStack{
                    Text("Uses remaining")
                        .font(.caption)
                    if item.usesRemaining != -1{
                        Text("\(item.usesRemaining)")
                    }else{
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
