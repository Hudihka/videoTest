//
//  CustomVideoPlayer.swift
//  videoVC
//
//  Created by Username on 19.11.2019.
//  Copyright © 2019 Username. All rights reserved.
//

import UIKit
import MediaPlayer

class CustomVideoPlayer: UIViewController {

    let videoManager = ManagerUrlFile.shared
    @IBOutlet weak var videoView: VideoPlayerView!

    @IBOutlet weak var bacgroundView: UIView!


    override func viewDidLoad() {
        super.viewDidLoad()

//        addVolumeProgressView()

//        let  audioSession = AVAudioSession.sharedInstance()
//        let volume : Float = audioSession.outputVolume
//
//        print(volume)

        let volumeView = MPVolumeView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))

        volumeView.isHidden = false
        volumeView.alpha = 1
//
        view.addSubview(volumeView)

    }



    deinit {
        print("deinit")
    }


}
