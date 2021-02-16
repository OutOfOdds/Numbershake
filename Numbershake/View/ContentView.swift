//
//  ContentView.swift
//  Numbershake
//
//  Created by Mike Mailian on 08.02.2021.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("onboarding")  var onboardingShowing = true
    @AppStorage("appearance")  var appearance = true
    
    @State var number = "..."
    @State var description = "..."
    @State var showInfo = false
    @State public var showingInfoView = false
    @State private var showingAlert = false
    
    let factTypes = ["date","year","trivia", "math"]
    let allertButtonColor: () = UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = .gray
    let buttonFeedback = UIImpactFeedbackGenerator(style: .medium)
    
    let alertText =
        """
        Sometimes number is too large and you can see the result displayed
        like this: 2e+8
        The term «2e» means that the result is 2 times 10⁸.
        Therefore, 2e+8 in decimal form is:
        200 000 000
        """
    
    var body: some View {
        
        if onboardingShowing {
            OnboardingView(onboardingIsWatched: $onboardingShowing)
        } else {
            
            ZStack {
                ShakableViewRepresentable().allowsHitTesting(false)
                if appearance {
                    Color.offWhite
                        .ignoresSafeArea()
                } else {
                    Color.darkStart
                        .ignoresSafeArea()
                }
                VStack {
                    HStack(alignment: .top) {
                        Text("Numbershake")
                            .font(Font.custom(Baloo.medium, size: 20))
                            .foregroundColor(.gray)
                            .padding()
                        
                        Spacer()
                        
                        VStack() {
                            Button(action: {
                                showingInfoView.toggle()
                                buttonFeedback.impactOccurred()
                            }) {
                                Image(systemName: "star.circle")
                                    .foregroundColor(.gray)
                            }
                            .buttonStyle(CircleButtonStyle(colorMode: appearance))
                            .sheet(isPresented: $showingInfoView, content: {
                                InfoView(BGColor: $appearance, viewIsPresented: $showingInfoView)
                            })
                            Spacer()
                            Button(action: {
                                showingAlert = true
                                buttonFeedback.impactOccurred()
                            }) {
                                Image(systemName: "questionmark.circle")
                                    .foregroundColor(.gray)
                            }
                            .buttonStyle(CircleButtonStyle(colorMode: appearance))
                            .alert(isPresented: $showingAlert, content: {
                                    Alert(title: Text("TIP:"), message:
                                            Text(alertText), dismissButton: .default(Text("Got it!")))})
                            Spacer()
                            
                            Button(action: {
                                appearance.toggle()
                                buttonFeedback.impactOccurred()
                            }) {
                                Image(systemName: appearance ? "moon.circle" : "sun.min")
                                    .foregroundColor(.gray)
                            }
                            .buttonStyle(CircleButtonStyle(colorMode: appearance))
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 150, alignment: .center)
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    HStack(spacing: 2) {
                        Text("⧘")
                            .font(.title)
                            .opacity(1)
                            .foregroundColor(.gray)
                        Text("SHAKE")
                            .font(Font.custom(Baloo.bold, size: 20))
                            .foregroundColor(Color.gray)
                            .opacity(0.8)
                        Text("⧙")
                            .font(.title)
                            .opacity(1)
                            .foregroundColor(.gray)
                        Text(" to get a random number")
                            .font(Font.custom(Baloo.regular, size: 20))
                            .foregroundColor(Color.gray)
                            .opacity(0.5)
                    }
                    .padding()
                    
                    Spacer()
                    
                    Text(number)
                        .font(Font.custom(Baloo.bold, size: 55))
                        .foregroundColor(.gray)
                        .padding()
                        .background(NumberView(colorMode: appearance))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .transition(.opacity)
                        .id(number)
                    
                    if showInfo {
                        Text("day since the beginning of the year")
                            .font(Font.custom(Baloo.regular, size: 15))
                            .foregroundColor(.gray)
                    } else {
                        Text("day since the beginning of the year")
                            .font(Font.custom(Baloo.regular, size: 15))
                            .opacity(0)
                    }
                    
                    Text(description)
                        .multilineTextAlignment(.center)
                        .padding()
                        .font(Font.custom(Baloo.medium, size: 20))
                        .allowsTightening(true)
                        .padding(10)
                        .frame(minHeight: 250)
                        .foregroundColor(.gray)
                        .transition(.opacity)
                        .id(description)
                    
                    Spacer()
                    
                    VStack {
                        Text("or choose manually:")
                            .font(Font.custom(Baloo.regular, size: 17))
                            .foregroundColor(Color.gray)
                            .opacity(0.7)
                        HStack(spacing: 20) {
                            
                            Button(action: {
                                getFact(with: "year")
                                buttonFeedback.impactOccurred()
                            }, label: {
                                Text("Year")
                                    .foregroundColor(.gray)
                            })
                            .buttonStyle(RectangleButtonStyle(colorMode: appearance, width: 120, height: 60))
                            
                            Text("or")
                                .font(Font.custom(Baloo.regular, size: 17))
                                .foregroundColor(Color.gray)
                                .opacity(0.7 )
                            
                            Button(action: {
                                getFact(with: "trivia")
                                buttonFeedback.impactOccurred()
                            }, label: {
                                Text("Trivia")
                                    .foregroundColor(.gray)
                            })
                            .buttonStyle(RectangleButtonStyle(colorMode: appearance, width: 120, height: 60))
                        }
                        .padding()
                    }
                }
                .onAppear(perform: {
                    getFact(with: "trivia")
                })
            }
            .onReceive(messagePublisher) { _ in
                vibroShake()
            }
        }
    }
    
    func getFact(with param: String) {
        let url = URL(string: "http://numbersapi.com/random/\(param)?json")
        let task = URLSession.shared.dataTask(with: url!) { (data, _, _) in
            if let fetchedData = data {
                do {
                    let facts = try JSONDecoder().decode(FactModel.self, from: fetchedData)
                    withAnimation(.easeOut (duration: 0.7)) {
                        if param == "date" {
                            showInfo = true
                            number = (String(format: "%g", facts.number))
                            description = facts.text
                        } else {
                            showInfo = false
                            number = String(format: "%g", facts.number)
                            description = facts.text
                        }
                    }
                }
                catch {
                    print(error)
                }
            } else {
                number = "..."
                description = "please connect to the internet"
            }
        }
        task.resume()
    }
    
    func vibroShake() {
        let randomFact = factTypes.randomElement()
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
        getFact(with: randomFact!)
        print(randomFact!)
    }
}

struct Baloo {
    static let regular  = "BalooThambi2-Regular"
    static let medium   = "BalooThambi2-Medium"
    static let bold     = "BalooThambi2-SemiBold"
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

