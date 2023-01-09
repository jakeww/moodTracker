//
//  MoodTracker.swift
//  MoodTracker
//
//  Created by Jake Watembach on 1/7/23.
//

import SwiftUI
import Foundation

struct MoodTracker {
    
    // MARK: - Properties
    
    let calendar = Calendar.current
    let today: Date
    let weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var moods: [String: Int] = [:]
    
    // MARK: - Initialization
    
    init() {
        today = Date()
    }
    
    // MARK: - Methods
    
    mutating func setMood(_ mood: Int, forDay day: Date) {
        let dayString = weekdays[calendar.component(.weekday, from: day) - 1]
        moods[dayString] = mood
        saveMoods()
    }
    
    func getMood(forDay day: Date) -> Int? {
        let dayString = weekdays[calendar.component(.weekday, from: day) - 1]
        return moods[dayString]
    }
    
    func saveMoods() {
        // Save moods to user's profile
    }
}


struct MoodTrackerView: View {
    
    @State private var moodTracker = MoodTracker()
 // Create instance of MoodTracker
    @State private var selectedMood: Int?
    
    var body: some View {
        VStack {
            // Grid of 7 days
            ForEach(0..<7, id: \.self) { index in
                HStack {
                    Button(action: {
                        // Set mood for current day
                        let currentDay = self.moodTracker.today.advanced(by: TimeInterval(86400 * index))

                        if let mood = self.selectedMood {
                            self.moodTracker.setMood(mood, forDay: currentDay)  // Call setMood(_:forDay:) on moodTracker instance
                        }
                    }) {
                        Text("\(self.moodTracker.weekdays[index])")
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    // Display mood for current day
                    if let mood = self.moodTracker.getMood(forDay: self.moodTracker.today.advanced(by: TimeInterval(86400 * index))) {
 // Call getMood(forDay:) on moodTracker instance
                        Text("\(mood)")
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            // Mood selection
            Picker(selection: $selectedMood, label: Text("Mood")) {
                ForEach(1..<6, id: \.self) { index in
                    Text("\(index)").tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .padding()
    }
}


struct MoodTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        MoodTrackerView()
    }
}

