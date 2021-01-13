//
//  UpdateList.swift
//  DesignCode
//
//  Created by Julien Sanchez on 12/01/2021.
//

import SwiftUI

struct UpdateList: View {
  @ObservedObject var store = UpdateStore();
  func addUpdate() {
    store.updates.append(Update(image: "Card1", title: "New update", text: "Text", date: "Jan 1"))
  }
  
  var body: some View {
    NavigationView {
      List {
        ForEach(store.updates) { update in
          NavigationLink(destination: UpdateDetail(update: update)) {
            HStack {
              Image(update.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .background(Color.black)
                .cornerRadius(20)
                .padding(.trailing, 4)
              
              VStack(alignment: .leading, spacing: 8) {
                Text(update.title)
                  .font(.system(size: 20, weight: .bold))
              
                Text(update.text)
                  .lineLimit(2)
                  .font(.subheadline)
                  .foregroundColor(.black)
                
                Text(update.date)
                  .font(.caption)
                  .fontWeight(.bold)
                  .foregroundColor(.secondary)
              }
            }.padding(.vertical, 8)
          }
        }.onDelete(perform: { indexSet in
          self.store.updates.remove(at: indexSet.first!)
        })
        .onMove { (source: IndexSet, destination: Int) in
          self.store.updates.move(fromOffsets: source, toOffset: destination)
        }
      }
      .navigationBarTitle(Text("Updates"))
      .toolbar {
        ToolbarItemGroup(placement: .navigationBarLeading) {
          Button(action: addUpdate) {
            Text("Add update")
          }
        }
        ToolbarItemGroup(placement: .navigationBarTrailing) {
          EditButton()
        }
      }
    }
  }
}

struct UpdateList_Previews: PreviewProvider {
  static var previews: some View {
    UpdateList()
  }
}

struct Update: Identifiable {
  let id = UUID();
  let image: String;
  let title: String;
  let text: String;
  let date: String;
}

let updateData = [
  Update(image: "Card1", title: "SwiftUI Advanced", text: "Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.", date: "JAN 1"),
  Update(image: "Card2", title: "Webflow", text: "Design and animate a high converting landing page with advanced interactions, payments and CMS", date: "OCT 17"),
  Update(image: "Card3", title: "ProtoPie", text: "Quickly prototype advanced animations and interactions for mobile and Web.", date: "AUG 27"),
  Update(image: "Card4", title: "SwiftUI", text: "Learn how to code custom UIs, animations, gestures and components in Xcode 11", date: "JUNE 26"),
  Update(image: "Card5", title: "Framer Playground", text: "Create powerful animations and interactions with the Framer X code editor", date: "JUN 11")
]
