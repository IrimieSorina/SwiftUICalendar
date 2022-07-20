//
//  Home.swift
//  SwiftUICalendar
//
//  Created by Sebastian Vidrea on 18.07.2022.
//

import Foundation
import SwiftUI

struct Home: View {
    @State var currentDate: Date = Date()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                YearlyCalendarView(currentDate: $currentDate)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
