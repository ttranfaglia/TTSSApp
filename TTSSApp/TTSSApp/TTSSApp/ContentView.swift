import SwiftUI

struct Instruction: Codable, Identifiable {
    let id = UUID()        // local ID for SwiftUI
    let title: String
    let steps: [String]
    let background: String
}

func loadInstructions() -> [Instruction] {
    guard let url = Bundle.main.url(forResource: "instructions", withExtension: "json"),
          let data = try? Data(contentsOf: url) else {
        return []
    }
    
    let decoder = JSONDecoder()
    if let instructions = try? decoder.decode([Instruction].self, from: data) {
        return instructions
    }
    return []
}


struct ContentView: View {
    let instructions: [Instruction] = loadInstructions()
    
    var body: some View {
        if instructions.isEmpty {
            Text("No instructions available.")
                .foregroundColor(.red)
        } else {
            TabView {
                ForEach(instructions) { instruction in
                    ZStack {
                        Image(instruction.background)
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea()
                        
                        Color.black.opacity(0.4).ignoresSafeArea()
                        
                        VStack {
                            // Logo
                            Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 180, height: 80)
                                .padding(.top, 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.black.opacity(0.3))
                                        .shadow(radius: 5)
                                )
                                .padding(.bottom, 10)
                            
                            // Title
                            Text(instruction.title)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                            
                            Spacer()
                            
                            // Steps swipeable
                            TabView {
                                ForEach(instruction.steps.indices, id: \.self) { stepIndex in
                                    VStack {
                                        Text("Step \(stepIndex + 1)")
                                            .font(.headline)
                                            .foregroundColor(.yellow)
                                            .padding(.bottom, 8)
                                        
                                        Text(instruction.steps[stepIndex])
                                            .foregroundColor(.white)
                                            .font(.body)
                                            .multilineTextAlignment(.center)
                                            .padding()
                                            .background(
                                                Color.black.opacity(0.3)
                                                    .cornerRadius(16)
                                                    .padding()
                                            )
                                    }
                                }
                            }
                            .tabViewStyle(.page)
                            .frame(height: 300)
                            
                            Spacer()
                        }
                    }
                }
            }
            .tabViewStyle(.page)
        }
    }
}

