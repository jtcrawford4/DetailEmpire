import SwiftUI

struct FinanceView: View {
    
    @EnvironmentObject var gameState: GameState
    
    var body: some View {
        VStack{
            Text("//TODO payroll stats, loans, total earned, show percentage of pay by employee type, etc")
                .font(Font.custom("Oswald-Light", size: 14))
                .fontWeight(.regular)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(colors: [.black.opacity(0.7),.black.opacity(0.5), .orange.opacity(0.4)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing))
    }
}

#Preview {
    FinanceView()
        .environmentObject(GameState())
}
