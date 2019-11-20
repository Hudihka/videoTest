//
//  ExtensionGestures.swift
//  videoVC
//
//  Created by Username on 20.11.2019.
//  Copyright © 2019 Username. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

extension CustomVideoPlayer {

    func addGestures(){
        self.minus10Sekonds.addGestureRecognizer(setGestureRecognizer())
        self.plus10Sekonds.addGestureRecognizer(setGestureRecognizer())
    }

    private func setGestureRecognizer() -> UITapGestureRecognizer {
        let doubleGesters = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleGesters.numberOfTapsRequired = 2
        return doubleGesters
    }


    @objc func handleDoubleTap(sender: UITapGestureRecognizer) {

        if sender.view == self.minus10Sekonds{
            plusOrMinus10Seconds(false)
        } else if sender.view == self.plus10Sekonds {
            plusOrMinus10Seconds(true)
        }
    }


    private func plusOrMinus10Seconds(_ plus: Bool){
        guard let player = self.player,
            let duration = player.currentItem?.duration else {return}

        let time = plus ? 10.0 : -10.0
        let newDurationSeconds = player.currentTime().seconds + time

        if newDurationSeconds < 0{
            let time: CMTime = CMTimeMake(value: Int64(0), timescale: 1000)
            player.seek(to: time)
        } else if newDurationSeconds >= duration.seconds {
            self.nextTrack(true)
        } else {
            let time: CMTime = CMTimeMake(value: Int64(newDurationSeconds), timescale: 1)
            player.seek(to: time)
        }
    }

}


