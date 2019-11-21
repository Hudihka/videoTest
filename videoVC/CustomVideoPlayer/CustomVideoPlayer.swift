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


    var sizeLayer: CGRect {
        let portraitOrientation = UIDevice.current.orientation.isPortrait

        let point = portraitOrientation ? CGPoint(x: 0.0, y: 93) : CGPoint.zero
        let size = portraitOrientation ? CGSize(width: SupportClass.Dimensions.wDdevice, height: SupportClass.Dimensions.wDdevice)
                                       : CGSize(width: SupportClass.Dimensions.hDdevice, height: SupportClass.Dimensions.wDdevice)

        return CGRect(origin: point, size: size)
    }



    var urlVideo: URL {
        return videoManagerURL[self.counter]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        bacgroundView.frame = self.sizeLayer
//        videoLayer?.frame = CGRect(origin: CGPoint.zero, size: sizeLayer.size)
//        minusOrPlusFrame()

        addClearSlider()

        initVideoLauer()

        videoView.delegate = self

        addGestures()

        //сообщает что большеустройство повернуто
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(rotated),
                                               name: UIDevice.orientationDidChangeNotification,
                                               object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        audioSession.removeObserver(self, forKeyPath: "outputVolume")
        timer?.invalidate()


        if (self.isMovingFromParent) {
            UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        listenVolumeButton()

        let value = UIInterfaceOrientationMask.all.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")

        bacgroundView.frame = self.sizeLayer
        videoLayer?.frame = CGRect(origin: CGPoint.zero, size: sizeLayer.size)
        minusOrPlusFrame()
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
                videoLayer?.frame = CGRect(origin: CGPoint.zero, size: sizeLayer.size)

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


    //MARK: - Two orientation

    @objc func canRotate () -> Void {}//благодаря этому селектору вращается этот экран


    @objc func rotated() {
        bacgroundView.frame = self.sizeLayer
        videoLayer?.frame = CGRect(origin: CGPoint.zero, size: sizeLayer.size)
        minusOrPlusFrame()


        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
        } else {
            print("Portrait")
        }

    }

    private func minusOrPlusFrame(){

        let sizeWidth = self.sizeLayer.size.width * 2/5
        let sizeHeight = self.sizeLayer.size.height

        let originMunus = CGPoint.zero
        let originPlus = CGPoint(x: self.sizeLayer.size.width * 3/5, y: 0)

        self.minus10Sekonds.frame = CGRect(origin: originMunus, size: CGSize(width: sizeWidth, height: sizeHeight))
        self.plus10Sekonds.frame = CGRect(origin: originPlus, size: CGSize(width: sizeWidth, height: sizeHeight))

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
