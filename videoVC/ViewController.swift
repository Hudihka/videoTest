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
        if let path = Bundle.main.path(forResource: "plazma", ofType: "mp4") {
            let url = URL(fileURLWithPath: path)
            let vc = PlayerViewController.route(url: url, urlArray: nil)

            self.present(vc, animated: true, completion: nil)
        }

    }

    @IBAction func playAll(_ sender: Any) {

        let arrayName = ["guano", "toniRayt", "plazma"]
        var arrayUrl = [URL]()

        for obj in arrayName {
            if let path = Bundle.main.path(forResource: obj, ofType: "mp4") {
                let url = URL(fileURLWithPath: path)
                arrayUrl.append(url)
            }
        }

        let vc = PlayerViewController.route(url: nil, urlArray: arrayUrl)

        self.present(vc, animated: true, completion: nil)


    }


}

