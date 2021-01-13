//
//  HomeView.swift
//  DesignCode
//
//  Created by Julien Sanchez on 11/01/2021.
//

import SwiftUI

struct HomeView: View {
  @Binding var showProfile: Bool;
  @State var showUpdates = false;
  
  var body: some View {
    VStack {
      HStack {
        Text("Watching")
          .font(.system(size: 28, weight: .bold))
        Spacer()
        AvatarView(showProfile: self.$showProfile)
        Button(action: {
          self.showUpdates.toggle();
        }) {
          Image(systemName: "bell")
            .renderingMode(.original)
            .font(.system(size: 16, weight: .medium))
            .frame(width: 36, height: 36)
            .background(Color.white)
            .clipShape(Circle())
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0.0, y: 1)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0.0, y: 10)
        }.sheet(isPresented: self.$showUpdates, content: {
          UpdateList()
        })
      }
      .padding(.horizontal)
      .padding(.leading, 14)
      .padding(.top, 30)
      
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 20) {
          ForEach(sectionData) { section in
            GeometryReader { geometry in
              SectionView(section: section)
                .rotation3DEffect(Angle(degrees:
                  -Double(geometry.frame(in: .global).minX)/20
                ), axis: (x: 0, y: 10.0, z: 0))
            }.frame(width: 275, height: 275)
          }
        }.padding(30)
        .padding(.bottom, 30)
      }
      
      Spacer()
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView(showProfile: Binding.constant(false))
  }
}

struct SectionView: View {
  let section: Section;
  
  var body: some View {
    VStack {
      HStack(alignment: .top) {
        Text(section.title)
          .font(.system(size: 24, weight: .bold))
          .frame(width: 160, alignment: .leading)
          .foregroundColor(.white)
        
        Spacer()
        
        Image(section.logo)
      }
      
      Text(section.subtitle.uppercased())
        .frame(maxWidth: .infinity, alignment: .leading)
      
      section.image
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 210)
    }
    .padding(.top, 20)
    .padding(.horizontal, 20)
    .frame(width: 275, height: 275)
    .background(section.color)
    .cornerRadius(30)
    .shadow(color: section.color.opacity(0.3), radius: 20, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 20)
  }
}


struct Section: Identifiable {
  let id = UUID();
  let title: String;
  let logo: String;
  let subtitle: String;
  let image: Image;
  let color: Color;
}

let sectionData = [
  Section(
    title: "Prototype designs in SwiftUI",
    logo: "Logo1",
    subtitle: "18 sections",
    image: Image(uiImage: #imageLiteral(resourceName: "Card5")),
    color: Color("card1")
  ),
  Section(
    title: "Prototype designs in SwiftUI",
    logo: "Logo1",
    subtitle: "20 sections",
    image: Image(uiImage: #imageLiteral(resourceName: "Card4")),
    color: Color("card2")
  ),
  Section(
    title: "Prototype designs in SwiftUI",
    logo: "Logo1",
    subtitle: "20 sections",
    image: Image(uiImage: #imageLiteral(resourceName: "Card2")),
    color: Color("card3")
  ),
  Section(
    title: "Prototype designs in SwiftUI",
    logo: "Logo1",
    subtitle: "18 sections",
    image: Image("Card1"),
    color: Color("card4")
  )
]

