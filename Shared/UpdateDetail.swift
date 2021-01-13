//
//  UpdateDetail.swift
//  DesignCode
//
//  Created by Julien Sanchez on 12/01/2021.
//

import SwiftUI

struct UpdateDetail: View {
  var update: Update;
  
  var body: some View {
    ScrollView {
      VStack {
        Image(update.image)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(maxWidth: .infinity)
        Text(update.text)
          .frame(maxWidth: .infinity, alignment: .leading)
        
      }.padding()
    }.navigationBarTitle(update.title)
  }
}

struct UpdateDetail_Previews: PreviewProvider {
  static var previews: some View {
    UpdateDetail(update: updateData[1])
  }
}
