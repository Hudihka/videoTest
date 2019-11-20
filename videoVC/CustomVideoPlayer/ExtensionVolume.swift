//
//  ExtensionVolume.swift
//  videoVC
//
//  Created by Username on 20.11.2019.
//  Copyright © 2019 Username. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

extension CustomVideoPlayer {

    //MARK: - Volume

    var audioSession: AVAudioSession {
        return AVAudioSession.sharedInstance()
    }

    private func startTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 1,
                                          target: self,
                                          selector: #selector(CustomVideoPlayer.actionTimer),
                                          userInfo: nil,
                                          repeats: true)
    }


    @objc func actionTimer() {
        if !activeTimer{
            return
        }


        self.time += 1

        print(time)

        if self.time == 3 {
            animateVolumeView(true)
        }
    }



   func addClearSlider(){
        let volumeViewClear = MPVolumeView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        view.addSubview(volumeViewClear)

        volumeView.setProgress(self.audioSession.outputVolume, animated: false)

        colorProgressView(true)
    }

    private func animateVolumeView(_ clear: Bool){
        flagUpdateProgressView = true

        UIView.animate(withDuration: 0.2, animations: {
            self.colorProgressView(clear)
        }) { (coml) in
            if coml {
                self.flagUpdateProgressView = false
                if clear {
                    self.activeTimer = false
                    self.time = 0
                }
            }
        }
    }

    private func colorProgressView(_ clear: Bool){

        let progress = clear ? UIColor.clear : UIColor.white
        let allColor = clear ? UIColor.clear : UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)

        volumeView.progressTintColor = progress
        volumeView.trackTintColor = allColor
    }

    func listenVolumeButton(){

        do{
            try audioSession.setActive(true)
            let vol = audioSession.outputVolume
            print(vol.description) //gets initial volume
        }
        catch{
            print("Error info: \(error)")
        }
        audioSession.addObserver(self, forKeyPath: "outputVolume", options:
            NSKeyValueObservingOptions.new, context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {

            if !flagUpdateProgressView {
                if self.time == 0 {
                    if timer == nil {
                        self.startTimer()
                    }

                    self.activeTimer = true
                    self.time = 0

                    animateVolumeView(false)
                } else {
                    self.time = 0
                }
            }
        


        if keyPath == "outputVolume"{
            let volume = (change?[NSKeyValueChangeKey.newKey] as! NSNumber).floatValue

            let valueVolume = Float(volume.description) ?? self.audioSession.outputVolume
            volumeView.setProgress(valueVolume, animated: true)

        }
    }

}
