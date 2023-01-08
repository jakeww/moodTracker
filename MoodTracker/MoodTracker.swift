//
//  MoodTracker.swift
//  MoodTracker
//
//  Created by Jake Watembach on 1/7/23.
//

import SwiftUI

struct MoodTracker: View {
    let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    let moodIcons = ["😀", "😐", "😔", "😠", "😴"]  // you can customize these to match your app's moods
    var moods: [Int: Int] = [:]  // this dictionary will store the moods and dates

    var body: some View {
        VStack {
            Text("Mood Tracker")
                .font(.title)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<7, id: \.self) { day in
                        Button(action: {
                            // update the moods dictionary with the current mood and date
                            let calendar = Calendar.current
                            let currentDate = Date()
                            let date = calendar.date(byAdding: .day, value: day, to: currentDate)!

                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd"
                            let dateString = formatter.string(from: date)

                            self.moods[day] = 0  // you can replace 0 with the current mood index
                        },
                        label: {
                            // show the mood icon if it exists, or a placeholder if it doesn't
                            if let mood = self.moods[day] {
                                Text(self.moodIcons[mood])
                                    .font(.system(size: 50.0))
                                    .padding(.all, 20.0)  // remove the return keyword here
                            } else {
                                Text(" ")
                                    .padding()  // remove the return keyword here
                            }
                        })


                        .background(Color.white)
                        .foregroundColor(Color.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 2)
                        )
                    }
                }
                .padding([.leading, .bottom, .trailing])
            }
        }.padding(.vertical).background(Color.gray)
    }
}


struct MoodTracker_Previews: PreviewProvider {
    static var previews: some View {
        MoodTracker()
    }
}
