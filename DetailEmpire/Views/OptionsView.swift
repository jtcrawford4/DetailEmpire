import SwiftUI

struct OptionsView: View {
    
    @State private var showGreeting = true
    
    var body: some View {
//        Text("Options")
//            .font(.title)
//        Spacer()
        Group {
            Toggle("Test", isOn: $showGreeting)
                .tint(.cyan)
//                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
//                .padding()
            
//                .background(.blue)

//            if showGreeting {
//                Text("Hello World!")
//            }
        }
        .padding(60)
//        Spacer()
        

        Button("Back", action: self.mainMenu)
            .foregroundColor(.white)
            .padding()
//            .frame(maxWidth: .infinity)
            .background(.blue)
            .cornerRadius(8)
    }
    
    func mainMenu() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: ContentView())
            window.makeKeyAndVisible()
        }
    }
}

#Preview {
    OptionsView()
}
