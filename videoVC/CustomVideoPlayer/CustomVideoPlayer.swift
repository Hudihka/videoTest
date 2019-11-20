//
//  CustomVideoPlayer.swift
//  videoVC
//
//  Created by Username on 19.11.2019.
//  Copyright © 2019 Username. All rights reserved.
//

import UIKit



class CustomVideoPlayer: UIViewController {

    let videoManager = ManagerUrlFile.shared
    @IBOutlet weak var videoView: VideoPlayerView!

    @IBOutlet weak var bacgroundView: UIView!


    @IBOutlet weak var volumeView: UIProgressView!

    var timer: Timer? = nil
    var time: Float = 0
    var flagUpdateProgressView = false
    var activeTimer = true


    override func viewDidLoad() {
        super.viewDidLoad()

        addClearSlider()

    }

    override func viewWillDisappear(_ animated: Bool) {
        audioSession.removeObserver(self, forKeyPath: "outputVolume")
        timer?.invalidate()
    }

    override func viewWillAppear(_ animated: Bool) {
        listenVolumeButton()
    }




    deinit {
        NotificationCenter.default.removeObserver(self)
        print("deinit")
    }


}
