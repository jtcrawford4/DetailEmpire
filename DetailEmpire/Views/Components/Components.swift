import SwiftUI

//struct BarProgressStyle: ProgressViewStyle {
//
//    var color: Color = .purple
//    var height: Double = 20.0
//    var labelFontStyle: Font = .body
//
//    func makeBody(configuration: Configuration) -> some View {
//
//        let progress = configuration.fractionCompleted ?? 0.0
//
//        GeometryReader { geometry in
//
//            VStack(alignment: .leading) {
//                configuration.label
//                    .font(labelFontStyle)
//
//                RoundedRectangle(cornerRadius: 8)
//                    .frame(height: height)
//                    .frame(width: geometry.size.width)
//                    .overlay(alignment: .leading) {
//                        RoundedRectangle(cornerRadius: 10.0)
//                            .fill(color)
//                            .frame(width: geometry.size.width * progress)
//                            .overlay {
//                                if let currentValueLabel = configuration.currentValueLabel {
//
//                                    currentValueLabel
//                                        .font(.headline)
//                                        .foregroundColor(.white)
//                                }
//                            }
//                    }
//
//            }
//
//        }
//    }
//}

struct inventoryItemListing: View{
    
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var inventory: InventoryItems
    @Binding var item: InventoryItem
    
    var body: some View {
        
        let isEquipment = item.type == InventoryType.equipment
        let lowStockColors:[Color] = [.yellow,.white]
        let outOfStockColors:[Color] = [.red,.white]
        let normalColors:[Color] = [.white,.white]
        @State var lowStock = (item.usesRemaining < 5 && item.usesRemaining != -1) || (isEquipment && item.equipmentCondition < 20 && item.usesRemaining != -1)
        @State var outOfStock = item.usesRemaining == 0 || (isEquipment && item.equipmentCondition == 0)
        
        HStack{
            VStack{
                if lowStock && !outOfStock {
                    ImageOnCircle(icon: "exclamationmark.triangle", radius: 20, circleColor: .clear, imageColor: .orange)
                }else if outOfStock{
                    ImageOnCircle(icon: "exclamationmark.octagon", radius: 20, circleColor: .clear, imageColor: .red)
                }else{
                    ImageOnCircle(icon: "\(item.icon)", radius: 20, circleColor: .green, imageColor: .white)
                }
            }
            .padding(.trailing, 6)
            VStack(alignment: .leading){
                Text("\(item.name.uppercased())")
                    .font(Font.custom("Oswald-Light", size: 18))
                    .fontWeight(.semibold)
                Text("\(item.desc)")
                    .font(Font.custom("Oswald-Light", size: 14))
                    .foregroundColor(.secondary)
            }
            Spacer()
            VStack{
                //info icon to show detail view/usages/unlock/etc
                if item.usesRemaining != -1 {
                    if item.usesRemaining == 0 {
                        Button(action: {
                            item.refill()
                            gameState.money -= item.price
                            gameState.detailDisabled = gameState.inventory.isAnyItemEmpty()
                            if isEquipment {
                                item.equipmentCondition = 100
                            }
                        }, label: {
                            VStack{
                                Text("\((isEquipment ? "REPLACE" : "REFILL"))")
                                    .font(Font.custom("Oswald-Light", size: 12))
                                    .fontWeight(.semibold)
                                if isEquipment {
                                    HStack {
                                        Image(systemName: "dollarsign.circle")
                                            .font(.system(size: 16))
                                        Text("\(item.price, specifier: "%.2f")")
                                            .font(Font.custom("Oswald-Light", size: 14))
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    }
                                } else {
                                    Image(systemName: "cart.badge.plus")
                                }
                            }
                        })
                        .padding([.leading,.trailing], 25)
                        .padding([.top,.bottom], 4)
                        .background(.red)
                        .foregroundColor(.white)
                        .disabled(gameState.money < item.price)
                        .cornerRadius(8)
                    }else{
                        Text("\((isEquipment ? "CONDITION" : "USES REMAINING"))")
                            .font(Font.custom("Oswald-Light", size: 12))
                        Text("\(isEquipment ? item.equipmentCondition : item.usesRemaining)\(isEquipment ? "%" : "")")
                            .font(Font.custom("Oswald-Light", size: 16))
                            .fontWeight(.semibold)
                        //TODO color based on condition
                    }
                }else{
                    Text("\((isEquipment ? "CONDITION" : "USES REMAINING"))")
                        .font(Font.custom("Oswald-Light", size: 12))
                    Image(systemName: "infinity")
                        .font(.system(size:16))
                        .fontWeight(.semibold)
                        .padding(.top, 1)
                }
            }
            .cornerRadius(5)
        }
        .padding(.horizontal, 10)
        .frame(height : 60)
        .background(LinearGradient(colors: outOfStock ? outOfStockColors : (lowStock ? lowStockColors : normalColors),
                                   startPoint: .trailing,
                                   endPoint: .leading))
        .cornerRadius(8)
        .clipped()
        .shadow(color: Color.black.opacity(0.15), radius: 4, x: 2, y: 2)
    }
}

struct storeInventoryItemListing: View{
    
    @Binding var item: InventoryItem
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var inventory: InventoryItems
    
    var body: some View {
        
        @State var insufficientFunds = item.price > gameState.money
        
        HStack{
            VStack{
                ImageOnCircle(icon: "\(item.icon)", radius: 20, circleColor: .green, imageColor: .white)
            }
            .padding(.trailing, 6)
            VStack(alignment: .leading){
                Text("\(item.name.uppercased())")
                    .font(Font.custom("Oswald-Light", size: 18))
                    .fontWeight(.semibold)
                Text("\(item.desc)")
                    .font(Font.custom("Oswald-Light", size: 14))
                    .foregroundColor(.secondary)
            }
            Spacer()
            VStack{
                //info icon to show detail view/usages/unlock/etc
                if item.purchased || item.startingItem {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.green)
                }else{
                    if gameState.level >= item.levelUnlocked{
                        Button(action: {
                            gameState.money -= item.price
                            item.purchased = true
                            inventory.addItem(item: item)
                            gameState.inventoryItemMoneyMultiplier += item.moneyMultiplier
                            gameState.inventoryItemSpeedMultiplier += item.speedMultiplier
                        }) {
                            VStack{
                                Text("PURCHASE")
                                    .fontWeight(.semibold)
                                HStack {
                                    Image(systemName: "dollarsign.circle")
                                        .font(.system(size: 16))
                                    Text("\(item.price, specifier: "%.2f")")
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
                            .foregroundColor(.red)
                        Text("\(item.levelUnlocked)")
                            .font(Font.custom("Oswald-Light", size: 18))
                            .fontWeight(.semibold)
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

func getEmployeeTypeBackgroundColors(type: EmployeeType) -> [Color] {
    switch (type){
    case .detailer:
        return [.blue, .cyan]
    case .generalManager,
        .inventoryManager,
        .shopManager:
        return [.orange, .yellow]
//    case .inventoryManager:
//        return [.red, .pink]
//    case .shopManager:
//        return [.indigo, .purple]
    }
}

struct employeeListingView: View{
    
    var type: EmployeeType
    @EnvironmentObject var gameState: GameState
    
    var body: some View{
        
        let hirePrice = Employee.getNextEmployeeHireCost(employees: gameState.currentBuilding.employees, type: type)
        let desc = Employee.getEmployeeDesc(type: type)
        @State var insufficientFunds = hirePrice > gameState.money
        @State var buildingHasCapacity = gameState.currentBuilding.employees.count < gameState.currentBuilding.workerSlots
//                    @State var insufficientFunds = false
//                    @State var buildingHasCapacity = false
        let bgColor = getEmployeeTypeBackgroundColors(type: type)
        let employeePayPercentage = Employee.getEmployeePayPerVehiclePercentageByType(type: type)
        
        VStack{
            Text("\(type.rawValue)").textCase(.uppercase)
                .multilineTextAlignment(.center)
                .font(Font.custom("Oswald-Light", size: 18))
                .foregroundColor(.white)
            Text("\(desc)")
                .font(Font.custom("Oswald-Light", size: 12))
                .foregroundColor(.black.opacity(0.75))
                .multilineTextAlignment(.center)
            if(buildingHasCapacity){
                Text("PAY PER VEHICLE: \(employeePayPercentage, specifier: "%.0f")%")
                    .font(Font.custom("Oswald-Light", size: 10))
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
            }
            Image(systemName: "person.fill")
                .font(.system(size: 60))
                .foregroundColor(!buildingHasCapacity ? .gray.opacity(0.5) : bgColor[0])
                .padding(.top, 2)
                .padding(.bottom, 6)
            VStack{
                if buildingHasCapacity {
                    Button(action: {
                        gameState.money -= hirePrice
                        gameState.currentBuilding.employees.append(Employee(payPerVehiclePercentage: employeePayPercentage, type: type))
                    }) {
                        VStack{
                            Text("HIRE")
                                .fontWeight(.semibold)
                                .padding(.horizontal, 18)
                                .frame(height: 20)
                            HStack {
                                Image(systemName: "dollarsign.circle")
                                    .font(.system(size: 16))
                                Text("\(Formatting.formatPrice(num: hirePrice))")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                        }
                        .font(Font.custom("Oswald-Light", size: 14))
                    }
                    .frame(minWidth: 85)
                    .background(LinearGradient(gradient: Gradient(colors: insufficientFunds ? [.gray, .gray] : [.green, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(8)
                    .padding(.bottom, 4)
                    .foregroundColor(.white)
                    .disabled(insufficientFunds)
                    .shadow(color: Color.black.opacity(0.25), radius: 0, x: 0, y: 4)
                }else{
                    Text("CAPACITY LIMIT")
                        .font(Font.custom("Oswald-Light", size: 14))
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                    Text("\(gameState.currentBuilding.employees.count) / \(gameState.currentBuilding.workerSlots)")
                        .font(Font.custom("Oswald-Light", size: 18))
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                }
            }
        }
        .padding(.horizontal, 10)
        .frame(maxWidth: 150, maxHeight: 200)
        .background(LinearGradient(gradient: Gradient(colors: !buildingHasCapacity ? [.gray, .black.opacity(0.5)] : [bgColor[1], bgColor[0]]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(8)
        .clipped()
        .shadow(color: Color.black.opacity(0.15), radius: 4, x: 2, y: 2)
    }
    
}

struct ToggleButton: View{
    
    @Binding var selectedButton: Int
    var tag: Int
    var text: String
    
    var body: some View{
        
        @State var isSelected = selectedButton == tag
        VStack{
            Button(action: {
                selectedButton = tag
            }, label: {
                Text(text).textCase(.uppercase)
                    .font(Font.custom("Oswald-Light", size: 14))
                    .fontWeight(.semibold)
            })
            .padding(10)
            .foregroundColor(isSelected ? .white : .black)
            .foregroundColor(.white)
            .tag(tag)
            if isSelected {
                Divider()
                    .frame(width: 75, height: 2)
                    .cornerRadius(4)
                    .background(.white)
                    .padding(.vertical, -10)
            }
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
