import SwiftUI

struct StoreBuildingView: View {
    
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var buildings: Buildings
    
    var body: some View {
        
        //TODO only show next building available? dont allow down sizing?
        
        ScrollView{
            ForEach(buildings.buildings){ building in
                
                @State var insufficientFunds = building.price > gameState.money
                
                HStack{
                    VStack{
                        ImageOnCircle(icon: "\(building.icon)", radius: 20, circleColor: .pastelPurple, imageColor: .white)
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
                                    .padding(.top, 2)
                                    .padding(.bottom, -6)
                                Text("\(building.vehicleSlots)")
                                    .font(Font.custom("Oswald-Light", size: 14))
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)
                            }
                            VStack{
                                Image(systemName: "person.circle.fill")
                                Divider()
                                    .frame(width: 15, height: 2)
                                    .cornerRadius(4)
                                    .background(.gray)
                                    .padding(.top, 2)
                                    .padding(.bottom, -6)
                                Text("\(building.workerSlots)")
                                    .font(Font.custom("Oswald-Light", size: 14))
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)
                            }
                        }
                        .padding(.top, 4)
                    }
                    Spacer()
                    VStack{
                        //info icon to show detail view/usages/unlock/etc
                        if building.purchased { //TODO if purchased and not active building, gray out
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 30, weight: .bold))
                                .foregroundStyle(
                                    .linearGradient(colors: [.pastelGreen, .mint], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                        }else{
                            if gameState.level >= building.unlockLevel{
                                Button(action: {
                                    building.buyBuilding(gameState: gameState)
                                }) {
                                    HStack {
                                        Image(systemName: "dollarsign.circle")
                                            .font(.system(size: 16))
                                        Text("\(Formatting.formatPrice(num: building.price))")
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    }
                                    .font(Font.custom("Oswald-Light", size: 14))
                                }
                                .background(LinearGradient(gradient: Gradient(colors: insufficientFunds ? [.gray, .gray.opacity(0.5)] : [.green, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .foregroundColor(.white)
                                .disabled(insufficientFunds)
                                .font(.subheadline)
                                .cornerRadius(8)
                            }else{
                                Text("REQUIRED LEVEL")
                                    .font(Font.custom("Oswald-Light", size: 12))
                                    .foregroundColor(.red)
                                Text("\(building.unlockLevel)")
                                    .font(Font.custom("Oswald-Light", size: 18))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    .buttonStyle(.bordered)
                    .cornerRadius(5)
                }
                .foregroundColor(.white)
                .padding(.horizontal, 10)
                .frame(height : 60)
                .background(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.white, lineWidth: 4)
                )
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.4), radius: 0, x: 0, y: 4)
            }
        }
        .contentMargins(.horizontal, 10, for: .scrollContent)
    }
}

#Preview {
    @StateObject var gameState = GameState()
    @StateObject var buildings = Buildings()
    return StoreBuildingView()
        .environmentObject(gameState)
        .environmentObject(buildings)
}
