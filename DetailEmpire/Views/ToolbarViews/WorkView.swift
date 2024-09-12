import SwiftUI

struct WorkView: View {
    
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var vehicle: Vehicle
    @EnvironmentObject var inventory: InventoryItems
    @EnvironmentObject var building: Building
    
    var body: some View {
        
//        @State var detailDisabled = gameState.detailDisabled || vehicle.isCompleted()
//        @State var detailDisabled = gameState.detailDisabled
        @State var detailDisabled = gameState.detailDisabled || inventory.isAnyItemEmpty() || vehicle.isCompleted()

        VStack{
            //Building Stats
            VStack{
                HStack{
                    Image(systemName: "house.fill")
                        .padding(10)
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                        .background(.orange)
                        .cornerRadius(8)
                        .frame(alignment: .leading)
                    VStack{
                        Text("\(building.name.uppercased())")
                            .font(Font.custom("Oswald-Light", size: 28))
                        Divider()
                            .frame(width: 15, height: 2)
                            .cornerRadius(4)
                            .background(.orange)
                            .padding(.vertical, -20)
                            .padding(.horizontal, -73)
                    }
                    Spacer()
                }
                .padding([.horizontal,.top], 10)
//                VStack{
//                    Text("desc")
//                }
                HStack{
                    VStack{
                        BuildingStatView(headline: "PARKING SPACES", value: building.vehicleSlots, color: .purple, image: "car.fill")
                            .padding(.trailing, 10)
                    }
                    Spacer()
                    VStack{
                        BuildingStatView(headline: "MAX EMPLOYEES", value: building.workerSlots, color: .pink, image: "person.fill")
                            .padding(.trailing, 10)
                    }
                    Spacer()
                    VStack{
                        BuildingStatView(headline: "CURRENT EMPLOYEES", value: building.employees.count, color: .cyan, image: "person.fill")
                    }
                }
                .padding([.leading,.trailing], 30)
                .padding(.vertical, 10)
            }
            .background(.white)
            .cornerRadius(8)
            .clipped()
            .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 0)
            .padding(.top, 60)
            .padding([.bottom, .horizontal], 10)
            
            //Vehicles
            VStack{
                HStack{
                    VStack{
                        Text("CURRENT VEHICLES")
                            .font(Font.custom("Oswald-Light", size: 10))
                            .fontWeight(.regular)
                            .foregroundColor(.gray)
                        Divider()
                            .frame(width: 15, height: 2)
                            .cornerRadius(4)
                            .background(.purple)
                            .padding(.vertical, -4)
                            .padding(.horizontal, -35)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(4)
                HStack{
                    VStack{
                        Text("\(vehicle.type.uppercased())")
                            .font(Font.custom("Oswald-Light", size: 20))
                            .fontWeight(.semibold)
                            .padding(.vertical, -2)
                        ProgressView(value: Float(Double(vehicle.percentComplete) / 100))
                            .progressViewStyle(.linear)
                            .padding(.horizontal, 4)
                            .padding(.trailing, 20)
                            .tint(.green.opacity(0.5))
//                            .tint(LinearGradient(gradient: Gradient(colors: [.white, .mint]), startPoint: .leading, endPoint: .trailing))
                    }
                    Spacer()
                    HStack{
                        VStack{
                            VehicleStatView(image: "arrowtriangle.up.circle", value: "\(vehicle.xp)", color: .green)
                        }
                        .padding(.trailing, 10)
                        VStack{
                            VehicleStatView(image: "dollarsign.circle", value: "$\(Formatting.formatPrice(num: vehicle.baseRevenue))", color: .green)
                        }
//                        .padding(.trailing, 10)
//                        VStack{
//                            VehicleStatView(headline: "Bonus", value: "$0", color: .orange)
//                        }
                    }
                    Spacer(minLength: 40)
                    VStack{
                        Button(action: {
                            vehicle.detail(gameState: gameState, inventory: inventory.inventoryItems)
                        }, label: {
                            Text("DETAIL")
                                .font(Font.custom("Oswald-Light", size: 14))
                                .fontWeight(.bold)
                        })
                        .foregroundColor(detailDisabled ? .gray : .white)
                        .padding(10)
                        .background(LinearGradient(gradient: Gradient(colors: detailDisabled ? [.gray, .black.opacity(0.80)] : [.green, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(8)
                        .disabled(detailDisabled)
                        .padding([.vertical,.trailing], 6)
                    }
                    Spacer()
                }
            }
            .background(.white)
            .cornerRadius(8)
            .clipped()
            .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 0)
            .padding([.leading,.trailing], 10)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.vertical)
        .background(LinearGradient(gradient: Gradient(colors: [.purple, .cyan]), startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}

#Preview {
    @StateObject var gameState = GameState()
    @StateObject var storeItems = StoreItems()
    return WorkView()
        .environmentObject(gameState)
        .environmentObject(StoreItems())
        .environmentObject(gameState.currentBuilding.vehicles[0])
        .environmentObject(gameState.inventory)
        .environmentObject(gameState.currentBuilding)
}

struct BuildingStatView:View {
    
    var headline: String
    var value: Int
    var color: Color
    var image: String
    
    var body: some View {
        VStack{
            Text("\(headline)")
                .font(Font.custom("Oswald-Light", size: 10))
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
            Divider()
                .frame(width: 15, height: 2)
                .cornerRadius(4)
                .background(color)
            Text("\(value)")
                .font(Font.custom("Oswald-Light", size: 16))
                .fontWeight(.bold)
                .padding(.bottom, -20)
            Gauge(value: 0.5) {}
                currentValueLabel: {
                    Image(systemName: "\(image)")
                        .foregroundColor(color)
                }
                .gaugeStyle(.accessoryCircular)
                .tint(color)
                .scaleEffect(0.4)
        }
    }
}

struct VehicleStatView:View {
    var image: String
    var value: String
    var color: Color
    var body: some View {
        VStack{
            Image(systemName: image)
                .font(.system(size: 18))
            Divider()
                .frame(width: 15, height: 2)
                .cornerRadius(4)
                .background(.black)
                .padding(.bottom, -30)
            Text("\(value)")
                .font(Font.custom("Oswald-Light", size: 14))
                .fontWeight(.semibold)
                .foregroundColor(color)
                .padding(.bottom, 5)
        }
    }
}
