import SwiftUI

struct inventoryItemListing: View{
    
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var inventory: InventoryItems
    @Binding var item: InventoryItem
    
    var body: some View {
        
        let isEquipment = item.type == InventoryType.equipment
        let lowStockColors:[Color] = [.orange,.black]
        let outOfStockColors:[Color] = [.red,.black]
        let normalColors:[Color] = [.black,.black]
        @State var lowStock = (item.usesRemaining < 5 && item.usesRemaining != -1) || (isEquipment && item.equipmentCondition < 20 && item.usesRemaining != -1)
        @State var outOfStock = item.usesRemaining == 0 || (isEquipment && item.equipmentCondition == 0)
        @State var insufficientFunds = gameState.money < item.price
        
        HStack{
            VStack{
                if lowStock && !outOfStock {
                    ImageOnCircle(icon: "exclamationmark.triangle", radius: 20, circleColor: .clear, imageColor: .orange)
                }else if outOfStock{
                    ImageOnCircle(icon: "exclamationmark.circle", radius: 20, circleColor: .clear, imageColor: .red)
                }else{
                    ImageOnCircle(icon: "\(item.icon)", radius: 20, circleColor: .pastelGreen, imageColor: .black)
                }
            }
            .padding(.trailing, 6)
            VStack(alignment: .leading){
                Text("\(item.name.uppercased())")
                    .font(Font.custom("Oswald-Light", size: 18))
                    .fontWeight(.semibold)
                Text("\(item.desc)")
                    .font(Font.custom("Oswald-Light", size: 14))
                    .foregroundColor(.white)
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
                        .background(LinearGradient(gradient: Gradient(colors: insufficientFunds ? [.gray, .gray] : [.pink, .red]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .foregroundColor(.white)
                        .disabled(insufficientFunds)
                        .cornerRadius(8)
                    }else{
                        Text("\((isEquipment ? "CONDITION" : "USES REMAINING"))")
                            .font(Font.custom("Oswald-Light", size: 12))
                        Text("\(isEquipment ? item.equipmentCondition : item.usesRemaining)\(isEquipment ? "%" : "")")
                            .font(Font.custom("Oswald-Light", size: 16))
                            .fontWeight(.semibold)
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
        //TODO gradient with tier colors
        .foregroundColor(.white)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(outOfStock ? outOfStockColors[0] : (lowStock ? lowStockColors[0] : .white), lineWidth: 4)
        )
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.4), radius: 0, x: 0, y: 4)
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
                //TODO circle color based on category?
                ImageOnCircle(icon: "\(item.icon)", radius: 20, circleColor: .pastelGreen, imageColor: .white)
            }
            .padding(.trailing, 6)
            VStack(alignment: .leading){
                Text("\(item.name.uppercased())")
                    .font(Font.custom("Oswald-Light", size: 18))
                    .fontWeight(.semibold)
                Text("\(item.desc)")
                    .font(Font.custom("Oswald-Light", size: 14))
                    .foregroundColor(.gray)
//                Text("\(item.desc)")
//                    .font(Font.custom("Oswald-Light", size: 10))
//                    .foregroundColor(.gray)
            }
            Spacer()
            VStack{
                //info icon to show detail view/usages/unlock/etc
                if item.purchased || item.startingItem {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundStyle(
                            .linearGradient(colors: [.pastelGreen, .mint], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                }else{
                    if gameState.level >= item.levelUnlocked{
                        Button(action: {
                            item.purchaseFromStore(item: item, inventory: inventory, gameState: gameState)
                        }) {
                            HStack {
                                Image(systemName: "dollarsign.circle")
                                    .font(.system(size: 16))
                                Text("\(item.price, specifier: "%.2f")")
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
        .foregroundColor(.white)
        .padding(.horizontal, 10)
        .frame(height : 60)
//        .background(.black)
        .background(LinearGradient(colors: [item.getItemTierColor(tier: item.tier).opacity(0.4), .black, .black], startPoint: .leading, endPoint: .trailing))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.white, lineWidth: 4)
        )
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.4), radius: 0, x: 0, y: 4)
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
        let bgColor = getEmployeeTypeBackgroundColors(type: type)
        let employeePayPercentage = Employee.getEmployeePayPerVehiclePercentageByType(type: type)
        @State var insufficientFunds = hirePrice > gameState.money
        @State var buildingHasCapacity = gameState.currentBuilding.employees.count < gameState.currentBuilding.workerSlots
        @State var numDetailEmployees = gameState.numDetailEmployees
//                    @State var insufficientFunds = false
//                    @State var buildingHasCapacity = true
        @State var generalManagerHired = gameState.generalManagerHired
        @State var inventoryManagerHired = gameState.inventoryMangerHired
        @State var shopManagerHired = gameState.shopManagerHired
        let isGeneralManagerWIthoutDetailEmployees = type == EmployeeType.generalManager && numDetailEmployees == 0
        @State var managerAlreadyHired = (type == EmployeeType.generalManager && (isGeneralManagerWIthoutDetailEmployees || generalManagerHired))
            || (type == EmployeeType.inventoryManager && inventoryManagerHired)
            || (type == EmployeeType.shopManager && shopManagerHired)
        @State var disableHire = !buildingHasCapacity || isGeneralManagerWIthoutDetailEmployees || managerAlreadyHired
        
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
                .foregroundColor(disableHire ? .gray.opacity(0.5) : bgColor[0])
                .padding(.top, 2)
                .padding(.bottom, 6)
            VStack{
                if !disableHire {
                    Button(action: {
                        gameState.money -= hirePrice
                        gameState.currentBuilding.employees.append(Employee(payPerVehiclePercentage: employeePayPercentage, type: type))
                        switch (type) {
                            case .generalManager:
                                gameState.generalManagerHired = true
                            case .inventoryManager:
                                gameState.inventoryMangerHired = true
                            case .shopManager:
                                gameState.shopManagerHired = true
                            case .detailer:
                                gameState.numDetailEmployees += 1
                        }
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
                }else if isGeneralManagerWIthoutDetailEmployees{
                    Spacer()
                    Text("NO DETAILERS TO MANAGE")
                        .font(Font.custom("Oswald-Light", size: 12))
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                    Spacer()
//                    Text("\(gameState.currentBuilding.employees.count) / \(gameState.currentBuilding.workerSlots)")
//                        .font(Font.custom("Oswald-Light", size: 18))
//                        .fontWeight(.semibold)
//                        .foregroundColor(.red)
                }else if managerAlreadyHired {
                    Text("MANAGER HIRED")
                        .font(Font.custom("Oswald-Light", size: 14))
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
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
            .padding(.bottom, 6)
        }
        .padding(.horizontal, 10)
        .frame(maxWidth: 150, maxHeight: 200)
        .background(LinearGradient(gradient: Gradient(colors: disableHire ? [.gray, .black.opacity(0.5)] : [bgColor[1], bgColor[0]]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.white, lineWidth: 4)
        )
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.4), radius: 0, x: 0, y: 4)
    }
    
}

struct MenuButton: View{
    
    var title: String
    var function: () -> Void
    var disabled: Bool
    
    var body: some View{
        Button("\(title)", action: function)
            .frame(maxWidth: .infinity)
            .foregroundColor(.pastelYellow.opacity(disabled ? 0.5 : 1))
            .background(.black)
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.pastelYellow.opacity(disabled ? 0.5 : 1), lineWidth: 2)
            )
        .buttonStyle(.bordered)
        .font(Font.custom("Oswald-Light", size: 22))
        .fontWeight(.ultraLight)
        .padding(.horizontal, 100)
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
                    .frame(width: 45, height: 2)
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
//                .overlay(
//                    Circle()
//                        .stroke(.white, lineWidth: 2)
//                )
            
            // Use this implementation for an SF Symbol
            Image(systemName: icon)
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: squareSide, height: squareSide)
                .foregroundColor(imageColor)
//                .shadow(color: Color.black.opacity(0.3), radius: 0, x: 0, y: 2)
                
            
            // Use this implementation for an image in your assets folder.
//            Image(icon)
//                .resizable()
//                .aspectRatio(1.0, contentMode: .fit)
//                .frame(width: squareSide, height: squareSide)
        }
    }
}

struct MenuModalView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var gameState: GameState
    @Binding var debugEnabled: Bool

    var body: some View {
        ZStack {
            VStack{
                VStack{
                    Image("logo_white")
                        .resizable()
                        .frame(width: 50, height: 50)
                    Text("DETAIL EMPIRE")
                        .font(Font.custom("Oswald-Light", size: 18))
                        .fontWeight(.ultraLight)
                        .foregroundColor(.white)
                        .padding(.bottom, 50)
                }
                Spacer()
                VStack{
                    MenuButton(title: "MAIN MENU", function: openMainMenu, disabled: false)
                    Toggle("DEBUG MODE", isOn: $debugEnabled)
                        .onChange(of: debugEnabled) {
                            gameState.level = debugEnabled ? 25 : 1 //TODO somehow hold previous state
                            gameState.money = debugEnabled ? 1000000 : 0 //TODO somehow hold previous state
                        }
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 100)
                        .padding(.top, 20)
                        .tint(.pastelYellow)
                    
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("DISMISS")
                    })
                    .buttonStyle(.bordered)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.pastelRed)
                    .background(.black)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.pastelRed, lineWidth: 2)
                    )
                    .padding(.horizontal, 100)
                    .padding(.top, 60)
                }
                .font(Font.custom("Oswald-Light", size: 22))
                .fontWeight(.ultraLight)
               Spacer()
            }
            Spacer()
        }
        .presentationBackground(LinearGradient(colors: [.pastelYellow.opacity(0.5),.black.opacity(0.95),.black.opacity(0.85),.black.opacity(0.85),.pastelYellow.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
//        .background(BackgroundBlurView())
//        .ignoresSafeArea(.all)
    }
}

struct BackgroundBlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }
    func updateUIView(_ uiView: UIView, context: Context) {}
}
