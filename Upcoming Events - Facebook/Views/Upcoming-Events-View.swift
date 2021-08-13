//
//  Upcoming-Events-View.swift
//  Upcoming Events - Facebook
//
//  Created by Kody Young on 8/12/21.
//

import SwiftUI

struct PostView: View{
    
    let items = DataProvider.eventList
    
    let columns = [
        GridItem(.fixed(UIScreen.main.bounds.size.width))
    ]

    var body: some View {

    ScrollView(.vertical, showsIndicators: false) {
        ForEach(items, id: \.self) { item in
            LazyVGrid(columns: columns, alignment: .center) {

                ZStack(){
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color.blue)
                        .frame(width: UIScreen.main.bounds.width - 15, height: 100)

                    HStack(){
                
                        Text(item.title).font(.system(size: 14, weight: .bold, design: .default)).padding(.leading).foregroundColor(Color.black).padding(.leading)

                        Text(item.start).font(.system(size: 14, weight: .semibold, design: .default)).frame(maxWidth: .infinity, alignment: .leading).foregroundColor(Color.white).padding(.leading)
                
                        Text(item.end).font(.system(size: 14, weight: .semibold, design: .default)).frame(maxWidth: .infinity, alignment: .leading).foregroundColor(Color.white).padding(.trailing)
                
                        }.padding(.bottom, 2)
                    }
                }
            }
        }
    }
}
