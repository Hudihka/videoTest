//
//  CustomVideoPlayer.swift
//  videoVC
//
//  Created by Username on 19.11.2019.
//  Copyright © 2019 Username. All rights reserved.
//

import UIKit
import AVKit

class CustomVideoPlayer: UIViewController {

    let videoManagerURL = ManagerUrlFile.shared.URLFile
    @IBOutlet weak var videoView: VideoPlayerView!

    @IBOutlet weak var bacgroundView: UIView!


    @IBOutlet weak var volumeView: UIProgressView!


    //громкость
    var timer: Timer? = nil
    var time: Float = 0
    var flagUpdateProgressView = false
    var activeTimer = true

    //видео

    var counter = 0

    var videoLayer: AVPlayerLayer?
    var player: AVPlayer?

    var urlVideo: URL {
        return videoManagerURL[self.counter]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addClearSlider()

        initVideoLauer()

        videoView.delegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        audioSession.removeObserver(self, forKeyPath: "outputVolume")
        timer?.invalidate()
    }

    override func viewWillAppear(_ animated: Bool) {
        listenVolumeButton()
    }


    func initVideoLauer(){
        if !videoManagerURL.isEmpty{
            self.player = AVPlayer(url: urlVideo)

            if let layerVideo = self.videoLayer {
                layerVideo.player = self.player
            } else {

                self.videoLayer = AVPlayerLayer(player: player)
                videoLayer?.frame = CGRect(origin: CGPoint.zero, size: bacgroundView.frame.size)

                if let videoLayer = videoLayer{
                    self.bacgroundView.layer.addSublayer(videoLayer)
                }
            }

            self.player?.play()
        }
    }


//    func hughhugyug(){
//        let player = AVPlayer(url: url)
//        let playerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = self.view.bounds
//        self.view.layer.addSublayer(playerLayer)
//        self.player = player
//        player.play()
//    }






    deinit {
        NotificationCenter.default.removeObserver(self)
        print("deinit")
    }


}


extension CustomVideoPlayer: PlayerDelegate {
    func playPayse(_ pressPause: Bool) {
        if pressPause {
            self.player?.pause()
        } else {
            self.player?.play()
        }
    }

    func switched(_ next: Bool) {
        if counter == 0 && !next{
            return
        } else if counter == videoManagerURL.count - 1 && next {
            return
        } else {

            let koef = next ? 1 : -1
            self.counter += koef

            initVideoLauer()

//            let url = videoManagerURL[counter]
            //начать воспроизведение нового файла

        }
    }

    func slider(_ value: Float) {
        ////
    }


}
