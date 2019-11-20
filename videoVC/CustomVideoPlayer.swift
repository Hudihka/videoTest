//
//  CustomVideoPlayer.swift
//  videoVC
//
//  Created by Username on 19.11.2019.
//  Copyright © 2019 Username. All rights reserved.
//

import UIKit
import MediaPlayer

enum UpdateVolume{
    case nowClear  //сейчас прозрачная
    case nowShaded //сейчас цветная
    case update    //идет анимация
}




class CustomVideoPlayer: UIViewController {

    let videoManager = ManagerUrlFile.shared
    @IBOutlet weak var videoView: VideoPlayerView!

    @IBOutlet weak var bacgroundView: UIView!


    @IBOutlet weak var volumeView: UIProgressView!
    let audioSession = AVAudioSession.sharedInstance()
    private var flagClearProgressView: UpdateVolume = .nowClear

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.audioSession.outputVolume
//        print(startValue)

//        let volumeView = MPVolumeView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
//        volumeView.isHidden = true
//        view.addSubview(volumeView)

        addClearSlider()

    }

    override func viewWillDisappear(_ animated: Bool) {
        audioSession.removeObserver(self, forKeyPath: "outputVolume")
    }

    override func viewWillAppear(_ animated: Bool) {
        listenVolumeButton()
    }

    //MARK: - Volume


    private func addClearSlider(){
        let volumeViewClear = MPVolumeView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        view.addSubview(volumeViewClear)

        volumeView.setProgress(self.audioSession.outputVolume, animated: false)

        colorProgressView(true)
    }

    private func animateVolumeView(_ newValue: UpdateVolume){
        flagClearProgressView = .update

        UIView.animate(withDuration: 0.2, animations: {

            self.colorProgressView(newValue == .nowClear)
        }) { (coml) in
            self.flagClearProgressView = newValue
        }
    }

    private func colorProgressView(_ clear: Bool){

        let progress = clear ? UIColor.clear : UIColor.white
        let allColor = clear ? UIColor.clear : UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)

        volumeView.progressTintColor = progress
        volumeView.trackTintColor = allColor
    }

    private func listenVolumeButton(){

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

        if self.flagClearProgressView == .nowClear {
            animateVolumeView(.nowShaded)
        } else if self.flagClearProgressView != .update {
            self.flagClearProgressView = .update
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                self.animateVolumeView(.nowClear)
            }
        }


        if keyPath == "outputVolume"{
            let volume = (change?[NSKeyValueChangeKey.newKey] as! NSNumber).floatValue

            let valueVolume = Float(volume.description) ?? self.audioSession.outputVolume
            volumeView.setProgress(valueVolume, animated: true)

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                if self.flagClearProgressView == .nowShaded {
                    self.animateVolumeView(.nowClear)
                }
            }

        }
    }





    deinit {
        NotificationCenter.default.removeObserver(self)
        print("deinit")
    }


}
