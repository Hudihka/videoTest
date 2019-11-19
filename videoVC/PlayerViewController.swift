//
//  PlayerViewController.swift
//  GinzaGO
//
//  Created by Username on 31.07.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import UIKit
import AVKit

class PlayerViewController: AVPlayerViewController {
    var urlVideo: URL?

    //если видео несколько
    var urlVideoArray: [URL]?
    var playInfdex = 0

    var orientationLock = UIInterfaceOrientationMask.all

    override func viewDidLoad() {
        super.viewDidLoad()

        if let urlVideo = self.urlVideo{
            playVideo(url: urlVideo)
        } else if let array = urlVideoArray {
            openArray(urlArray: array)
        }

    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }

    static func route(url: URL?, urlArray: [URL]?, index: Int = 0) -> PlayerViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PlayerViewController")
        let controller = viewController as! PlayerViewController

        controller.urlVideo = url
        controller.urlVideoArray = urlArray
        controller.playInfdex = index

        return controller
    }

    private func playVideo(url: URL) {
        let player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        if self.urlVideoArray != nil {
            player.allowsExternalPlayback = true
        }
        
        self.view.layer.addSublayer(playerLayer)
        self.player = player
        player.play()
    }

    private func openArray(urlArray: [URL]) {
        let url = urlArray[playInfdex]
        playVideo(url: url)
    }
}
