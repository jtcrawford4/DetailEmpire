import SwiftUI

struct StoreProductView: View {
    
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var inventory: InventoryItems
    @EnvironmentObject var storeItems: StoreItems
    
    var body: some View {
        
        ScrollView{
            ForEach(storeItems.storeItems){ item in
                
                if item.type == InventoryItem.InventoryType.product {
                    
                    @State var insufficientFunds = item.price > gameState.money
                    
                    HStack{
                        VStack{
                            ImageOnCircle(icon: "\(item.icon)", radius: 20, circleColor: .green, imageColor: .white)
                        }
                        .padding(.trailing, 10)
                        VStack(alignment: .leading){
                            Text("\(item.name)")
                                .font(.headline)
                            Text("\(item.desc)")
                                .font(.caption2)
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
                                    Button(action: {
                                        gameState.money -= item.price
                                        item.purchased = true
                                        inventory.addItem(item: item)
                                    }) {
                                        VStack{
                                            Text("Purchase")
                                                .font(.caption2)
                                                .fontWeight(.bold)
                                            HStack {
                                                Image(systemName: "dollarsign.circle")
                                                Text("\(item.price, specifier: "%.2f")")
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.white)
                                            }
                                        }
                                    }
                                    .background(insufficientFunds ? .gray : .green)
                                    //                                        .background(Color.green.opacity(0.5))
                                    .foregroundColor(.white)
                                    .disabled(insufficientFunds)
                                    .font(.subheadline)
                                    .cornerRadius(8)
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
                    .padding(.horizontal, 10)
                    .frame(height : 60)
                    .background(.white)
                    .cornerRadius(8)
                    .clipped()
                    .shadow(color: Color.black.opacity(0.15), radius: 4, x: 2, y: 2)
                }
            }
        }
        .contentMargins(.horizontal, 10, for: .scrollContent)
//            .contentMargins(.vertical, 10, for: .scrollContent)
    }
}

#Preview {
    @StateObject var gameState = GameState()
    @StateObject var storeItems = StoreItems()
    return StoreProductView()
        .environmentObject(gameState)
        .environmentObject(storeItems)
        .environmentObject(gameState.inventory)
}
