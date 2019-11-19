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

        let vc = PlayerViewController.route(index: 0)

        self.present(vc, animated: true, completion: nil)

    }

    @IBAction func playAll(_ sender: Any) {

        let vc = PlayerViewController.route(index: 1)

        self.present(vc, animated: true, completion: nil)

    }


}

