//
//  CMTime+Extensions.swift
//  Polymath
//
//  Created by Baher Tamer on 01/09/2023.
//

import AVKit
import Foundation

extension CMTime {
    
    func toString() -> String {
        if CMTimeGetSeconds(self).isNaN {
            return "--:--"
        }
        
        let totalSeconds = Int(CMTimeGetSeconds(self))
        
        let seconds = totalSeconds % 60
        let minutes = totalSeconds % (60 * 60) / 60
        let hours = totalSeconds / 60 / 60
        
        let stringTimeFormat = hours > 0 ? String(format: "%02d:%02d:%02d", hours, minutes, seconds) : String(format: "%02d:%02d", minutes, seconds)
        
        return stringTimeFormat
    }
    
}
