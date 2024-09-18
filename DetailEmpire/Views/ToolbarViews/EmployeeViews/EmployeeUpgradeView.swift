import SwiftUI

struct EmployeeUpgradeView: View {
    var body: some View {
        ScrollView{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    @StateObject var gameState = GameState()
    return EmployeeUpgradeView()
        .environmentObject(gameState)
}
