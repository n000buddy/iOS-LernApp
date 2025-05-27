import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // 🎨 Hintergrund (z. B. Farbverlauf)
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue, Color.purple]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("Wähle eine Kategorie")
                        .font(.largeTitle)
                        .foregroundColor(.white)

                    ForEach(Category.allCases, id: \.self) { category in
                        NavigationLink(destination: QuizView(category: category)) {
                            Text(category.rawValue)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white.opacity(0.9))
                                .foregroundColor(.black)
                                .cornerRadius(12)
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

