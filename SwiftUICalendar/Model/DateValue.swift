//
//  DateValue.swift
//  SwiftUICalendar
//
//  Created by Sebastian Vidrea on 18.07.2022.
//

import Foundation

struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
