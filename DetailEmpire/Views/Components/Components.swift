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
//                                    .font(.caption2)
                                //                                                .font(Font.custom("Oswald-Light", size: 12))
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
//                                    .font(.caption)
                            .foregroundColor(.red)
                        Text("\(item.levelUnlocked)")
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
