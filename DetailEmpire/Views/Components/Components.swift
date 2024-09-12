import SwiftUI

struct BarProgressStyle: ProgressViewStyle {

    var color: Color = .purple
    var height: Double = 20.0
    var labelFontStyle: Font = .body

    func makeBody(configuration: Configuration) -> some View {

        let progress = configuration.fractionCompleted ?? 0.0

        GeometryReader { geometry in

            VStack(alignment: .leading) {

                configuration.label
                    .font(labelFontStyle)

                RoundedRectangle(cornerRadius: 8)
//                    .fill(Color(uiColor: .systemGray5))
                    .frame(height: height)
                    .frame(width: geometry.size.width)
                    .overlay(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(color)
                            .frame(width: geometry.size.width * progress)
                            .overlay {
                                if let currentValueLabel = configuration.currentValueLabel {

                                    currentValueLabel
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }
                            }
                    }

            }

        }
    }
}

struct inventoryItemListing: View{
    
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var inventory: InventoryItems
    @Binding var item: InventoryItem
    
    var body: some View {
        
        @State var lowProduct = item.usesRemaining < 5 && item.usesRemaining != -1
        @State var outOfProduct = item.usesRemaining == 0
        let outOfProductColors:[Color] = [.red,.white]
        let lowProductColors:[Color] = [.yellow,.white]
        let normalColors:[Color] = [.white,.white]
        
        HStack{
            VStack{
                if lowProduct && !outOfProduct {
                    ImageOnCircle(icon: "exclamationmark.triangle", radius: 20, circleColor: .clear, imageColor: .orange)
                }else if outOfProduct{
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
                        }, label: {
                            VStack{
                                Text("REFILL")
                                    .font(Font.custom("Oswald-Light", size: 12))
                                    .fontWeight(.semibold)
                                Image(systemName: "cart.badge.plus")
                            }
                        })
                        .padding([.leading,.trailing], 25)
                        .padding([.top,.bottom], 4)
                        .background(.red)
                        .foregroundColor(.white)
                        .disabled(gameState.money < item.price)
                        .cornerRadius(8)
                    }else{
                        Text("USES REMAINING")
                            .font(Font.custom("Oswald-Light", size: 12))
                        Text("\(item.usesRemaining)")
                            .font(Font.custom("Oswald-Light", size: 16))
                            .fontWeight(.semibold)
                    }
                }else{
                    Text("USES REMAINING")
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
        .background(LinearGradient(colors: outOfProduct ? outOfProductColors : (lowProduct ? lowProductColors : normalColors),
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
//                    .font(.caption)
                    .fontWeight(.semibold)
//                    .foregroundColor(isSelected ? .white : .black)
            })
            .padding(10)
//            .background(isSelected ? .yellow : .pink.opacity(0.5))
//            .foregroundColor(isSelected ? .black : .white)
            .foregroundColor(isSelected ? .white : .black)
            .foregroundColor(.white)
            .tag(tag)
            if isSelected {
                Divider()
                    .frame(width: 75, height: 2)
                    .cornerRadius(4)
//                    .background(.black)
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
