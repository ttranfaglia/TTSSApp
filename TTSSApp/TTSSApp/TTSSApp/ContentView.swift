import SwiftUI

// MARK: - Data Model
struct Instruction: Codable, Identifiable {
    let id = UUID()
    let category: String
    let title: String
    let steps: [String]
    let background: String
}

// MARK: - Load JSON
func loadInstructions() -> [Instruction] {
    guard let url = Bundle.main.url(forResource: "instructions", withExtension: "json"),
          let data = try? Data(contentsOf: url) else {
        return []
    }
    let decoder = JSONDecoder()
    return (try? decoder.decode([Instruction].self, from: data)) ?? []
}

// MARK: - ContentView (Home Screen)
struct ContentView: View {
    let instructions = loadInstructions()
    
    // Derived categories
    var categories: [String] {
        Array(Set(instructions.map { $0.category })).sorted()
    }
    
    // Category background colors (can be replaced with images if desired)
    func categoryBackground(for category: String) -> some View {
        switch category {
        case "Email & Outlook": return AnyView(Color.blue.opacity(0.6))
        case "Printing": return AnyView(Color.green.opacity(0.6))
        case "Password & Login": return AnyView(Color.orange.opacity(0.6))
        case "Microsoft 365": return AnyView(Color.purple.opacity(0.6))
        case "Networking & Wi-Fi": return AnyView(Color.red.opacity(0.6))
        default: return AnyView(Color.gray.opacity(0.6))
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Optional subtle background image
                Image("office")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .opacity(0.2)
                
                VStack {
                    // Logo at top
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220, height: 100)
                        .padding(.top, 40)
                    
                    // App title
                    Text("Tech Tips")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                        .padding(.bottom, 10)
                    
                    // Grid of categories
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                            ForEach(categories, id: \.self) { category in
                                NavigationLink(destination: InstructionListView(category: category, instructions: instructions)) {
                                    ZStack {
                                        categoryBackground(for: category)
                                            .frame(height: 120)
                                            .cornerRadius(20)
                                            .shadow(radius: 5)
                                        
                                        Text(category)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                            .padding()
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                    }
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// MARK: - InstructionListView
struct InstructionListView: View {
    let category: String
    let instructions: [Instruction]
    
    var filteredInstructions: [Instruction] {
        instructions.filter { $0.category == category }
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.9).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(filteredInstructions) { instruction in
                        NavigationLink(destination: InstructionDetailView(instruction: instruction)) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.blue.opacity(0.6)) // Can map dynamically if desired
                                    .frame(height: 100)
                                    .shadow(radius: 4)
                                
                                Text(instruction.title)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .padding()
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                }
                .padding(.top, 16)
            }
        }
        .navigationTitle(category)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - InstructionDetailView
struct InstructionDetailView: View {
    let instruction: Instruction
    
    var body: some View {
        ZStack {
            Image(instruction.background)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Color.black.opacity(0.4).ignoresSafeArea()
            
            VStack {
                // Fixed title
                Text(instruction.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 50)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                // Swipeable steps
                TabView {
                    ForEach(instruction.steps.indices, id: \.self) { stepIndex in
                        VStack {
                            Text("Step \(stepIndex + 1)")
                                .font(.headline)
                                .foregroundColor(.yellow)
                                .padding(.bottom, 8)
                            
                            Text(instruction.steps[stepIndex])
                                .font(.body)
                                .foregroundColor(.white)
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
