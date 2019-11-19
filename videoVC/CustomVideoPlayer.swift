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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

//    static func route(index: Int) -> CustomVideoPlayer {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController = storyboard.instantiateViewController(withIdentifier: "CustomVideoPlayer")
//        let controller = viewController as! CustomVideoPlayer
//
//        return controller
//    }

}
