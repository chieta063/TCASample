//
//  SwiftUIView.swift
//
//
//  Created by 阿部紘明 on 2023/12/01.
//

import SwiftUI

struct TabItemView: View {
  let systemImageName: String
  let screenName: String
  
  var body: some View {
    VStack(content: {
      Image(systemName: systemImageName)
      Text(screenName)
    })
  }
}

#Preview {
  TabItemView(systemImageName: "folder.fill", screenName: "Screen1")
}
