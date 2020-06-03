//
//  ViewController.swift
//  ESWeather_swift
//
//  Created by codeLocker on 2020/6/1.
//  Copyright © 2020 codeLocker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = ESWeatherView.init(frame: .zero, config: ESWeatherConfig.init(height: 300))
        view.title = "suzhou"
        self.view.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(300)
        }
        // Do any additional setup after loading the view.
    }


}

