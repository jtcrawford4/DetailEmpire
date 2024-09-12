import SwiftUI

struct StoreBuildingView: View {
    
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var buildings: Buildings
    
    var body: some View {
        
        ScrollView{
            ForEach(buildings.buildings){ building in
                
                @State var insufficientFunds = building.price > gameState.money
                
                HStack{
                    VStack{
                        ImageOnCircle(icon: "\(building.icon)", radius: 20, circleColor: .green, imageColor: .white)
                    }
                    .padding(.trailing, 10)
                    VStack(alignment: .leading){
                        Text("\(building.name.uppercased())")
                            .font(Font.custom("Oswald-Light", size: 18))
                            .fontWeight(.semibold)
                    }
                    Spacer()
                    if !building.purchased {
                        HStack{
                            VStack{
                                Image(systemName: "car.circle.fill")
                                Divider()
                                    .frame(width: 15, height: 2)
                                    .cornerRadius(4)
                                    .background(.gray)
                                Text("\(building.vehicleSlots)")
                                    .font(Font.custom("Oswald-Light", size: 14))
//                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)
                            }
                            VStack{
                                Image(systemName: "person.circle.fill")
                                Divider()
                                    .frame(width: 15, height: 2)
                                    .cornerRadius(4)
                                    .background(.gray)
                                Text("\(building.workerSlots)")
                                    .font(Font.custom("Oswald-Light", size: 14))
//                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)
                            }
                        }
                    }
                    Spacer()
                    VStack{
                        //info icon to show detail view/usages/unlock/etc
                        if building.purchased { //TODO if purchased and not active building, gray out
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(.green)
                        }else{
                            if gameState.level >= building.unlockLevel{
                                Button(action: {
                                    gameState.money -= building.price
                                    building.purchased = true
                                    gameState.currentBuilding = building
                                }) {
                                    VStack{
                                        Text("PURCHASE")
//                                            .font(.caption2)
                                            .fontWeight(.semibold)
                                        HStack {
                                            Image(systemName: "dollarsign.circle")
                                                .font(.system(size: 16))
                                            Text("\(Formatting.formatPrice(num: building.price))")
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                        }
                                    }
                                    .font(Font.custom("Oswald-Light", size: 14))
                                }
                                .background(insufficientFunds ? .gray : .green)
                                .foregroundColor(.white)
                                .disabled(insufficientFunds)
                                .font(.subheadline)
                                .cornerRadius(8)
                            }else{
                                Text("REQUIRED LEVEL")
                                    .font(Font.custom("Oswald-Light", size: 14))
//                                    .font(.caption)
                                    .foregroundColor(.red)
                                Text("\(building.unlockLevel)")
                                    .font(Font.custom("Oswald-Light", size: 18))
                                    .fontWeight(.semibold)
//                                    .font(.headline)
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
        .contentMargins(.horizontal, 10, for: .scrollContent)
//            .contentMargins(.vertical, 10, for: .scrollContent)
    }
}

#Preview {
    @StateObject var gameState = GameState()
    @StateObject var buildings = Buildings()
    return StoreBuildingView()
        .environmentObject(gameState)
        .environmentObject(buildings)
}
