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

    @IBOutlet weak var minus10Sekonds: UIView!
    @IBOutlet weak var plus10Sekonds: UIView!



    //громкость
    var timer: Timer? = nil
    var time: Float = 0
    var flagUpdateProgressView = true
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

        addGestures()
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
            flagUpdateProgressView = true
            self.player = AVPlayer(url: urlVideo)
            player?.currentItem?.addObserver(self, forKeyPath: "duration", options: [.new, .initial], context: nil)
            addTimeObserver()

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

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.flagUpdateProgressView = false
            }
        }
    }


    func addTimeObserver() {
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        let mainQueue = DispatchQueue.main
        _ = player?.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue, using: { [weak self] time in
            guard let currentItem = self?.player?.currentItem else {return}

            let curentTime = currentItem.currentTime().seconds
            let maxTime = currentItem.duration.seconds

            self?.videoView.updateUI(curentTime: curentTime, maxTime: maxTime)

            if curentTime == maxTime {
                self?.nextTrack(true)
            }

        })
    }







    deinit {
        NotificationCenter.default.removeObserver(self)
        print("deinit")
    }


}


extension CustomVideoPlayer: PlayerDelegate {
    func startSliderdraging(_ value: Bool) {
        if value {
            self.player?.pause()
        } else {
            self.player?.play()
        }
    }

    func playPayse(_ pressPause: Bool) {
        if pressPause {
            self.player?.pause()
        } else {
            self.player?.play()
        }
    }

    func switched(_ next: Bool) {
        self.nextTrack(next)
    }

    func slider(_ value: Float) {

        print("движение")

        guard let player = self.player,
              let duration = player.currentItem?.duration else {return}

        let newTime = Float(duration.value) * value

        let time: CMTime = CMTimeMake(value: Int64(newTime), timescale: 1000)

        player.seek(to: time)

    }


    func nextTrack(_ next: Bool){

        if counter == 0 && !next{
            return
        } else if counter == videoManagerURL.count - 1 && next {
            return
        } else {

            let koef = next ? 1 : -1
            self.counter += koef

            initVideoLauer()

        }
    }


}
