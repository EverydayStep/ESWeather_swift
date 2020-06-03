//
//  ESWeatherCell.swift
//  water_conservancy_ios
//
//  Created by codeLocker on 2019/8/12.
//  Copyright © 2019 codeLocker. All rights reserved.
//

import UIKit
import SnapKit
import ESCategory_swift

public class ESWeatherCell: UICollectionViewCell {
    fileprivate lazy var weatherImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    fileprivate lazy var dateLab : UILabel = {
        let lab = UILabel.init()
        lab.textColor = .white
        lab.font = UIFont.systemFont(ofSize: 13)
        return lab
    }()
    
    fileprivate lazy var temperatureLab : UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 13)
        lab.textColor = .white
        return lab
    }()
    
    fileprivate lazy var weatherLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 13)
        lab.textColor = .white
        return lab
    }()
    
    let weekdays: [String] = ["星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"]
    
    var weather: ESWeatherValue? {
        didSet {
            guard let weather = self.weather else {
                return
            }
            
            let date = Date.es_date(for: weather.date, formatter: "yyyy-MM-dd")
            if date?.es_isSameDay(Date()) ?? false {
                self.dateLab.text = "今天"
            } else {
                guard let week = date?.es_weekday_chinese else {
                    return
                }
                self.dateLab.text = (date?.es_string(formatter: "MM-dd") ?? "") + self.weekdays[week - 1]
            }
            let imageName = "es_weather_" + weather.cond_code_d
            var scale = "@2x"
            if UIScreen.main.scale >= 3.0 {
                scale = "@3x"
            }
            let image = UIImage.es_imageFromBundle(name: imageName + scale, type: "png")
            if let _ = image {
                self.weatherImageView.image = image
            } else {
                self.weatherImageView.image = UIImage.es_imageFromBundle(name: "es_weather_999" + scale, type: "png")
            }
            
            self.temperatureLab.text = weather.tmp_min + "℃" + "~" + weather.tmp_max + "℃"
            self.weatherLab.text = weather.cond_txt_d
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadUI()
        self.layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Load_UI
    private func loadUI() {
        self.contentView.addSubview(self.weatherImageView)
        self.contentView.addSubview(self.dateLab)
        self.contentView.addSubview(self.temperatureLab)
        self.contentView.addSubview(self.weatherLab)
    }
    
    private func layout() {
        self.weatherImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(25)
        }
        self.dateLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.weatherImageView.snp.top).offset(-10)
        }
        self.temperatureLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.weatherImageView.snp.bottom).offset(10)
        }
        self.weatherLab.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.temperatureLab.snp.bottom).offset(10)
        }
    }
}
