import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
               
                LinearGradient(
                    gradient: Gradient(colors: [Color.green, Color.blue]), //Verlauf
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 30) {
                    Text("Wähle eine Kategorie")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    ForEach(Category.allCases, id: \.self) { category in
                        NavigationLink(destination: QuizView(category: category)) {
                            Text(category.rawValue)
                                .padding()
                                .frame(maxWidth: .infinity) //Rahmen
                                .background(Color.black.opacity(10))
                                .foregroundColor(.white)
                              
            
            .cornerRadius(20) //Balken Radius
                        }
                    }
                }
                .padding()
            }
        }
    }
}

enum Category: String, CaseIterable {
    case IT = "IT"
    case BWL = "BWL"
    case GK = "Gemeinschaftskunde"
    case MK = "Mathematik"
}

#Preview {
    ContentView()
}

