import SwiftUI

struct QuizView: View {
    let category: Category
    @Environment(\.presentationMode) var presentationMode
    @State private var currentQuestion = 0
    @State private var score = 0
    @State private var attempts = 0
    @State private var isAnswerCorrect = false
    @State private var showRestartAlert = false
    @State private var selectedOption: String? = nil
    @State private var showFeedback = false

    var questions: [Question] {
        switch category {
        case .IT: return QuestionProvider.itQuestions
        case .BWL: return QuestionProvider.bwlQuestions
        case .GK: return QuestionProvider.gkQuestions
        case .MK: return QuestionProvider.mkQuestions
        }
    }

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Punkte: \(score)")
                Spacer()
                Text("Frage \(currentQuestion + 1)/\(questions.count)")
            }
            .padding()

            ProgressView(value: Double(currentQuestion), total: Double(questions.count))
                .progressViewStyle(LinearProgressViewStyle(tint: .green))
                .padding()

            Text(questions[currentQuestion].question)
                .font(.title2)
                .padding()

            ForEach(questions[currentQuestion].options, id: \.self) { option in
                Button(action: {
                    answer(option)
                }) {
                    Text(option)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(buttonColor(for: option))
                        .cornerRadius(10)
                }
                .disabled(isAnswerCorrect || attempts >= 2)
            }

            Spacer()

            Button("Zurück zum Start") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()

            Button("Weiter") {
                goToNextQuestion()
            }
            .disabled(!isAnswerCorrect)
            .padding()
            .background(isAnswerCorrect ? Color.blue : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .alert(isPresented: $showRestartAlert) {
            Alert(
                title: Text("Zwei Versuche fehlgeschlagen"),
                message: Text("Du hast zwei Versuche für diese Frage benötigt. Möchtest du das Quiz neu starten?"),
                primaryButton: .default(Text("Ja")) {
                    resetQuiz()
                },
                secondaryButton: .cancel()
            )
        }
    }

    func answer(_ selected: String) {
        selectedOption = selected
        let correct = questions[currentQuestion].correctAnswer
        if selected == correct {
            score += 1
            isAnswerCorrect = true
        } else {
            attempts += 1
            if attempts >= 2 {
                showRestartAlert = true
            }
        }
    }

    func buttonColor(for option: String) -> Color {
        if let selected = selectedOption {
            if option == selected {
                return option == questions[currentQuestion].correctAnswer ? Color.green.opacity(0.5) : Color.red.opacity(0.5)
            }
        }
        return Color.gray.opacity(0.3)
    }

    func goToNextQuestion() {
        if currentQuestion + 1 < questions.count {
            currentQuestion += 1
            isAnswerCorrect = false
            attempts = 0
            selectedOption = nil
        }
    }

    func resetQuiz() {
        score = 0
        currentQuestion = 0
        attempts = 0
        isAnswerCorrect = false
        selectedOption = nil
    }
}

