//
//  ESWeatherView.swift
//  water_conservancy_ios
//
//  Created by codeLocker on 2019/8/11.
//  Copyright © 2019 codeLocker. All rights reserved.
//

import UIKit
import ESCategory_swift

public struct ESWeatherConfig {
    /// 接口地址
    var url: String = "https://free-api.heweather.com/s6/weather/forecast"
    /// 城市代码
    var cityCode: String = "CN101210301"
    /// 接口key
    var keys: [String] = ["720b3dbddc5c4d6391b0ae457cfede34", "fcd6cf466aa64d52b2577578c26aeab7", "10de6ec03cea4938a7bfe4dd4ce00e94", "275bfd7bb4e344dfaaa27315fdd9a186", "477210d57370499caea971e4efdcdf44", "fee7141b24c647e7a918017889490307", "e78e9e23a1c3449d95926abb2b531cd0"]
    /// 天气Item的Size
    var height: CGFloat = 300
    /// 标题高度
    var titleHeight: CGFloat = 50
}

public class ESWeatherView: UIView {

    fileprivate lazy var titleView : UIView = {
        let view = UIView()
        return view
    }()
    
    fileprivate lazy var titleLab : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize.init(width: UIScreen.es_width / 3.0, height: self.config.height - self.config.titleHeight)
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self as UICollectionViewDelegate
        collectionView.dataSource = self as UICollectionViewDataSource
        collectionView.register(ESWeatherCell.self, forCellWithReuseIdentifier: String(describing: ESWeatherCell.self))
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    fileprivate lazy var backgroundImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.es_imageFromBundle(name: "es_weather_na", type: "jpg")
        return imageView
    }()
    
    fileprivate var weather: ESWeather?
    fileprivate var weather_key_index: Int = 0
    fileprivate var config: ESWeatherConfig = ESWeatherConfig()
    
    var title: String? {
        didSet {
            self.titleLab.text = self.title
        }
    }
    
    var titleFont: UIFont? {
        didSet {
            self.titleLab.font = self.titleFont
        }
    }
    
    var titleColor: UIColor? {
        didSet {
            self.titleLab.textColor = self.titleColor
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadUI()
        self.layout()
        self.network_weather()
    }
    
    public init(frame: CGRect, config: ESWeatherConfig) {
        super.init(frame: frame)
        self.config = config
        self.loadUI()
        self.layout()
        self.network_weather()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Load_UI
    private func loadUI() {
        self.addSubview(self.backgroundImageView)
        self.addSubview(self.titleView)
        self.titleView.addSubview(self.titleLab)
        self.addSubview(self.collectionView)
        
    }
    
    private func layout() {
        self.titleView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(self.config.titleHeight)
        }
        self.titleLab.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(16)
        }
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.titleView.snp.bottom)
        }
        self.backgroundImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: - UICollectionViewDataSource && UICollectionViewDelegate
extension ESWeatherView : UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.weather?.daily_forecast.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ESWeatherCell.self), for: indexPath) as? ESWeatherCell else {
            return ESWeatherCell()
        }
        cell.weather = self.weather?.daily_forecast[indexPath.row]
        return cell
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

//MARK: - Private_Methods
extension ESWeatherView {
    func configBackgroundImageView() {
        guard let weather = self.weather?.daily_forecast.first else {
            return
        }
        var imageName: String = ""
        switch Int(weather.cond_code_d) {
        case 100, 103, 900:
            imageName = "es_weather_sunny"
        case 101, 102, 201, 202, 203, 204:
            imageName = "es_weather_cloudy"
        case 500, 501:
            imageName = "es_weather_fog"
        case 502:
            imageName = "es_weather_haze"
        case 104, 205, 206, 207, 208, 209, 210, 211, 212, 213:
            imageName = "es_weather_overcast"
        case 200, 300, 301, 305, 306, 307, 308, 309, 310, 311, 312:
            imageName = "es_weather_rain"
        case 503, 504, 507, 508:
            imageName = "es_weather_sand"
        case 313, 400, 401, 402, 403, 404, 405, 406, 407, 901:
            imageName = "es_weather_snow"
        case 302, 303, 304:
            imageName = "es_weather_thunder"
        case 999:
            imageName = "es_weather_na"
        default:
            imageName = "es_weather_na"
        }
        
        self.backgroundImageView.image = UIImage.es_imageFromBundle(name: imageName, type: "jpg")
    }
}

//MARK: - Network_Methods
extension ESWeatherView {
    
    func network_weather() {
        if self.weather_key_index >= self.config.keys.count {
            print("key全部失效")
            return
        }
        let params = "location=\(self.config.cityCode)" + "&" + "key=\(self.self.config.keys[self.weather_key_index])"
        guard let url = URL.init(string: self.config.url + "?" + params) else {
            print("天气接口地址不正确")
            return
        }
        let request = URLRequest.init(url: url)

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                print("error: \(error?.localizedDescription ?? "")")
                self.weather_key_index += 1
                self.network_weather()
                return
            }
            guard let json = data?.es_dictionary() else {
                print("天气接口数据字典转换失败")
                return
            }
            
            guard let value = json["HeWeather6"] as? [Any], value.count > 0 else {
                print("天气接口数据为空")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            guard let jsonData = try? JSONSerialization.data(withJSONObject: value.first!, options: []) else {
                return
            }
            guard let model = try? jsonDecoder.decode(ESWeather.self, from: jsonData) else {
                print("天气接口数据模型转换失败")
                return
            }
            DispatchQueue.main.async {
                self.weather = model
                self.collectionView.reloadData()
                self.configBackgroundImageView()
            }
        }
        
        task.resume()
    }
}
