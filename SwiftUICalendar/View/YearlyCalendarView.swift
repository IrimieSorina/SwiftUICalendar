//
//  ContentView.swift
//  SwiftUICalendar
//
//  Created by Sebastian Vidrea on 15.07.2022.
//

import Foundation
import SwiftUI

struct YearlyCalendarView: View {
    @Binding var currentDate: Date
    @State var currentYear: Int = 0
    
    var body: some View {
        //Home()
        VStack(spacing: 35) {
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(extraDate()[0])
                        .font(.title.bold())
                }
                
                Spacer(minLength: 0)
                
                Button {
                    withAnimation {
                        currentYear -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                Button {
                    withAnimation {
                        currentYear += 1
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
            }
            .padding(.horizontal)
        }
        .onChange(of: currentYear) { newValue in
            currentDate = getCurrentYear()
        }
        
        let columns = Array(repeating: GridItem(alignment: .top), count: 3)
        LazyVGrid(columns: columns, spacing: 15) {
            ForEach(Array(getAllTheMonths().enumerated()), id: \.element) { index, month in
                VStack(alignment: .leading) {
                    Text("\(month)")
                        .font(.system(size: 16).bold())
                    
                    MonthCardView(currentDate: currentDate, month: getDateFrom(month: index), showDaysName: false)
                }.padding(8)
            }
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        VStack {
            if value.day != -1 {
                Text("\(value.day)")
                    .font(.title3.bold())
            }
        }
        .padding(.vertical, 8)
        .frame(height: 60, alignment: .top)
    }
    
    func extraDate() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }

    func getCurrentYear() -> Date {
        let calendar = Calendar.current
        
        guard let currentYear = calendar.date(byAdding: .year, value: self.currentYear, to: Date()) else {
            return Date()
        }
        
        return currentYear
    }
    
    func getDateFrom(month: Int) -> Date {
        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!

        var dateComponents = DateComponents()
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: getCurrentYear())
        let year = components.year
        
        dateComponents.year = year
        dateComponents.month = month + 1

        let date = gregorianCalendar.date(from: dateComponents)!
        return date
    }
    
    func getAllTheMonths() -> [String] {
        var allMonths = [String]()
        let formatter = DateFormatter()
        for month in 0..<12 {
            allMonths.append(formatter.shortMonthSymbols[month])
        }
        
        return allMonths
    }
}



struct YearlyCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 8")
    }
}
