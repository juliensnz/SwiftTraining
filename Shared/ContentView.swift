//
//  ContentView.swift
//  Shared
//
//  Created by Julien Sanchez on 10/01/2021.
//

import SwiftUI

struct ContentView: View {
  @State var showCard = false;
  @State var modalOpen = false;
  @State var viewState = CGSize.zero;
  @State var modalState = CGSize.zero;
  
  var body: some View {
    ZStack {
      TitleView()
        .opacity(showCard ? 0.4 : 1)
        .offset(y: showCard ? -200 : 0)
        .animation(Animation.default.delay(0.1))
        .padding(.top, 40)
      
      BackCardView()
        .frame(width: showCard ? 300 : 340, height: 220)
        .background(Color("card4"))
        .cornerRadius(20)
        .shadow(radius: 20)
        .offset(x: 0, y: showCard ? -190 : -40)
        .offset(self.viewState)
        .scaleEffect(showCard ? 1 : 0.9)
        .rotationEffect(Angle(degrees: showCard ? 0 : 10))
        .rotation3DEffect(showCard ? Angle.zero : Angle(degrees: 10), axis: (x: 10.0, y: 0.0, z: 0.0))
        .blendMode(.hardLight)
        .animation(.easeInOut(duration: 0.2))
      BackCardView()
        .frame(width: 340, height: 220)
        .background(Color("card3"))
        .cornerRadius(20)
        .shadow(radius: 20)
        .offset(x: 0, y: showCard ? -140 : -20)
        .offset(self.viewState)
        .scaleEffect(showCard ? 1 : 0.95)
        .rotationEffect(Angle(degrees: showCard ? 0 : 5))
        .rotation3DEffect(showCard ? Angle.zero : Angle(degrees: 5), axis: (x: 10.0, y: 0.0, z: 0.0))
        .blendMode(.hardLight)
        .animation(.easeInOut(duration: 0.2))
      CardView()
        .frame(width: showCard ? 375 : 340.0, height: 220.0)
        .background(Color("background3"))
        .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20, style: .continuous))
        .shadow(radius: 20)
        .blendMode(.hardLight)
        .onTapGesture {
          showCard.toggle()
        }
        .offset(self.viewState)
        .offset(y: showCard ? -100 : 0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
        .gesture(
          DragGesture().onChanged({ value in
            self.viewState = value.translation
            self.showCard = true
          }).onEnded({ _ in
            self.viewState = CGSize.zero
            self.showCard = false
          })
        )
        
      BottomCardView()
        .offset(x: 0, y: showCard ? 450 : 1000)
        .offset(y: modalState.height)
        .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.5))
        .gesture(DragGesture().onChanged({ value in
          self.modalState = value.translation
          if (modalOpen) {
            self.modalState.height += -400
          }
          if self.modalState.height < -400 {
            self.modalState.height = -400
          }
        }).onEnded({ (value) in
          if (self.modalState.height > 50) {
            self.showCard = false;
          }
          
          if (!modalOpen && self.modalState.height < -100) ||
              (modalOpen && self.modalState.height < -350)
          {
            self.modalState.height = -400
            self.modalOpen = true;
          } else {
            self.modalState = .zero
            self.modalOpen = false;
          }
          
        }))
    }
    .ignoresSafeArea(.all)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
    Group {
      ContentView()
        .preferredColorScheme(.dark)
    }
  }
}

struct CardView: View {
  var body: some View {
    VStack {
      HStack {
        VStack(alignment: .leading) {
          Text("UI Design")
            .font(.title)
            .fontWeight(.semibold)
            .foregroundColor(Color("secondary"))
          Text("Certificate")
            .foregroundColor(Color("accent"))
        }
        Spacer()
        Image("Logo1")
      }
      .padding(.horizontal, 20)
      Image("Card1")
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 300, height: 110, alignment: .top)
    }
  }
}

struct BackCardView: View {
  var body: some View {
    VStack {
      Spacer()
    }
  }
}

struct TitleView: View {
  var body: some View {
    VStack {
      HStack {
        Text("Certificates")
          .font(.largeTitle)
          .fontWeight(.bold)
          .padding()
        Spacer()
      }
      Image("Background1")
      Spacer()
    }
  }
}

struct BottomCardView: View {
  var body: some View {
    VStack(spacing: 20) {
      Rectangle()
        .frame(width: 40, height: 5)
        .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
        .opacity(0.1)
      Text("In this section, we'll take a deep dive at all the visual effects that are available in SwiftUI. We'll learn how to create components that can reused throughout the app.")
        .multilineTextAlignment(.center)
        .font(.subheadline)
        .lineSpacing(4)
        .foregroundColor(Color("secondary"))
      Spacer()
    }
    .padding()
    .frame(maxWidth: .infinity)
    .background(Color("background3"))
    .cornerRadius(30)
    .shadow(radius: 20)
  }
}
