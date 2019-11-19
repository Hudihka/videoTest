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

    var orientationLock = UIInterfaceOrientationMask.all

    override func viewDidLoad() {
        super.viewDidLoad()

        playVideo()
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }

    static func route(url: URL?) -> PlayerViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PlayerViewController")
        let controller = viewController as! PlayerViewController

        controller.urlVideo = url

        return controller
    }

    private func playVideo() {
        if let url = self.urlVideo {
            let player = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.view.bounds
            self.view.layer.addSublayer(playerLayer)
            self.player = player
            player.play()
        }
    }
}
