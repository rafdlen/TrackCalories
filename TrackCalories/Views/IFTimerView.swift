//
//  IFTimerView.swift
//  TrackCalories
//
//  Created by Rafal on 23/08/2022.
//

import Foundation
import SwiftUI

struct IFTimer: View {
    
    @State var defaultTimeRemaining = 16*60*60
    @State var timeRemaining = 16*60*60
    @State private var isActive = false

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 25) {
            ZStack {
                Text("\(timeString(time: timeRemaining))")
                    .font(.system(size: 60))
                    .frame(height: 80.0)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .onReceive(timer){ _ in
                        if self.timeRemaining > 0 {
                            self.timeRemaining -= 1
                        }else{
                            self.timer.upstream.connect().cancel()
                        }
                    }
            
            HStack(spacing: 25) {
                Label("\(isActive ? "Pause" : "Play")", systemImage: "\(isActive ? "pause.fill" : "play.fill")").foregroundColor(isActive ? .red : .yellow).font(.title).onTapGesture(perform: {
                    isActive.toggle()
                })
                
                Label("Resume", systemImage: "backward.fill").foregroundColor(.black).font(.title).onTapGesture(perform: {
                    isActive = false
                    timeRemaining = defaultTimeRemaining
                })
            }
        }.onReceive(timer, perform: { _ in
            guard isActive else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                isActive = false
                timeRemaining = defaultTimeRemaining
            }
        })
    }
        
    func timeString(time: Int) -> String {
        let hours   = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        }
    }
}
    
    
    
    
struct IFTimer_Previews: PreviewProvider {
    static var previews: some View {
       IFTimer()
    }
}
