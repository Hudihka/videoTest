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


   func addClearSlider(){
        let volumeViewClear = MPVolumeView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        view.addSubview(volumeViewClear)

        volumeView.setProgress(self.audioSession.outputVolume, animated: false)

        colorProgressView(true)
    }

    private func animateVolumeView(_ clear: Bool){

        UIView.animate(withDuration: 0.2, animations: {
            self.colorProgressView(clear)
        }) { (coml) in
            if coml {
                //
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
        }
        catch{
            print("Error info: \(error)")
        }
        audioSession.addObserver(self, forKeyPath: "outputVolume", options:
            NSKeyValueObservingOptions.new, context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {



        print("старт анимация счейчас счетчик равен \(self.counterUpdateVolume)")

        if self.updateVolume {
            self.counterUpdateVolume += 1

            if self.counterUpdateVolume == 1{
                animateVolumeView(false)
            }
        }


        if keyPath == "outputVolume"{
            let volume = (change?[NSKeyValueChangeKey.newKey] as! NSNumber).floatValue

            let valueVolume = Float(volume.description) ?? self.audioSession.outputVolume
            volumeView.setProgress(valueVolume, animated: true)


            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                print("счейчас счетчик равен \(self.counterUpdateVolume)")

                if self.counterUpdateVolume == 1 {
                    self.animateVolumeView(true)
                    self.counterUpdateVolume = 0
                } else if self.counterUpdateVolume > 0{
                    self.counterUpdateVolume -= 1
                }
            }

            //убираем анимац через диспатч задержки
        }
    }

}
