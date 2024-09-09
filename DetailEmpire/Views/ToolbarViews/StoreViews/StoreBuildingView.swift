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
                        Text("\(building.name)")
                            .font(.subheadline)
                    }
                    Spacer()
                    if !building.purchased {
                        HStack{
                            VStack{
                                Image(systemName: "car.circle.fill")
                                Divider()
                                    .frame(width: 15, height: 2)
                                    .cornerRadius(4)
                                    .background(.black)
                                Text("\(building.vehicleSlots)")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)
                            }
                            VStack{
                                Image(systemName: "person.circle.fill")
                                Divider()
                                    .frame(width: 15, height: 2)
                                    .cornerRadius(4)
                                    .background(.black)
                                Text("\(building.workerSlots)")
                                    .font(.subheadline)
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
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.green)
                        }else{
                            if gameState.level >= building.unlockLevel{
                                Button(action: {
                                    gameState.money -= building.price
                                    building.purchased = true
                                    gameState.currentBuilding = building
                                }) {
                                    VStack{
                                        Text("Purchase")
                                            .font(.caption2)
                                            .fontWeight(.bold)
                                        HStack {
                                            Image(systemName: "dollarsign.circle")
                                            Text("\(Formatting().formatPrice(num: building.price))")
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                                .background(insufficientFunds ? .gray : .green)
                                .foregroundColor(.white)
                                .disabled(insufficientFunds)
                                .font(.subheadline)
                                .cornerRadius(8)
                            }else{
                                Text("Required level")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                Text("\(building.unlockLevel)")
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
