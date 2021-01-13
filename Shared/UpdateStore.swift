//
//  UpdateStore.swift
//  DesignCode
//
//  Created by Julien Sanchez on 12/01/2021.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject {
  @Published var updates: [Update] = updateData;
}
