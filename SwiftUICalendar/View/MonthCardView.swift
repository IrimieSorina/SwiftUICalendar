//
//  MonthCardView.swift
//  SwiftUICalendar
//
//  Created by Sebastian Vidrea on 19.07.2022.
//

import Foundation
import SwiftUI

struct MonthCardView: View {
    @State var currentDate: Date
    let month: Date
    let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    let showDaysName: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            if showDaysName {
                HStack(spacing: 0) {
                    ForEach(days, id: \.self) { day in
                        Text(day)
                            .font(.callout)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            
            let columns = Array(repeating: GridItem(spacing: 1, alignment: .top), count: 7)
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(extractDate()) { value in
                    CardView(value: value)
                }
            }
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        HStack() {
            if value.day != -1 {
                Text("\(value.day)")
                    .font(showDaysName ? .title3.bold() : .system(size: 9))
                    .fontWeight(.thin)
                    .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
                    .frame(maxWidth: .infinity)
                    .background(Circle()
                                    .fill(.red)
                                    .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0))
                //                        .onTapGesture {
                //                            currentDate = value.date
                //                        }
            }
        }
        .padding(.vertical, showDaysName ? 9 : 0)
        .frame(height: showDaysName ? 60 : 12, alignment: .top) //todo: change the name of the bool 'showDaysName'
    }
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func extractDate() -> [DateValue] {
        let calendar = Calendar.current
        
        var days = month.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0 ..< firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
}
