//
//  ManagerUrlFile.swift
//  videoVC
//
//  Created by Username on 19.11.2019.
//  Copyright © 2019 Username. All rights reserved.
//

import Foundation


class ManagerUrlFile: NSObject{

    static let shared = ManagerUrlFile()

    var URLFile: [URL] {

        let arrayName = ["toniRayt", "guano", "plazma"]
        var arrayUrl = [URL]()

        for obj in arrayName {
            if let path = Bundle.main.path(forResource: obj, ofType: "mp4") {
                let url = URL(fileURLWithPath: path)
                arrayUrl.append(url)
            }
        }

        return arrayUrl

    }


}
