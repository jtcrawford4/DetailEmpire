import SwiftUI

struct StoreView: View {
    
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var inventory: InventoryItems
    @EnvironmentObject var storeItems: StoreItems
        
    //TODO tab view, tools vs products (products, interior vs ext)
    var body: some View {
        //TODO separate items from iventory vs store buy
        
        VStack{
            Text("Store - add category tabs")
            ScrollView{
                ForEach(storeItems.storeItems){ item in
                    
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
//                        .padding(.trailing, 15)
                    }
                    .padding(.horizontal, 10)
//                    .cornerRadius(8)
                    .frame(height : 60)
                    .background(.white)
                    .cornerRadius(8)
                    .clipped()
                    .shadow(color: Color.black.opacity(0.15), radius: 4, x: 2, y: 2)
//                    .padding(.bottom, )
                }
            }
            .contentMargins(.horizontal, 10, for: .scrollContent)
//            .contentMargins(.vertical, 10, for: .scrollContent)
//            .cornerRadius(8)
        }
    }
}

struct ImageOnCircle: View {
    
    let icon: String
    let radius: CGFloat
    let circleColor: Color
    let imageColor: Color // Remove this for an image in your assets folder.
    var squareSide: CGFloat {
        2.0.squareRoot() * radius
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(circleColor)
                .frame(width: radius * 2, height: radius * 2)
            
            // Use this implementation for an SF Symbol
            Image(systemName: icon)
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: squareSide, height: squareSide)
                .foregroundColor(imageColor)
            
            // Use this implementation for an image in your assets folder.
//            Image(icon)
//                .resizable()
//                .aspectRatio(1.0, contentMode: .fit)
//                .frame(width: squareSide, height: squareSide)
        }
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
