//
//  InfoView.swift
//  Numbershake
//
//  Created by Mike Mailian on 12.02.2021.
//

import SwiftUI

struct InfoView: View {
    
    @Binding var BGColor: Bool
    @Binding var viewIsPresented: Bool
    
    var colorSwitсh: Color {
        return BGColor ? Color.offWhite : Color.darkStart
    }
    
    var separatorStyle: () = UITableView.appearance().separatorStyle = .singleLine
    var cellStyle: () = UITableViewCell.appearance().backgroundColor = .clear
    var tableViewStyle: () = UITableView.appearance().backgroundColor = .clear
    let buttonFeedback = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        
        ZStack {
            if BGColor {
                Color.offWhite
                    .ignoresSafeArea(.all)
            } else {
                Color.darkStart
                    .ignoresSafeArea(.all)
            }
            
            VStack (spacing: 50) {
                HStack {
                    Text("Numbershake")
                        .font(Font.custom("BalooThambi2-Regular", size: 20))
                        .foregroundColor(.gray)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button(action: {
                        viewIsPresented = false
                        buttonFeedback.impactOccurred()
                    }) {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(.gray)
                    }
                    .buttonStyle(CircleButtonStyle(colorMode: BGColor))
                    
                }.padding()
                
                
                List {
                    Section(header: Text("if you want to add your fact check out:")) {
                        Link(destination: URL(string: "http://numbersapi.com/")!, label: {
                            HStack (alignment: .center) {
                                Text("Powered by NumbersAPI")
                                Spacer()
                                Image(systemName: "link.icloud.fill")
                                    .imageIconModifier()
                                
                            }
                        })
                        .listRowBackground(colorSwitсh)
                    }
                    
                    Section(header: Text("other useful links:")) {
                        Link(destination: URL(string: "https://apps.apple.com/us/app/pokerlog/id1547807748")!, label: {
                            HStack(alignment: .center) {
                                Text("Check out PokerLog")
                                Spacer()
                                Image(systemName: "suit.club.fill")
                                    .imageIconModifier()
                            }
                        }).listRowBackground(colorSwitсh)
                        
                        Link(destination: URL(string: "https://github.com/OutOfOdds")!, label: {
                            HStack (alignment: .center) {
                                Text("My GitHub")
                                Spacer()
                                Image("github")
                                    .imageIconModifier()
                            }
                        })
                        .listRowBackground(colorSwitсh)
                    }
                    
                    Section(header: Text("or you can:")) {
                        
                        Link(destination: URL(string: "https://www.buymeacoffee.com/MihoM")!, label: {
                            HStack(alignment: .center) {
                                Text("Buy me a coffee")
                                Spacer()
                                Image("BMCLogo")
                                    .imageIconModifier()
                            }
                        }).listRowBackground(colorSwitсh)
                        
                    }
                    
                }
                .font(Font.custom("BalooThambi2-Medium", size: 20))
                .shadow(radius: 10)
                .foregroundColor(.gray)
                .listStyle(InsetGroupedListStyle())
                
                Text("\"Number rules the universe\" ― Pythagoras")
                    .font(Font.custom("BalooThambi2-regular", size: 20))
                    .foregroundColor(.gray)
                    .padding()
                    .opacity(0.7)
                Spacer()
                
                Text("Mike Mailyan")
                    .font(Font.custom("BalooThambi2-Regular", size: 15))
                    .foregroundColor(.gray)
            }
        }
    }
}


//MARK: - Preview

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(BGColor: ContentView().$appearance, viewIsPresented: ContentView().$showingInfoView)
    }
}

//MARK: - Modifiers


// Reusable frame modifiers
struct FrameModifier: ViewModifier {
    
    var maxWidth: CGFloat
    var minHeight: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: maxWidth, minHeight: minHeight,alignment: .center)
            .font(Font.custom("BalooThambi2-Regular", size: 20))
            .foregroundColor(.gray)
            .padding(.horizontal, 25)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.darkEnd, lineWidth: 3)
                    .blur(radius: 4)
                    .offset(x: 2, y: 2)
                    .mask(RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(Color.black
                                                 , Color.clear)))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
                    .blur(radius: 4)
                    .offset(x: -2, y: -2)
                    .mask(RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(Color.clear, Color.black)))
            )
    }
}



// Reusable icon modifiers
extension Image {
    func imageIconModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: 30)
    }
}

struct LinkButton: View {
    var text: String
    var imageName: String
    var color: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack {
                Text(text)
                Spacer()
                Image(systemName: imageName)
                    .imageIconModifier()
            }.padding()
        })
        .buttonStyle(RectangleButtonStyle(colorMode: color,width: 300, height: 60))
        .listRowBackground(Color.clear)
    }
}
