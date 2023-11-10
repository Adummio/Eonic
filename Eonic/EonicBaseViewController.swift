//
//  EonicBaseViewController.swift
//  Eonic
//
//  Created by Antonio Ferraioli on 03/12/20.
//  Copyright © 2020 Antonio Ferraioli. All rights reserved.
//

//import Foundation
//import UIKit
//
//
//public var caricamento = Bool()
//public var iniziale = true
//
//class EonicBaseViewController: UIViewController{
//
    // ACTIVITY INDICATOR
    
//    var container: UIView = UIView()
//    var loadingView: UIView = UIView()
//    let imageView = UIImageView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
    
    // METHODS
    
//    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
//        gradientLayer.locations = [0.6, 1.0]
//        gradientLayer.frame = self.view.bounds
//        self.view.layer.insertSublayer(gradientLayer, at:0)
//    }
//
//    func showAlert(title:String, msg:String) {
//        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
//
//        }))
//        self.present(alert, animated: true, completion: nil)
//    }
    
//    func showActivityIndicator() {
//        caricamento = true
//        self.container.frame = self.view.frame
//        self.container.center = self.view.center
//        self.container.backgroundColor = UIColor.blue.withAlphaComponent(0.0)
//        
//        self.loadingView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
//        self.loadingView.center = self.view.center
//        self.loadingView.clipsToBounds = true
////        let gradientLayer = CAGradientLayer()
////        gradientLayer.colors = [CGColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)),CGColor(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))]
////        gradientLayer.frame = self.view.bounds
////        loadingView.layer.insertSublayer(gradientLayer, at: 0)
//        let immagine = UIImage(named: "Artboard 56Lounch Screen")
//        let immagineBackground = UIImageView(image: immagine)
//        immagineBackground.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
//        
//        let logo = UIImage(named: "assetlogo")
//        let logoBackground = UIImageView(image: logo)
//        logoBackground.frame = CGRect(x: 0, y: 0, width: 46, height: 63)
//        logoBackground.center = self.view.center
//        
//        let scrittaEonic = UILabel()
//        scrittaEonic.text = "Eonic"
//        scrittaEonic.frame = CGRect(x: 0, y: 0, width: 54, height: 26)
//        scrittaEonic.center = CGPoint(x: self.view.center.x, y: logoBackground.frame.maxY + 25)
//        scrittaEonic.textAlignment = NSTextAlignment.center
//        scrittaEonic.textColor = .white
//        scrittaEonic.font = UIFont.boldSystemFont(ofSize: 21)
//        
//        let scrittaInfo = UILabel()
//        scrittaInfo.text = "Eonic is looking to the\nnearest charging station to you."
//        scrittaInfo.frame = CGRect(x: 0, y: 0, width: 308, height: 59)
//        scrittaInfo.center = CGPoint(x: self.view.center.x, y: logoBackground.frame.maxY + 40)
//        scrittaInfo.textAlignment = NSTextAlignment.center
//        scrittaInfo.textColor = .white
//        scrittaInfo.numberOfLines = 2
//        scrittaInfo.font = UIFont.boldSystemFont(ofSize: 21)
//        scrittaInfo.alpha = 0
//        
//        let scrittaInfo2 = UILabel()
//        scrittaInfo2.text = "The research will take a few seconds."
//        scrittaInfo2.frame = CGRect(x: 0, y: 0, width: 390, height: 19)
//        scrittaInfo2.center = CGPoint(x: self.view.center.x, y: self.view.frame.maxY - 50)
//        scrittaInfo2.textAlignment = NSTextAlignment.center
//        scrittaInfo2.textColor = .white
//        scrittaInfo2.font = UIFont.systemFont(ofSize: 16)
//        scrittaInfo2.alpha = 0
//        
////        let imageData = try? Data(contentsOf: Bundle.main.url(forResource: "gifLoading", withExtension: "gif")!)
////        let advTimeGif = UIImage.gifImageWithData(imageData!)
////        let gifLoading = UIImageView(image: advTimeGif)
////        gifLoading.frame = CGRect(x: 20.0, y: 220.0, width: self.view.frame.size.width - 40, height: 150.0)
//
//        imageView.animationImages = [
//            UIImage(named: "3_Frame")!,
//            UIImage(named: "4_Frame")!,
//            UIImage(named: "5_Frame")!,
//            UIImage(named: "6_Frame")!,
//            UIImage(named: "7_Frame")!,
//            UIImage(named: "8_Frame")!,
//            UIImage(named: "9_Frame")!,
//            UIImage(named: "10_Frame")!,
//            UIImage(named: "11_Frame")!,
//            UIImage(named: "12_Frame")!,
//            UIImage(named: "13_Frame")!,
//            UIImage(named: "14_Frame")!,
//            UIImage(named: "15_Frame")!,
//            UIImage(named: "16_Frame")!,
//            UIImage(named: "17_Frame")!,
//            UIImage(named: "18_Frame")!,
//            UIImage(named: "19_Frame")!,
//            UIImage(named: "20_Frame")!,
//            UIImage(named: "21_Frame")!,
//            UIImage(named: "22_Frame")!,
//            UIImage(named: "23_Frame")!,
//            UIImage(named: "24_Frame")!,
//            UIImage(named: "25_Frame")!,
//            UIImage(named: "26_Frame")!,
//            UIImage(named: "27_Frame")!,
//            UIImage(named: "28_Frame")!,
//            UIImage(named: "29_Frame")!,
//            UIImage(named: "30_Frame")!,
//            UIImage(named: "31_Frame")!,
//            UIImage(named: "32_Frame")!,
//            UIImage(named: "33_Frame")!,
//            UIImage(named: "34_Frame")!,
//            UIImage(named: "35_Frame")!,
//            UIImage(named: "36_Frame")!,
//            UIImage(named: "37_Frame")!,
//            UIImage(named: "38_Frame")!,
//            UIImage(named: "39_Frame")!,
//            UIImage(named: "40_Frame")!,
//            UIImage(named: "41_Frame")!,
//            UIImage(named: "42_Frame")!,
//            UIImage(named: "43_Frame")!,
//            UIImage(named: "44_Frame")!,
//            UIImage(named: "45_Frame")!,
//            UIImage(named: "46_Frame")!,
//            UIImage(named: "47_Frame")!,
//            UIImage(named: "48_Frame")!,
//            UIImage(named: "49_Frame")!,
//            UIImage(named: "50_Frame")!,
//            UIImage(named: "51_Frame")!,
//            UIImage(named: "52_Frame")!,
//            UIImage(named: "53_Frame")!,
//            UIImage(named: "54_Frame")!,
//            UIImage(named: "55_Frame")!,
//            UIImage(named: "56_Frame")!,
//            UIImage(named: "57_Frame")!,
//            UIImage(named: "58_Frame")!,
//            UIImage(named: "59_Frame")!,
//            UIImage(named: "60_Frame")!,
//            UIImage(named: "61_Frame")!,
//            UIImage(named: "62_Frame")!,
//            UIImage(named: "63_Frame")!,
//            UIImage(named: "64_Frame")!,
//            UIImage(named: "65_Frame")!,
//            UIImage(named: "66_Frame")!,
//            UIImage(named: "67_Frame")!,
//            UIImage(named: "68_Frame")!,
//            UIImage(named: "69_Frame")!,
//            UIImage(named: "70_Frame")!,
//            UIImage(named: "71_Frame")!,
//            UIImage(named: "72_Frame")!,
//            UIImage(named: "73_Frame")!,
//            UIImage(named: "74_Frame")!,
//            UIImage(named: "75_Frame")!,
//            UIImage(named: "76_Frame")!,
//            UIImage(named: "77_Frame")!,
//            UIImage(named: "78_Frame")!,
//            UIImage(named: "79_Frame")!,
//            UIImage(named: "80_Frame")!,
//            UIImage(named: "81_Frame")!,
//            UIImage(named: "82_Frame")!,
//            UIImage(named: "83_Frame")!,
//            UIImage(named: "84_Frame")!,
//            UIImage(named: "85_Frame")!,
//            UIImage(named: "86_Frame")!,
//            UIImage(named: "87_Frame")!,
//            UIImage(named: "88_Frame")!,
//            UIImage(named: "89_Frame")!,
//            UIImage(named: "90_Frame")!
//        ]
//
//        imageView.animationDuration = 3
//        imageView.animationRepeatCount = .max
//        imageView.center = self.view.center
//        imageView.frame = CGRect(x: self.view.center.x - 30, y: self.view.center.y + 200, width: 60, height: 37.25)
//        
////        self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
////        self.activityIndicator.style = UIActivityIndicatorView.Style.large
////        self.activityIndicator.color = .white
////        self.activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
//        
//        self.loadingView.addSubview(immagineBackground)
//        self.loadingView.addSubview(imageView)
//        self.loadingView.addSubview(logoBackground)
//        self.loadingView.addSubview(scrittaEonic)
//        self.loadingView.addSubview(scrittaInfo)
//        self.loadingView.addSubview(scrittaInfo2)
//        self.container.addSubview(self.loadingView)
//        print(delegate as Any)
//        delegate.showLoading()
////        let prova = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as? MapViewController
////        prova?.view.insertSubview(self.container, at: 9)
////        self.view.insertSubview(self.container, at: 9)
//        self.imageView.startAnimating()
//        UIView.animate(withDuration: 3){
//            logoBackground.transform = CGAffineTransform(translationX: 0, y: -8)
//            logoBackground.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
//            scrittaInfo.transform = CGAffineTransform(translationX: 0, y: -8)
//        }
//        scrittaEonic.alpha = 0
//        scrittaInfo.alpha = 1
//        scrittaInfo2.alpha = 1
////        self.activityIndicator.startAnimating()
//    }
    
//    public func hideActivityIndicator() {
//        self.imageView.stopAnimating()
////        self.activityIndicator.stopAnimating()
//        self.container.removeFromSuperview()
//        caricamento = false
//        if iniziale == true{
//            iniziale = false
//        }
//    }
    
//}
