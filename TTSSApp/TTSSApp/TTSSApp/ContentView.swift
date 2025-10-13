import SwiftUI

struct Instruction {
    let title: String
    let steps: [String]
    let background: String
}

struct ContentView: View {
    let instructions = [
        Instruction(
            title: "Add or Remove Apps in Office 365 Waffle",
            steps: [
                "Click on Waffle (or Menu icon).",
                "Click on More apps.",
                "Click on All apps to see all Microsoft apps.",
                "Scroll down to Admin Selected and click on an app (e.g., Escape 6). It will open in another tab and be automagically added to the Waffle.",
                "To pin it to the side bar, click on the Apps tab at the top and click on the 3 dots on Escape 6.",
                "Click on Pin (now it is pinned to the side bar).",
                "To remove an app, right-click on it and select Unpin."
            ],
            background: "bg1"
        ),
        Instruction(
            title: "Share a File in OneDrive",
            steps: [
                "Open OneDrive.",
                "Navigate to the file you want to share.",
                "Right-click on the file and select Share.",
                "Enter the recipient’s email or copy the link.",
                "Click Send or Copy Link to finish."
            ],
            background: "bg2"
        ),
        Instruction(
            title: "Use Copilot to compose emails",
            steps: [
                "In a new message, click on Draft with Copilot",
                "Type in an idea of your email, hit enter",
                "If the first draft is not exactly what you want use the prompt pop-up to make changes - like, click on make it shorter",
                "Still not the tone you're looking for...try, make it funnier",
                "Once Copilot has drafted the email they want you prefer, click on Keep it",
                "Be sure to review it and make any edits before sending it"
            ],
            background: "bg3"
        ),
        Instruction(
            title:"Empty your Deleted Items and your Junk Email folder",
            steps: [
                "Click on the Junk email folder.",
                "Click on Empty folder icon",
                "Click on Delete All in pop-up",
                "Click on the Deleted Items email folder",
                "Click on Empty folder icon",
                "Click on Delete All in pop-up"
            ],
            background: "bg4"
        ),
        Instruction(
            title: "How to Ask for Support",
            steps: [
                "Sign in to Zendesk",
                "Click on Submit A Request at the top",
                "Choose to whom the ticket should go or Other/I don't know",
                "Complete the rest of the form with as much information about the issue - the more the better",
                "Click on Submit",
                "You will get a confirmation on the screen as well as an email",
            ],
                background: "bg5"
            
        )
    ]
    
    var body: some View {
        ZStack {
            // 🔹 Outer TabView controls instruction + background
            TabView {
                ForEach(instructions.indices, id: \.self) { index in
                    ZStack {
                        // Background image changes per instruction
                        Image(instructions[index].background)
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea()
                        
                        Color.black.opacity(0.4).ignoresSafeArea()
                        
                        VStack {
                            // 🔹 Fixed Logo
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
                            
                            // 🔹 Title (fixed under logo)
                            Text(instructions[index].title)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                            
                            Spacer()
                            
                            // 🔹 Inner TabView for steps
                            TabView {
                                ForEach(instructions[index].steps.indices, id: \.self) { stepIndex in
                                    VStack {
                                        Text("Step \(stepIndex + 1)")
                                            .font(.headline)
                                            .foregroundColor(.yellow)
                                            .padding(.bottom, 8)
                                        
                                        Text(instructions[index].steps[stepIndex])
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
