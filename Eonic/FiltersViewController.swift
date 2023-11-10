//
//  FiltersViewController.swift
//  Eonic
//
//  Created by Antonio Ferraioli on 10/03/2020.
//  Copyright © 2020 Antonio Ferraioli. All rights reserved.
//

import UIKit

protocol EonicBaseDelegate{
    func showActivityIndicator()
    func hideActivityIndicator()
}

protocol FiltersDelegate{
    func removeAllAnnotations(completion: @escaping (Error?)->())
}

class FiltersViewController: UIViewController , UIScrollViewDelegate{
    
    var delegate:FiltersDelegate!
    var delegate2:EonicBaseDelegate!
    
    @IBOutlet weak var scrView: UIScrollView!
    @IBOutlet weak var lineatop: UIView!
    
    @IBOutlet weak var buttonLevel1: UIButton!
    @IBOutlet weak var buttonLevel2: UIButton!
    @IBOutlet weak var buttonLevel3: UIButton!
    @IBOutlet weak var buttonType2: UIButton!
    @IBOutlet weak var buttonCss: UIButton!
    @IBOutlet weak var buttonChademo: UIButton!
    @IBOutlet weak var buttonTesla: UIButton!
    @IBOutlet weak var buttonThreephase: UIButton!
    @IBOutlet weak var buttonCEE: UIButton!
    @IBOutlet weak var buttonType1: UIButton!
    @IBOutlet weak var buttonNema: UIButton!
    
    @IBOutlet weak var buttonSaveAndSearch: UIButton!
    
    var isLevel1Selected: Bool = false
    var isLevel2Selected: Bool = false
    var isLevel3Selected: Bool = false
    
    var isType2Selected: Bool = false
    var isCcsSelected: Bool = false
    var isChademoSelected: Bool = false
    var isTeslaSelected: Bool = false
    var isThreephaseSelected: Bool = false
    var isCeeSelected: Bool = false
    var isType1Selected: Bool = false
    var isNemaSelected: Bool = false
    
    @IBOutlet weak var immagineLevel1: UIImageView!
    @IBOutlet weak var immagineLevel2: UIImageView!
    @IBOutlet weak var immagineLevel3: UIImageView!
    
    @IBOutlet weak var testoLevel1: UILabel!
    @IBOutlet weak var testoLevel2: UILabel!
    @IBOutlet weak var testoLevel3: UILabel!
    
    @IBOutlet weak var dettagliLevel1: UILabel!
    @IBOutlet weak var dettagliLevel2: UILabel!
    @IBOutlet weak var dettagliLevel3: UILabel!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image7: UIImageView!
    @IBOutlet weak var image8: UIImageView!
    
    @IBOutlet weak var testo1: UILabel!
    @IBOutlet weak var testo2: UILabel!
    @IBOutlet weak var testo3: UILabel!
    @IBOutlet weak var testo4: UILabel!
    @IBOutlet weak var testo5: UILabel!
    @IBOutlet weak var testo6: UILabel!
    @IBOutlet weak var testo7: UILabel!
    @IBOutlet weak var testo8: UILabel!
    
    @IBOutlet weak var allOtherPlugsSwitch: UISwitch!
    @IBOutlet weak var freeStationsSwitch: UISwitch!
    @IBOutlet weak var privateStationsSwitch: UISwitch!
    
    @IBAction func level1ButtonClicked(_ sender: Any) {
        isLevel1Selected = !isLevel1Selected
        if(isLevel1Selected == true){
            buttonLevel1.backgroundColor = UIColor(red: 54/255, green: 114/255, blue: 245/255, alpha: 1)
            immagineLevel1.image = UIImage(named: "ChargeLevelSelected")
            testoLevel1.textColor = .white
            dettagliLevel1.textColor = .white
        }
        else
        {
            buttonLevel1.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 240/255, alpha: 1)
            immagineLevel1.image = UIImage(named: "ChargeLevelUnselected")
            testoLevel1.textColor = UIColor(red: 121/255, green: 149/255, blue: 242/255, alpha: 1)
            dettagliLevel1.textColor = UIColor(red: 121/255, green: 149/255, blue: 242/255, alpha: 1)
        }
    }
    
    @IBAction func level2ButtonClicked(_ sender: Any) {
        isLevel2Selected = !isLevel2Selected
        if(isLevel2Selected == true){
            buttonLevel2.backgroundColor = UIColor(red: 54/255, green: 114/255, blue: 245/255, alpha: 1)
            immagineLevel2.image = UIImage(named: "ChargeLevelSelected")
            testoLevel2.textColor = .white
            dettagliLevel2.textColor = .white
        }
        else
        {
            buttonLevel2.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 240/255, alpha: 1)
            immagineLevel2.image = UIImage(named: "ChargeLevelUnselected")
            testoLevel2.textColor = UIColor(red: 121/255, green: 149/255, blue: 242/255, alpha: 1)
            dettagliLevel2.textColor = UIColor(red: 121/255, green: 149/255, blue: 242/255, alpha: 1)
        }
    }
    
    @IBAction func level3ButtonClicked(_ sender: Any) {
        isLevel3Selected = !isLevel3Selected
        if(isLevel3Selected == true){
            buttonLevel3.backgroundColor = UIColor(red: 54/255, green: 114/255, blue: 245/255, alpha: 1)
            immagineLevel3.image = UIImage(named: "ChargeLevelSelected")
            testoLevel3.textColor = .white
            dettagliLevel3.textColor = .white
        }
        else
        {
            buttonLevel3.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 240/255, alpha: 1)
            immagineLevel3.image = UIImage(named: "ChargeLevelUnselected")
            testoLevel3.textColor = UIColor(red: 121/255, green: 149/255, blue: 242/255, alpha: 1)
            dettagliLevel3.textColor = UIColor(red: 121/255, green: 149/255, blue: 242/255, alpha: 1)
        }
    }
    
    @IBAction func type2ButtonClicked(_ sender: Any) {
        isType2Selected = !isType2Selected
        if(isType2Selected == true){
            buttonType2.backgroundColor = UIColor(red: 54/255, green: 114/255, blue: 245/255, alpha: 1)
            image1.image = UIImage(named: "Type2MANNSelected")
            testo1.textColor = .white
        }
        else
        {
            buttonType2.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 240/255, alpha: 1)
            image1.image = UIImage(named: "Type2MANNUnSelected")
            testo1.textColor = UIColor(red: 121/255, green: 149/255, blue: 242/255, alpha: 1)
        }
    }
    
    @IBAction func cssButtonClicked(_ sender: Any) {
        isCcsSelected = !isCcsSelected
        if(isCcsSelected == true){
            buttonCss.backgroundColor = UIColor(red: 54/255, green: 114/255, blue: 245/255, alpha: 1)
            image2.image = UIImage(named: "CCSSelected")
            testo2.textColor = .white
        }
        else
        {
            buttonCss.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 240/255, alpha: 1)
            image2.image = UIImage(named: "CCSUnSelected")
            testo2.textColor = UIColor(red: 121/255, green: 149/255, blue: 242/255, alpha: 1)
        }
    }
    
    @IBAction func chademoButtonClicked(_ sender: Any) {
        isChademoSelected = !isChademoSelected
        if(isChademoSelected == true){
            buttonChademo.backgroundColor = UIColor(red: 54/255, green: 114/255, blue: 245/255, alpha: 1)
            image3.image = UIImage(named: "CHAdeMOSelected")
            testo3.textColor = .white
        }
        else
        {
            buttonChademo.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 240/255, alpha: 1)
            image3.image = UIImage(named: "CHAdeMOUnSelected")
            testo3.textColor = UIColor(red: 121/255, green: 149/255, blue: 242/255, alpha: 1)
        }
    }
    
    @IBAction func teslaButtonClicked(_ sender: Any) {
        isTeslaSelected = !isTeslaSelected
        if(isTeslaSelected == true){
            buttonTesla.backgroundColor = UIColor(red: 54/255, green: 114/255, blue: 245/255, alpha: 1)
            image4.image = UIImage(named: "TESLASelected")
            testo4.textColor = .white
        }
        else
        {
            buttonTesla.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 240/255, alpha: 1)
            image4.image = UIImage(named: "TeslaUnselected")
            testo4.textColor = UIColor(red: 121/255, green: 149/255, blue: 242/255, alpha: 1)
        }
    }
    
    @IBAction func threePhaseButtonClicked(_ sender: Any) {
        isThreephaseSelected = !isThreephaseSelected
        if(isThreephaseSelected == true){
            buttonThreephase.backgroundColor = UIColor(red: 54/255, green: 114/255, blue: 245/255, alpha: 1)
            image5.image = UIImage(named: "ThreePhaseSelected")
            testo5.textColor = .white
        }
        else
        {
            buttonThreephase.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 240/255, alpha: 1)
            image5.image = UIImage(named: "ThreePhaseEUUnSelected")
            testo5.textColor = UIColor(red: 121/255, green: 149/255, blue: 242/255, alpha: 1)
        }
    }
    
    @IBAction func ceeButtonClicked(_ sender: Any) {
        isCeeSelected = !isCeeSelected
        if(isCeeSelected == true){
            buttonCEE.backgroundColor = UIColor(red: 54/255, green: 114/255, blue: 245/255, alpha: 1)
            image6.image = UIImage(named: "CEESelected")
            testo6.textColor = .white
        }
        else
        {
            buttonCEE.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 240/255, alpha: 1)
            image6.image = UIImage(named: "CEEUnselected")
            testo6.textColor = UIColor(red: 121/255, green: 149/255, blue: 242/255, alpha: 1)
        }
    }
    
    @IBAction func type1ButtonClicked(_ sender: Any) {
        isType1Selected = !isType1Selected
        if(isType1Selected == true){
            buttonType1.backgroundColor = UIColor(red: 54/255, green: 114/255, blue: 245/255, alpha: 1)
            image7.image = UIImage(named: "Type1Selected")
            testo7.textColor = .white
        }
        else
        {
            buttonType1.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 240/255, alpha: 1)
            image7.image = UIImage(named: "Type1UnSelected")
            testo7.textColor = UIColor(red: 121/255, green: 149/255, blue: 242/255, alpha: 1)
        }
    }
    
    @IBAction func nemaButtonClicked(_ sender: Any) {
        isNemaSelected = !isNemaSelected
        if(isNemaSelected == true){
            buttonNema.backgroundColor = UIColor(red: 54/255, green: 114/255, blue: 245/255, alpha: 1)
            image8.image = UIImage(named: "NEMASelected")
            testo8.textColor = .white
        }
        else
        {
            buttonNema.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 240/255, alpha: 1)
            image8.image = UIImage(named: "NEMAUnselected")
            testo8.textColor = UIColor(red: 121/255, green: 149/255, blue: 242/255, alpha: 1)
        }
    }
    
    @IBAction func vaiColonninaTouchDown(_ sender: Any) {
        buttonSaveAndSearch.backgroundColor = UIColor(red: 153/255, green: 173/255, blue: 239/255, alpha: 1)
    }
    
    @IBAction func vaiColonninaTouchCancel(_ sender: Any) {
        buttonSaveAndSearch.backgroundColor = UIColor(red: 54/255, green: 114/255, blue: 245/255, alpha: 1)
    }
    
    @IBAction func saveAndSearchButtonClicked(_ sender: Any) {
        
        var filterString: String = "&levelid="
        var levelString: String = ""
        
        if isLevel1Selected {
            UserDefaults.standard.setValue(true, forKey: "Level 1")
            levelString += "1,"
        } else {
            UserDefaults.standard.setValue(false, forKey: "Level 1")
        }
        if isLevel2Selected{
            UserDefaults.standard.setValue(true, forKey: "Level 2")
            levelString += "2,"
        } else{
            UserDefaults.standard.setValue(false, forKey: "Level 2")
        }
        if isLevel3Selected{
            UserDefaults.standard.setValue(true, forKey: "Level 3")
            levelString += "3,"
        }else{
            UserDefaults.standard.setValue(false, forKey: "Level 3")
        }
        if(levelString != ""){
            levelString.removeLast()
        }
        filterString += (levelString != "") ? "\(levelString)&connectiontypeid=" : "1,2,3&connectiontypeid="
        
        
        
        var plugString: String = ""
        
        if isType2Selected{
            UserDefaults.standard.setValue(true, forKey: "Type 2")
            plugString += "25,1036,"
        }else{
            UserDefaults.standard.setValue(false, forKey: "Type 2")
        }
        if isChademoSelected{
            UserDefaults.standard.setValue(true, forKey: "Chademo")
            plugString += "2,"
        }else{
            UserDefaults.standard.setValue(false, forKey: "Chademo")
        }
        if isCcsSelected{
            UserDefaults.standard.setValue(true, forKey: "Ccs")
            plugString += "32,33,"
        }else{
            UserDefaults.standard.setValue(false, forKey: "Ccs")
        }
        if isTeslaSelected{
            UserDefaults.standard.setValue(true, forKey: "Tesla")
            plugString += "8,27,30,31,"
        }else{
            UserDefaults.standard.setValue(false, forKey: "Tesla")
        }
        if isThreephaseSelected{
            UserDefaults.standard.setValue(true, forKey: "Threephase")
            plugString += "35,1041,"
        }else{
            UserDefaults.standard.setValue(false, forKey: "Threephase")
        }
        if isCeeSelected{
            UserDefaults.standard.setValue(true, forKey: "Cee")
            plugString += "13,16,17,18,23,28,"
        }else{
            UserDefaults.standard.setValue(false, forKey: "Cee")
        }
        if isType1Selected{
            UserDefaults.standard.setValue(true, forKey: "Type 1")
            plugString += "1,"
        }else{
            UserDefaults.standard.setValue(false, forKey: "Type 1")
        }
        if isNemaSelected{
            UserDefaults.standard.setValue(true, forKey: "Nema")
            plugString += "9,10,11,14,15,22,1042,"
        }else{
            UserDefaults.standard.setValue(false, forKey: "Nema")
        }
        
        if(plugString != ""){
            plugString.removeLast()
        }
        filterString += (plugString != "") ? "\(plugString)" : "25,1036,2,32,33,8,27,30,31,35,13,16,17,18,23,28,1,9,10,11,14,15,22,1042"
        
        var otherString : String = ""
        if allOtherPlugsSwitch.isOn{
            UserDefaults.standard.setValue(true, forKey: "Other plugs")
            otherString += ",7,4,3,1038,1039,1040,34,5,36,26,6,1037,29,24,21,0&usagetypeid="
        }else{
            UserDefaults.standard.setValue(false, forKey: "Other plugs")
        }
        
        filterString += (otherString != "") ? "\(otherString)" : "&usagetypeid="
        
        var privateString: String = ""
        if privateStationsSwitch.isOn{
            UserDefaults.standard.setValue(true, forKey: "Private")
            privateString += "0,1,2,3,4,5,6,7"
        }else{
            UserDefaults.standard.setValue(false, forKey: "Private")
            privateString += "0,1,4,5"
        }
        
        filterString += privateString
        
        freeStationsSwitch.isOn ? UserDefaults.standard.setValue(true, forKey: "Free") : UserDefaults.standard.setValue(false, forKey: "Free")
        
        UserDefaults.standard.setValue(filterString, forKey: "Filters")
        print(filterString)
//        self.showActivityIndicator()
        poiManager.poiCache!.emptyCache()
        poiManager.poiData?.removeAll()
        delegate.removeAllAnnotations(){ (error) in
            guard error==nil else {
                print(error!.localizedDescription)
                return
            }
            poiManager.getFilteredPois(latitude: locationManager.locationManager.location?.coordinate.latitude ?? 0, longitude: locationManager.locationManager.location?.coordinate.longitude ?? 0){ (error) in
                guard error==nil else {
                    self.delegate2.hideActivityIndicator()
                    print(error!.localizedDescription)
                    return
                }
                poiManager.getNearestPoi(latitude: locationManager.locationManager.location?.coordinate.latitude ?? 0, longitude: locationManager.locationManager.location?.coordinate.longitude ?? 0){ (error) in
                    guard error==nil else {
                        print(error!.localizedDescription)
                        return
                    }
//                    self.delegate2.hideActivityIndicator()
                }
            }
        }
        delegate2.showActivityIndicator()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func dismissModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override public func viewDidLoad() {
        //        let blurEffect = UIBlurEffect(style: .prominent)
        //        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        //        blurEffectView.frame = view.bounds
        //        view.insertSubview(blurEffectView, at: 0)
        scrView.delegate = self
        scrView.delaysContentTouches = false
        //scrView.contentSize = CGSize(width: view.frame.size.width, height: self.view.frame.size.height + 300)
        view.addSubview(scrView)
        lineatop.layer.cornerRadius = 3
        buttonLevel1.layer.cornerRadius = 7
        buttonLevel2.layer.cornerRadius = 7
        buttonLevel3.layer.cornerRadius = 7
        buttonType2.layer.cornerRadius = 7
        buttonCss.layer.cornerRadius = 7
        buttonChademo.layer.cornerRadius = 7
        buttonTesla.layer.cornerRadius = 7
        buttonThreephase.layer.cornerRadius = 7
        buttonCEE.layer.cornerRadius = 7
        buttonType1.layer.cornerRadius = 7
        buttonNema.layer.cornerRadius = 7
        buttonSaveAndSearch.layer.cornerRadius = 7
        
        assignButtons()
        super.viewDidLoad()
    }
    
    func assignButtons(){
        
        let level1: Bool? = UserDefaults.standard.value(forKey: "Level 1") as? Bool
        let level2: Bool? = UserDefaults.standard.value(forKey: "Level 2") as? Bool
        let level3: Bool? = UserDefaults.standard.value(forKey: "Level 3") as? Bool
        
        let type2: Bool? = UserDefaults.standard.value(forKey: "Type 2") as? Bool
        let chademo: Bool? = UserDefaults.standard.value(forKey: "Chademo") as? Bool
        let ccs: Bool? = UserDefaults.standard.value(forKey: "Ccs") as? Bool
        let tesla: Bool? = UserDefaults.standard.value(forKey: "Tesla") as? Bool
        let threephase: Bool? = UserDefaults.standard.value(forKey: "Threephase") as? Bool
        let cee: Bool? = UserDefaults.standard.value(forKey: "Cee") as? Bool
        let type1: Bool? = UserDefaults.standard.value(forKey: "Type 1") as? Bool
        let nema: Bool? = UserDefaults.standard.value(forKey: "Nema") as? Bool
        let other: Bool? = UserDefaults.standard.value(forKey: "Other plugs") as? Bool
        let privateStation: Bool? = UserDefaults.standard.value(forKey: "Private") as? Bool
        let free: Bool? = UserDefaults.standard.value(forKey: "Free") as? Bool
        
        if !(level1 == nil || level1 == false){
            isLevel1Selected = true
            buttonLevel1.backgroundColor = UIColor(red: 54/255, green: 114/255, blue: 245/255, alpha: 1)
            immagineLevel1.image = UIImage(named: "ChargeLevelSelected")
            testoLevel1.textColor = .white
            dettagliLevel1.textColor = .white
        }
        if !(level2 == nil || level2 == false){
            isLevel2Selected = true
            buttonLevel2.backgroundColor = UIColor(red: 54/255, green: 114/255, blue: 245/255, alpha: 1)
            immagineLevel2.image = UIImage(named: "ChargeLevelSelected")
            testoLevel2.textColor = .white
            dettagliLevel2.textColor = .white
        }
        if !(level3 == nil || level3 == false){
            isLevel3Selected = true
            buttonLevel3.backgroundColor = UIColor(red: 54/255, green: 114/255, blue: 245/255, alpha: 1)
            immagineLevel3.image = UIImage(named: "ChargeLevelSelected")
            testoLevel3.textColor = .white
            dettagliLevel3.textColor = .white
        }
        if !(type2 == nil || type2 == false){
            isType2Selected = true
            buttonType2.backgroundColor = UIColor(red: 54/255, green: 114/255, blue: 245/255, alpha: 1)
            image1.image = UIImage(named: "Type2MANNSelected")
            testo1.textColor = .white
        }
        if !(ccs == nil || ccs == false){
            isCcsSelected = true
            buttonCss.backgroundColor = UIColor(red: 54/255, green: 114/255, blue: 245/255, alpha: 1)
            image2.image = UIImage(named: "CCSSelected")
            testo2.textColor = .white
        }
        if !(chademo == nil || chademo == false){
            isChademoSelected = true
            buttonChademo.backgroundColor = UIColor(red: 54/255, green: 114/255, blue: 245/255, alpha: 1)
            image3.image = UIImage(named: "CHAdeMOSelected")
            testo3.textColor = .white
        }
        if !(tesla == nil || tesla == false){
            isTeslaSelected = true
            buttonTesla.backgroundColor = UIColor(red: 54/255, green: 114/255, blue: 245/255, alpha: 1)
            image4.image = UIImage(named: "TESLASelected")
            testo4.textColor = .white
        }
        if !(threephase == nil || threephase == false){
            isThreephaseSelected = true
            buttonThreephase.backgroundColor = UIColor(red: 54/255, green: 114/255, blue: 245/255, alpha: 1)
            image5.image = UIImage(named: "ThreePhaseSelected")
            testo5.textColor = .white
        }
        if !(cee == nil || cee == false){
            isCeeSelected = true
            buttonCEE.backgroundColor = UIColor(red: 54/255, green: 114/255, blue: 245/255, alpha: 1)
            image6.image = UIImage(named: "CEESelected")
            testo6.textColor = .white
        }
        if !(type1 == nil || type1 == false){
            isType1Selected = true
            buttonType1.backgroundColor = UIColor(red: 54/255, green: 114/255, blue: 245/255, alpha: 1)
            image7.image = UIImage(named: "Type1Selected")
            testo7.textColor = .white
        }
        if !(nema == nil || nema == false){
            isNemaSelected = true
            buttonNema.backgroundColor = UIColor(red: 54/255, green: 114/255, blue: 245/255, alpha: 1)
            image8.image = UIImage(named: "NEMASelected")
            testo8.textColor = .white
        }
        allOtherPlugsSwitch.isOn = (other == nil || other == false) ? false : true
        freeStationsSwitch.isOn = (free == nil || free == false) ? false : true
        privateStationsSwitch.isOn = (privateStation == nil || privateStation == false) ? false : true
    }
}
