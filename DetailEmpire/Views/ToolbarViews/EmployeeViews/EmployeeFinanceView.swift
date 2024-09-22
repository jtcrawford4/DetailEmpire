import SwiftUI

struct EmployeeFinanceView: View {
    
    @EnvironmentObject var gameState: GameState
    
    var body: some View {
        
        @State var payrollOwed = gameState.getPayrollOwed()
        @State var workersOnStrike = gameState.workersOnStrike
        @State var insufficientFunds = payrollOwed > gameState.money
        
        ScrollView{
            VStack{
                HStack{
                    VStack{
                        Text("PAYROLL")
                            .font(Font.custom("Oswald-Light", size: 10))
                            .fontWeight(.regular)
                            .foregroundColor(.white)
                        Divider()
                            .frame(width: 15, height: 2)
                            .cornerRadius(4)
                            .background(.pastelGreen)
                            .padding(.vertical, -4)
                            .padding(.horizontal, -15)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(4)
                VStack(alignment: .center){
                    ForEach(EmployeeType.allCases){ emp in
                        activeStatView(label: "\(emp.rawValue)".uppercased(), value: gameState.getPayrollOwedByEmployeeType(type: emp),  modifier: "$", color: .pink)
                    }
                    Divider()
                        .background(.white)
                    activeStatView(label: "TOTAL", value: gameState.getPayrollOwed(), modifier: "$", color: .pink)
                    if workersOnStrike {
                        Text("WORKERS ON STRIKE")
                            .font(Font.custom("Oswald-Light", size: 20))
                            .fontWeight(.semibold)
                            .foregroundColor(.pink)
                    }
                    Button(action: {
                        gameState.money -= payrollOwed
                        gameState.payrollDue = false
                        gameState.vehiclesSincePayroll = 0
                        gameState.resetPayrollOwed()
                    }) {
                        VStack{
                            HStack {
                                Image(systemName: "dollarsign.circle")
                                    .font(.system(size: 16))
                                Text("\(payrollOwed, specifier: "%.2f")")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                        }
                        .font(Font.custom("Oswald-Light", size: 14))
                    }
                    .buttonStyle(.bordered)
                    .frame(minWidth: 85)
                    .background(LinearGradient(gradient: Gradient(colors: insufficientFunds ? [.gray, .gray] : [.pink, .red]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(8)
                    .padding(.bottom, 4)
                    .foregroundColor(.white)
                    .disabled(insufficientFunds)
                    .shadow(color: Color.black.opacity(0.25), radius: 0, x: 0, y: 4)
                }
                .padding(.horizontal, 50)
                .padding(.bottom, 6)
            }
            .background(RadialGradient(colors: [.black,.mint.opacity(0.5)], center: .top, startRadius: 0, endRadius: 750))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.white, lineWidth: 2)
            )
            .padding([.horizontal, .bottom], 10)
            .shadow(color: Color.black.opacity(0.4), radius: 0, x: 0, y: 4)
            .brightness(0.2)
        }
    }
}

#Preview {
    @StateObject var gameState = GameState()
    return EmployeeFinanceView()
        .environmentObject(gameState)
}
