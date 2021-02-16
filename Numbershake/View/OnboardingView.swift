//
//  OnboardingView.swift
//  Numbershake
//
//  Created by Mike Mailian on 15.02.2021.
//

import SwiftUI

struct OnboardingView: View {
    
    @Binding var onboardingIsWatched: Bool
    
    var body: some View {
        ZStack {
            Color.offWhite
                .ignoresSafeArea()
            VStack {
                Group {
                    Text ("README.pls")
                        .font(Font.custom(Baloo.medium, size: 20))
                    Spacer()
                    Text ("Shake your iPhone")
                        .font(Font.custom(Baloo.bold, size: 25))
                    Text ("you will get a random number and a fact about it")
                        .padding(.horizontal, 20)
                        .multilineTextAlignment(.center)
                        .font(Font.custom(Baloo.regular, size: 20))
                    Spacer()
                    Text ("Fact can be about random number, date, year or sometimes hardcore math fact")
                        .padding(.horizontal, 20)
                        .multilineTextAlignment(.center)
                        .font(Font.custom(Baloo.bold, size: 20))
                    
                    Spacer()
                    
                    HStack {
                        Text ("Press")
                        Button(action: {}, label: {
                            Text("Year")
                                .font(Font.custom(Baloo.bold, size: 20))
                        }).buttonStyle(RectangleButtonStyle(colorMode: true, width: 100, height: 50))
                        Text ("or")
                        Button(action: {}, label: {
                            Text("Trivia")
                                .font(Font.custom(Baloo.bold, size: 20))
                        }).buttonStyle(RectangleButtonStyle(colorMode: true, width: 100, height: 50))
                    }
                    Text ("buttons to choose fact manually")
                        .padding()
                }
                .font(Font.custom(Baloo.regular, size: 20))
                
                Spacer()
                
                HStack {
                    Text("Press")
                    Image(systemName: "sun.min")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                    Text("or")
                    Image(systemName: "moon.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                    Text("to change appearance")
                }
                .font(Font.custom(Baloo.regular, size: 20))
                
                Spacer()
                
                Button(action: {
                    onboardingIsWatched.toggle()
                }, label: {
                    Text("Let's go!")
                        .font(Font.custom(Baloo.bold, size: 35))
                })
                .padding()
                .buttonStyle(RectangleButtonStyle(colorMode: true, width: 200, height: 80))
            }
            .foregroundColor(.gray)
            .font(Font.custom(Baloo.bold, size: 20))
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(onboardingIsWatched: Binding<Bool>.constant(false))
    }
}
