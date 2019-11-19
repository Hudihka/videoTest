//
//  ViewController.swift
//  videoVC
//
//  Created by Username on 19.11.2019.
//  Copyright © 2019 Username. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func playVideo(_ sender: Any) {
        //        let url = Bundle.main.url(forResource:"toniRayt", withExtension: ".mp4")

        if let path = Bundle.main.path(forResource: "plazma", ofType: "mp4") {
            let url = URL(fileURLWithPath: path)
            let vc = PlayerViewController.route(url: url)

            self.present(vc, animated: true, completion: nil)
        }

    }

}

