import Foundation

extension Date{
    func getDayMonthYearAndHour() -> (day: Int, month: Int, year: Int, hour: Int, minute: Int){
        let calendar = Calendar.current
        let day = calendar.component(.day, from: self)
        let month = calendar.component(.month, from: self)
        let year = calendar.component(.year, from: self)
        let hour = calendar.component(.hour, from: self)
        let minute = calendar.component(.minute, from: self)
        return (day, month, year, hour, minute)
    }
}
