//
//  CardViewController.swift
//  Colonnine
//
//  Created by Yuri Spaziani on 22/02/2020.
//  Copyright © 2020 Antonio Ferraioli. All rights reserved.
//

import UIKit
import MapKit
protocol cardController{
    func animateTransitionIfNeeded(state:CardState, duration:TimeInterval)
    func animateSearchTransitionIfNeeded(state:CardState, duration:TimeInterval)
    var detailState: String { get }
    var detailCardVisible: Bool { get set }
    var searchCardVisible: Bool { get set }
    var nextDetailState:CardState { get }
    var nextDetailState2:CardState { get }
    var nextSearchState2:CardState { get }
}
//public var arrImages: [UIImage] = []

class CardViewController: UIViewController, UIScrollViewDelegate{
    
    var delegate:cardController!

    var frame = CGRect(x:0, y:0, width:0, height:0)
    @IBOutlet weak var scrViewTotale: UIScrollView!
    
    @IBOutlet var backgroudArea: UIView!
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var lineatop: UIView!
    @IBOutlet weak var linea3: UIView!
    
    @IBOutlet weak var vaiColonnina2: UIButton!
    @IBOutlet weak var faiChiamata2: UIButton!
    @IBOutlet weak var faiCondividi2: UIButton!
    @IBOutlet weak var plugButton1: UIButton!
    @IBOutlet weak var plugButton2: UIButton!
    @IBOutlet weak var plugButton3: UIButton!
    @IBOutlet weak var plugButton4: UIButton!
    @IBOutlet weak var plugButton5: UIButton!
    @IBOutlet weak var plugButton6: UIButton!
    @IBOutlet weak var plugButton7: UIButton!
    @IBOutlet weak var plugButton8: UIButton!
    
    @IBOutlet weak var plugImage1: UIImageView!
    @IBOutlet weak var plugImage2: UIImageView!
    @IBOutlet weak var plugImage3: UIImageView!
    @IBOutlet weak var plugImage4: UIImageView!
    @IBOutlet weak var plugImage5: UIImageView!
    @IBOutlet weak var plugImage6: UIImageView!
    @IBOutlet weak var plugImage7: UIImageView!
    @IBOutlet weak var plugImage8: UIImageView!
    
    @IBOutlet weak var plugType1: UILabel!
    @IBOutlet weak var plugType2: UILabel!
    @IBOutlet weak var plugType3: UILabel!
    @IBOutlet weak var plugType4: UILabel!
    @IBOutlet weak var plugType5: UILabel!
    @IBOutlet weak var plugType6: UILabel!
    @IBOutlet weak var plugType7: UILabel!
    @IBOutlet weak var plugType8: UILabel!
    
    @IBOutlet weak var plugTypeDescription1: UILabel!
    @IBOutlet weak var plugTypeDescription2: UILabel!
    @IBOutlet weak var plugTypeDescription3: UILabel!
    @IBOutlet weak var plugTypeDescription4: UILabel!
    @IBOutlet weak var plugTypeDescription5: UILabel!
    @IBOutlet weak var plugTypeDescription6: UILabel!
    @IBOutlet weak var plugTypeDescription7: UILabel!
    @IBOutlet weak var plugTypeDescription8: UILabel!
    
    @IBOutlet weak var plugNumber1: UILabel!
    @IBOutlet weak var plugNumber2: UILabel!
    @IBOutlet weak var plugNumber3: UILabel!
    @IBOutlet weak var plugNumber4: UILabel!
    @IBOutlet weak var plugNumber5: UILabel!
    @IBOutlet weak var plugNumber6: UILabel!
    @IBOutlet weak var plugNumber7: UILabel!
    @IBOutlet weak var plugNumber8: UILabel!
    
    @IBOutlet weak var Titolo: UILabel!
    @IBOutlet weak var Sottotitolo: UILabel!
    @IBOutlet weak var dettagliTitolo: UILabel!
    @IBOutlet weak var iniziaNavigazione: UILabel!
    @IBOutlet weak var dettagliAlVai: UILabel!
    @IBOutlet weak var via: UILabel!
    @IBOutlet weak var cap: UILabel!
    @IBOutlet weak var stato: UILabel!
    
    @IBOutlet weak var providerName: UILabel!
    @IBOutlet weak var providerSito: UILabel!
    @IBOutlet weak var providerLicense: UILabel!
    
    public var latitude : Double = 0
    public var longitude : Double = 0
    
    @IBAction func vaiColonninaTouchDown(_ sender: Any) {
        vaiColonnina2.backgroundColor = UIColor(red: 153/255, green: 173/255, blue: 239/255, alpha: 1)
    }
    
    @IBAction func vaiColonninaTouchCancel(_ sender: Any) {
        vaiColonnina2.backgroundColor = UIColor(red: 54/255, green: 114/255, blue: 245/255, alpha: 1)
    }
    
    @IBAction func vaiColonnina(_ sender: Any) {
        vaiColonnina2.backgroundColor = UIColor(red: 54/255, green: 114/255, blue: 245/255, alpha: 1)
        let latitudeInDegrees:CLLocationDegrees =  latitude
        let longitudeInDegrees:CLLocationDegrees =  longitude
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitudeInDegrees, longitudeInDegrees)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "\(Titolo.text!)"
        mapItem.phoneNumber = telefonoColonnina
        mapItem.openInMaps(launchOptions: options)
    }
    
    @IBAction func faiChiamata(_ sender: Any) {
        if telefonoColonnina == "" {
            let alertController = UIAlertController(title: NSLocalizedString("Phone not Found", comment: "Telefono non trovato"), message: NSLocalizedString("Sorry, this charge point doesn't have a phone number.", comment: "Descrizione telefono non trovato"), preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            let strippedUrlString = telefonoColonnina.replacingOccurrences(of: " ", with: ".")
            let url = NSURL(string: "tel://\(strippedUrlString)")
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        }
    }
    @IBAction func faiCondividi(_ sender: Any) {
        let lat:String = String(format:"%f", self.latitude)
        let long:String = String (format : "%f",self.longitude)
        
        let address:String = via.text!
        let newString = address.replacingOccurrences(of: " ", with: "%20")
        let finalString = "Position"
        
        let targetURL = NSURL(string: "http://maps.apple.com/?address=\(newString)&ll=\(lat),\(long)&q=\(finalString)")!
        
        let objectToShare = [targetURL]
        
        let activity = UIActivityViewController(activityItems : objectToShare, applicationActivities: nil)
        activity.popoverPresentationController?.sourceView = self.view
        
        self.present(activity, animated: true, completion: nil)
    }
    
    @IBAction func frecciaDismiss(_ sender: Any) {
//        if delegate.detailState == "expanded"{
//            delegate.detailCardVisible = true
//            delegate.animateTransitionIfNeeded(state: delegate.nextDetailState, duration: 0.5)
        if delegate.detailState == "collapsed" || delegate.detailState == "expanded"{
            delegate.detailCardVisible = true
            delegate.animateTransitionIfNeeded(state: delegate.nextDetailState2, duration: 0.9)
            delegate.searchCardVisible = false
            delegate.animateSearchTransitionIfNeeded(state: delegate.nextSearchState2, duration: 0.9)
        }
    }
    
    override func viewDidLoad() {
        if self.traitCollection.userInterfaceStyle == .dark{
            let blurEffect = UIBlurEffect(style: .prominent)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = view.bounds
            view.backgroundColor = .clear
            view.insertSubview(blurEffectView, at: 0)
        }
        else {
            view.backgroundColor = .white
        }
        //        view.dropShadow()
        scrViewTotale.delegate = self
//        scrView.delegate = self
        lineatop.layer.cornerRadius = 3
        plugButton1.layer.cornerRadius = 7
        plugButton2.layer.cornerRadius = 7
        plugButton3.layer.cornerRadius = 7
        plugButton4.layer.cornerRadius = 7
        plugButton5.layer.cornerRadius = 7
        plugButton6.layer.cornerRadius = 7
        plugButton7.layer.cornerRadius = 7
        plugButton8.layer.cornerRadius = 7
        vaiColonnina2.layer.cornerRadius = 7
        faiChiamata2.layer.cornerRadius = 7
        faiCondividi2.layer.cornerRadius = 7
        plugNumber1.layer.cornerRadius = 4
        plugNumber1.layer.masksToBounds = true
        plugNumber2.layer.cornerRadius = 4
        plugNumber2.layer.masksToBounds = true
        plugNumber3.layer.cornerRadius = 4
        plugNumber3.layer.masksToBounds = true
        plugNumber4.layer.cornerRadius = 4
        plugNumber4.layer.masksToBounds = true
        plugNumber5.layer.cornerRadius = 4
        plugNumber5.layer.masksToBounds = true
        plugNumber6.layer.cornerRadius = 4
        plugNumber6.layer.masksToBounds = true
        plugNumber7.layer.cornerRadius = 4
        plugNumber7.layer.masksToBounds = true
        plugNumber8.layer.cornerRadius = 4
        plugNumber8.layer.masksToBounds = true
        //        Titolo.text = titoloColonnina
        //        Sottotitolo.text = sottoTitoloColonnina
        //        dettagliTitolo.text = dettagliTitoloColonnina
        //        minuti.text = minutiColonnina
        //        dettagliAlVai.text = dettagliAlViaColonnina
        //        via.text = viaColonnina
        //        cap.text = capColonnina
        //        stato.text = statoColonnina
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
//    override func viewDidLayoutSubviews() {
//        //        arrImages = [UIImage(named: "colonnina"), UIImage(named: "colonnina"), UIImage(named: "colonnina")] as! [UIImage]
////        self.faiscroll()
//    }
    
//    public func faiscroll(){
//        DispatchQueue.main.async {
//        let subViews = self.scrView.subviews
//        for subview in subViews{
//            subview.removeFromSuperview()
//        }
//        for i in 0..<arrImages.count{
//            let imageview = UIImageView()
//            imageview.image = arrImages[i]
//            let xposition = ((139 * CGFloat(i)) + (CGFloat(i) * 10))
//            imageview.frame = CGRect(x: xposition + 17, y: 0, width: 139, height: self.scrView.frame.height)
//            imageview.layer.cornerRadius = 10
//            imageview.layer.masksToBounds = true
//            self.scrView.contentSize.width = (139 * CGFloat(i + 1)) + 34 + (CGFloat(i) * 10)
//            self.scrView.addSubview(imageview)
//            }
//        }
//    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if self.traitCollection.userInterfaceStyle == .dark{
            let blurEffect = UIBlurEffect(style: .prominent)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = view.bounds
            view.backgroundColor = .clear
            view.insertSubview(blurEffectView, at: 0)
        }
        else {
            view.backgroundColor = .white
        }
    }
}

extension UIView
{
    func dropShadow()
    {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 1
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        //                        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
