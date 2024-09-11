import SwiftUI

struct ContentView: View {
    var body: some View {
        Spacer()
        VStack {
            Image(systemName: "flame")
                .font(.system(size: 60, weight: .ultraLight))
//                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Test")
        }
        .padding()
        Spacer()
        VStack {
            Button("CONTINUE", action: self.test)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.blue)
                .disabled(true)
                .cornerRadius(8)
            Button("NEW GAME", action: self.openNewGame)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.blue)
                .cornerRadius(8)
            Button("OPTIONS", action: self.openOptions)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.blue)
                .cornerRadius(8)
        }
        .padding(100)
        .font(Font.custom("Oswald-Light", size: 22))
        .fontWeight(.semibold)
//        .onAppear(perform: {
//            for family in UIFont.familyNames.sorted() {
//                let names = UIFont.fontNames(forFamilyName: family)
//                print("Family: \(family) Font names: \(names)")
//            }
//        })
        Spacer()
    }
    
    func test(){
        
    }
    
//    fix deprecated usages
    func openNewGame() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: GameView())
            window.makeKeyAndVisible()
        }
    }
    
    func openOptions() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: OptionsView())
            window.makeKeyAndVisible()
        }
    }
}

#Preview {
    ContentView()
}
