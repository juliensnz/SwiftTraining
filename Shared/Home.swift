//
//  Home.swift
//  DesignCode
//
//  Created by Julien Sanchez on 11/01/2021.
//

import SwiftUI

struct Home: View {
  @State var showProfile = false;
  @State var profileDragState = CGSize.zero;
  
  var body: some View {
    ZStack {
      Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        .edgesIgnoringSafeArea(.all)
      
      HomeView(showProfile: self.$showProfile)
        .padding(.top, 44)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.2), radius: 20, x: 0, y: 20)
        .rotation3DEffect(
          Angle(degrees: self.showProfile ? Double(self.profileDragState.height) / 25 - 10 : 0),
          axis: (x: 10, y: 0, z: 0.0)
        )
        .offset(y: self.showProfile ? -450 : 0)
        .offset(y: self.profileDragState.height)
        .scaleEffect(self.showProfile ? 0.9 : 1)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .ignoresSafeArea(.all)
      
      MenuView()
        .background(Color.black.opacity(0.001))
        .offset(y: self.showProfile ? 0 : screen.height)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .gesture(
          DragGesture().onChanged({ (value) in
            if (value.translation.height > -50) {
              self.profileDragState = value.translation;
            }
          }).onEnded({ _ in
            if (self.profileDragState.height > 50) {
              self.showProfile = false;
            }
            
            self.profileDragState = .zero
          })
        )
        .offset(y: self.profileDragState.height)
        .onTapGesture {
          self.showProfile = false;
        }
    }
  }
}

struct Home_Previews: PreviewProvider {
  static var previews: some View {
    Home()
    Home()
      .previewDevice("iPad (8th generation)")
  }
}

let screen = UIScreen.main.bounds

struct AvatarView: View {
  @Binding var showProfile: Bool;
  
  var body: some View {
    Button(action: {
      self.showProfile.toggle();
    }) {
      Image("Avatar")
        .renderingMode(.original)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 36, height: 36)
        .clipShape(Circle())
        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0.0, y: 1)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0.0, y: 10)
    }
  }
}
