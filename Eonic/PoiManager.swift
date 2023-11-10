//
//  PoiManager.swift
//  Colonnine
//
//  Created by Simone Punzo on 17/02/2020.
//  Copyright © 2020 Antonio Ferraioli. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import CarPlay

protocol PoiManagerDelegate{
    func addAnnotation(for poi: PoiManager.PoiData, completion: @escaping(Error?)->())
    func removeAnnotation(poi: PoiManager.PoiData, completion: @escaping(Error?)->())
    func calculateRoute(to poi: PoiManager.PoiData)
    func hideActivityIndicator()
}

public class PoiManager: NSObject, URLSessionDelegate{
    
    static let singleton = PoiManager()
    
    
    static func getPoiManager() -> PoiManager {
        return .singleton
    }
    
    private override init() {
        super.init()
        //        poiCache.emptyCache()
        poiData = poiCache!.getAllValues()
        if poiData!.count > size{
            poiCache!.emptyCache()
            poiData = poiCache!.getAllValues()
        }
    }
    
    var delegate:PoiManagerDelegate!
    
    struct DataProviderStatusType: Codable {
        //let IsProviderEnabled: Bool?
        let ID: Int?
        let Title: String?
    }
    
    struct DataProvider: Codable {
        let WebsiteURL: String?
        //let Comments: String?
        let DataProviderStatusType: DataProviderStatusType
        //let IsRestrictedEdit: Bool?
        let IsOpenDataLicensed: Bool?
        //let IsApprovedImport: Bool?
        let License: String?
        let DateLastImported: String?
        let ID: Int?
        let Title: String?
    }
    
    struct OperatorInfo: Codable {
        let WebsiteURL: String?
        let Comments: String?
        
        // penso string ma è da controllare
        let PhonePrimaryContact: String?
        let PhoneSecondaryContact: String?
        // // // // // //
        
        let IsPrivateIndividual: Bool?
        let AddressInfo: String?
        let BookingURL: String?
        let ContactEmail: String?
        let FaultReportEmail: String?
        let IsRestrictedEdit: Bool?
        let ID: Int?
        let Title: String?
    }
    
    struct UsageType: Codable {
        let IsPayAtLocation: Bool?
        let IsMembershipRequired: Bool?
        let IsAccessKeyRequired: Bool?
        let ID: Int?
        let Title: String?
    }
    
    struct StatusType: Codable {
        let IsOperational: Bool?
        let IsUserSelectable: Bool?
        let ID: Int?
        let Title: String?
    }
    
    struct SubmissionStatus: Codable {
        let IsLive: Bool?
        let ID: Int?
        let Title: String?
    }
    
    struct Country: Codable {
        let ISOCode: String?
        let ContinentCode: String?
        let ID: Int?
        let Title: String?
    }
    
    struct AddressInfo: Codable {
        let ID: Int?
        let Title: String?
        let AddressLine1: String?
        let AddressLine2: String?
        let Town: String?
        let StateOrProvince: String?
        let Postcode: String?
        let CountryID: Int?
        let Country: Country?
        var Latitude: Double?
        let Longitude: Double?
        let ContactTelephone1: String?
        let ContactTelephone2: String?
        //let ContactEmail: String?
        //let CccessComments: Bool? // che cazzo è, ho messo il tipo a caso
        //let RelatedUrl: String?
        let Distance: Double?
        let DistanceUnit: Int?
    }
    
    struct ConnectionType: Codable {
        //let FormalName: String?
        //let IsDiscontinued: Bool?
        //let IsObsolete: Bool?
        let ID: Int?
        let Title: String?
    }
    
    struct ConnectionStatusType: Codable {
        let IsOperational: Bool?
        let IsUserSelectable: Bool?
        let ID: Int?
        let Title: String?
    }
    
    struct Level: Codable {
        let Comments: String?
        let IsFastChargeCapable: Bool?
        let ID: Int?
        let Title: String?
    }
    
    struct CurrentType: Codable {
        let Description: String?
        let ID: Int?
        let Title: String?
    }
    
    struct Connection: Codable {
        let ID: Int?
        let ConnectionTypeID: Int?
        let ConnectionType: ConnectionType?
        let Reference: String? // penso sia string
        let StatusTypeID: Int?
        let StatusType: ConnectionStatusType?
        let LevelID: Int?
        let Level: Level?
        let Amps: Int?
        let Voltage: Int?
        let PowerKW: Float?
        let CurrentTypeID: Int?
        let CurrentType: CurrentType?
        let Quantity: Int?
        let Comments: String?
    }
    struct MediaItem: Codable {
        let ItemURL: String?
        let ItemThumbnailURL:String?
        let IsVideo: Bool?
    }
    
    public struct PoiData: Codable {
        let DataProvider: DataProvider?
        let OperatorInfo: OperatorInfo?
        let UsageType: UsageType?
        let StatusType: StatusType?
        let SubmissionStatus: SubmissionStatus?
        // let UserComments: [String]?
        
        //let PercentageSimilarity: Int? // o double???
        //let MediaItems: [MediaItem]? //non ne ho idea se è string
        //let IsRecentlyVerified: Bool?
        //let DateLastVerified: String? // Date
        let ID: Int?
        let UUID: String?
        //let ParentChargePointID: Int?
        let DataProviderID: Int?
        let DataProvidersReference: String? // bho, non so se è string
        let OperatorID: Int?
        let OperatorsReference: String? // anche qui non so se è string
        let UsageTypeID: Int?
        let UsageCost: String?
        let AddressInfo: AddressInfo?
        let Connections: [Connection]?
        let NumberOfPoints: Int?
        let GeneralComments: String?
        let DatePlanned: String? // penso sia date ce
        let DateLastConfirmed: String?
        let StatusTypeID: Int?
        let DateLastStatusUpdate: String?
        //let MetadataValues: [String]? // che cazzo sono sti metadata, penso string
        let DataQualityLevel: Int?
        //let DateCreated: String?
        //let SubmissionStatusTypeID: Int?
    }
    
    lazy var poiCache: Cache<String, PoiManager.PoiData>? = {
        let cache = Cache<String, PoiManager.PoiData>()
        return cache.loadCache(withName: "poiCache")
    }()
    
    var poiData: [PoiData]?
    let size = 1500
    
    private func insert(poi: PoiManager.PoiData, completion: @escaping (Bool, Error?)->()){
        if(poiData!.count >= size) {
            //            print("pieno")
            let removePoi = poiData!.first!
            self.poiCache!.removeValue(forKey: removePoi.UUID!)
            self.poiData?.removeFirst()
            self.poiData?.append(poi)
            self.poiCache!.insert(poi, forKey: poi.UUID!)
            //                            print("poi added \(self.poiData?.count)")
            self.delegate.removeAnnotation(poi: removePoi){ (error) in
                guard error==nil else {
                    print(error!.localizedDescription)
                    return
                }
                self.delegate.addAnnotation(for: poi){ (error) in
                    guard error==nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    completion(true, nil)
                }
            }
        }else{
            self.poiData?.append(poi)
            self.poiCache!.insert(poi, forKey: poi.UUID!)
            //                            print("poi added \(self.poiData?.count)")
            self.delegate.addAnnotation(for: poi){ (error) in
                guard error==nil else {
                    print(error!.localizedDescription)
                    return
                }
                completion(true, nil)
            }
        }
    }
    
    public func getPois(latitude: Double, longitude: Double) {
        let url = URL(string: "https://api.openchargemap.io/v3/poi/?output=json&key=bb711b10-cc7d-4a83-919f-f8edeb10d2b8&latitude=\(latitude)&longitude=\(longitude)&maxresults=900&distance=50&distanceunite=km")!
        
        let configuration = URLSession.shared.configuration
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForResource = 60
        
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            self.readJson(data: data){ (error) in
                guard error==nil else {
                    print(error!.localizedDescription)
                    return
                }
                print("eseguito")
            }
        }
        task.taskDescription = "getPois"
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    
    
    //    public func getImages(for poi: PoiManager.PoiData) ->[UIImage]? {
    //        let configuration = URLSession.shared.configuration
    //        configuration.waitsForConnectivity = true
    //        configuration.timeoutIntervalForResource = 60
    //
    //        var images: [UIImage] = []
    //        let group = DispatchGroup()
    //        group.enter()
    //
    //        for image in poi.MediaItems ?? []{
    //            let url = URL(string: image.ItemThumbnailURL!)!
    //
    //            let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    //            print("aa")
    //            let task = session.dataTask(with: url) { data, _, _ in
    //                guard let data = data else { return }
    //                print("bb")
    //                let myImage = UIImage(data: data)
    //                if myImage != nil{
    //                    images.append(myImage!)
    //                    print(images)
    //                    if (images.count == poi.MediaItems?.count){
    //                        group.leave()
    //                    }
    //                }
    //                else{
    //                    group.leave()
    //                }
    //            }
    //            task.taskDescription = "getImages"
    //            task.resume()
    //        }
    //        if (poi.MediaItems == nil){
    //            group.leave()
    //        }
    //        group.wait()
    //        return images
    //    }
    
    public func urlSession(_ session: URLSession, taskIsWaitingForConnectivity task: URLSessionTask) {
        //        print("siamo dentro urlSession")
        switch task.taskDescription{
        
        case "getNearestPoi":
            task.cancel()
            self.searchNearestPoi()
            
        default:
            return
        }
    }
    
    //    var nearestPoi: PoiData = {
    //        var nearestPoi = poiData?.first
    //        for poi in poiData ?? []{
    //            let location = CLLocation(latitude: (poi.AddressInfo?.Latitude) ?? 0, longitude: (poi.AddressInfo?.Longitude) ?? 0)
    //            let nearestPoiLocation = CLLocation(latitude: nearestPoi?.AddressInfo?.Latitude ?? 0, longitude: nearestPoi?.AddressInfo?.Longitude ?? 0)
    //            let distance1: Double = (locationManager.locationManager.location?.distance(from: nearestPoiLocation))! //as! Double
    //            let distance2: Double = (locationManager.locationManager.location?.distance(from: location))! //as! Double
    //            //            print("OOOOOOOOOOOOOOOOOOO \(distance1)")
    //            //            print(distance2)
    //            if( distance2 < distance1 ){
    //                nearestPoi = poi
    //            }
    //        }
    //        return nearestPoi
    //    }()
    
    func searchNearestPoi(){
        var nearestPoi = poiData?.first
        let actualposition = locationManager.locationManager.location ?? CLLocation(latitude: 0, longitude: 0)
        if(actualposition != CLLocation(latitude: 0, longitude: 0)){
            for poi in poiData ?? []{
                let location = CLLocation(latitude: (poi.AddressInfo?.Latitude) ?? 0, longitude: (poi.AddressInfo?.Longitude) ?? 0)
                let nearestPoiLocation = CLLocation(latitude: nearestPoi?.AddressInfo?.Latitude ?? 0, longitude: nearestPoi?.AddressInfo?.Longitude ?? 0)
                let distance1: Double = (actualposition.distance(from: nearestPoiLocation)) //as! Double
                let distance2: Double = (actualposition.distance(from: location)) //as! Double
                //            print("OOOOOOOOOOOOOOOOOOO \(distance1)")
                //            print(distance2)
                if( distance2 < distance1 ){
                    nearestPoi = poi
                }
            }
            delegate.calculateRoute(to: nearestPoi!)
        }
    }
    
    func getNearestPoi(latitude: Double, longitude: Double, completion: @escaping (Error?)->()) {
        
        let filterString: String? = UserDefaults.standard.value(forKey: "Filters") as? String
        
        let url = URL(string: "https:api.openchargemap.io/v3/poi/?output=json&key=bb711b10-cc7d-4a83-919f-f8edeb10d2b8&latitude=\(latitude)&longitude=\(longitude)&maxresults=1" + (filterString ?? ""))!
        
        print(url)
        let configuration = URLSession.shared.configuration
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForResource = 5
        
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
        var nearestPoi: [PoiData]?
        
        let task = session.dataTask(with: url) {[weak self] (data, _, error) in
            
            if (error != nil && (self?.poiData!.count)! > 0){
                self!.searchNearestPoi()
                return
            }
            guard let data = data else {
                self!.delegate.hideActivityIndicator()
                return
                
            }
            do {
                let decoder: JSONDecoder = JSONDecoder()
                nearestPoi = try decoder.decode([PoiData].self, from: data)
                if(nearestPoi?.first != nil){
                    if (!self!.poiData!.contains(where: {$0.ID == nearestPoi!.first!.ID})){
                        self!.insert(poi: nearestPoi!.first!){ (result, error) in
                            guard error==nil else {
                                print(error!.localizedDescription)
                                return
                            }
                            self!.delegate.calculateRoute(to: nearestPoi!.first!)
                        }
                    }
                    else{
                        self!.delegate.calculateRoute(to: nearestPoi!.first!)
                    }
                }
            }catch{
            }
            completion(nil)
        }
        task.taskDescription = "getNearestPoi"
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    public func getFilteredPois(latitude: Double, longitude: Double, completion: @escaping (Error?)->()){
        group.enter()
        let filterString: String? = UserDefaults.standard.value(forKey: "Filters") as? String
        
        let url = URL(string: "https://api.openchargemap.io/v3/poi/?output=json&key=bb711b10-cc7d-4a83-919f-f8edeb10d2b8&latitude=\(latitude)&longitude=\(longitude)&maxresults=900&distance=50&distanceunite=km" + (filterString ?? ""))!
        //        print(url)
        
        let configuration = URLSession.shared.configuration
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForResource = 60
        //        configuration.requestCachePolicy = .useProtocolCachePolicy
        
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: url) {[weak self] (data, _, _) in
            guard let data = data else { return }
            self!.readJson(data: data){ (error) in
                guard error==nil else {
                    print(error!.localizedDescription)
                    return
                }
                print("eseguito")
                let string = group.debugDescription
                var differenza = 0
                let needle: Character = "{"
                if let idx = string.firstIndex(of: needle) {
                    let pos = string.distance(from: string.startIndex, to: idx)
                    differenza = pos - 41
                }
                let start = String.Index(utf16Offset: 53 + differenza, in: string)
                let end = String.Index(utf16Offset: 60 + differenza, in: string)
                let substring = String(string[start..<end])
                print(substring)
                if (substring == "ref = 2"){
                    group.leave()
                }
            }
            completion(nil)
        }
        task.taskDescription = "getPois"
        task.resume()
        session.finishTasksAndInvalidate()
        // task.cancel()
    }
    
    func getCarPlayPoi(latitude: Double, longitude: Double, completion: @escaping (Error?)->()) {
        
        let filterString: String? = UserDefaults.standard.value(forKey: "Filters") as? String
        
        let url = URL(string: "https:api.openchargemap.io/v3/poi/?output=json&key=bb711b10-cc7d-4a83-919f-f8edeb10d2b8&latitude=\(latitude)&longitude=\(longitude)&maxresults=12" + (filterString ?? ""))!
        
        let configuration = URLSession.shared.configuration
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForResource = 5
        
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
        var nearestPoi: [PoiData]?
        
        let task = session.dataTask(with: url) {[] (data, _, error) in
            guard let data = data else { return }
            do {
                let decoder: JSONDecoder = JSONDecoder()
                nearestPoi = try decoder.decode([PoiData].self, from: data)
            }catch{
            }
            if #available(iOS 14.0, *) {
                //                poi.removeAll()
                for i in 0..<nearestPoi!.count - 1{
                    print(i)
                    //Calcolo cordinate
                    if(poi.count < nearestPoi!.count){
                        poi.append(poi[0])
                    }
                    let location = CLLocationCoordinate2D(latitude: (nearestPoi![i].AddressInfo?.Latitude) ?? 0, longitude: (nearestPoi![i].AddressInfo?.Longitude) ?? 0)
                    poi[i].location = MKMapItem(placemark: MKPlacemark(coordinate: location))
                    //Calcolo titolo compagnia
                    var titoloColonnina: String = ""
                    if (nearestPoi![i].OperatorInfo?.Title == nil){
                        titoloColonnina = NSLocalizedString("Unknown Company", comment: "Compagnia sconosciuta")
                    }
                    else if(nearestPoi![i].OperatorInfo?.Title == "Unknown Operator" || nearestPoi![i].OperatorInfo?.Title == "(Unknown Operator)"){
                        titoloColonnina = NSLocalizedString("Unknown Company", comment: "Compagnia sconosciuta")
                    }
                    else{
                        titoloColonnina = (nearestPoi![i].OperatorInfo?.Title!)!
                    }
                    poi[i].title = titoloColonnina
                    //Calcolo tipo di plug
                    var tipidiplug: String = ""
                    for c in 0..<nearestPoi![i].Connections!.count - 1{
                        if (c != 0){
                            if(nearestPoi![i].Connections![c].ConnectionType?.Title == "Unknown"){
                                tipidiplug =  tipidiplug + ", " + NSLocalizedString("Unknown Plug", comment: "Plug Sconosciuto")
                            }
                            else{
                                tipidiplug = tipidiplug + ", " + (nearestPoi![i].Connections![c].ConnectionType?.Title ?? "Not specified")
                            }
                        }
                        else{
                            if(nearestPoi![i].Connections![c].ConnectionType?.Title == "Unknown"){
                                tipidiplug = NSLocalizedString("Unknown Plug", comment: "Plug Sconosciuto")
                            }
                            else{
                                tipidiplug = nearestPoi![i].Connections![c].ConnectionType?.Title ?? "Not specified"
                            }
                            
                        }
                        poi[i].subtitle = tipidiplug
                        //
                        poi[i].summary = "Summary"
                        poi[i].detailTitle = "Detail Title"
                        poi[i].detailSubtitle = tipidiplug
                        poi[i].detailSummary = "Detail Summary"
                        poi[i].pinImage = UIImage()
                    }
                }
            }
            completion(nil)
        }
        task.taskDescription = "getCarPlayPoi"
        task.resume()
        session.finishTasksAndInvalidate()
    }
    /*
     
     func getNearestLevelPoi(latitude: Double, longitude: Double, levelId: Int) {
     let url = URL(string: "https:api.openchargemap.io/v3/poi/?output=json&countrycode=IT&latitude=\(latitude)&longitude=\(longitude)&LevelID=\(levelId)&maxresults=30")!
     
     let task = URLSession.shared.dataTask(with: url) { data, _, _ in
     guard let data = data else { return }
     self.readJson(data: data)
     print(String(data: data, encoding: .utf8)!)
     }
     
     task.resume()
     }
     
     func getNearestConnectorPoi(latitude: Double, longitude: Double, connectionTypeId: Int) {
     let url = URL(string: "https:api.openchargemap.io/v3/poi/?output=json&countrycode=IT&latitude=\(latitude)&longitude=\(longitude)&ConnectionTypeId=\(connectionTypeId)&maxresults=30")!
     
     let task = URLSession.shared.dataTask(with: url) { data, _, _ in
     guard let data = data else { return }
     self.readJson(data: data)
     print(String(data: data, encoding: .utf8)!)
     }
     
     task.resume()
     }
     
     func getNearestTeslaPoi(latitude: Double, longitude: Double) {
     let url = URL(string: "https:api.openchargemap.io/v3/poi/?output=json&countrycode=IT&latitude=\(latitude)&longitude=\(longitude)&operatorid=23&maxresults=30")!
     
     let task = URLSession.shared.dataTask(with: url) { data, _, _ in
     guard let data = data else { return }
     self.readJson(data: data)
     print(String(data: data, encoding: .utf8)!)
     }
     
     task.resume()
     }
     
     Tesla operatorID 23 , Enel 80
     func getNearestOperatorPoi(latitude: Double, longitude: Double, operatorId: Int) {
     let url = URL(string: "https:api.openchargemap.io/v3/poi/?output=json&countrycode=IT&latitude=\(latitude)&longitude=\(longitude)&operatorid=\(operatorId)&maxresults=30")!
     
     let task = URLSession.shared.dataTask(with: url) { data, _, _ in
     guard let data = data else { return }
     self.readJson(data: data)
     print(String(data: data, encoding: .utf8)!)
     }
     
     task.resume()
     }
     
     func getNearestEnelPoi(latitude: Double, longitude: Double) {
     let url = URL(string: "https:api.openchargemap.io/v3/poi/?output=json&countrycode=IT&latitude=\(latitude)&longitude=\(longitude)&operatorid=80&maxresults=30")!
     
     let task = URLSession.shared.dataTask(with: url) { data, _, _ in
     guard let data = data else { return }
     self.readJson(data: data)
     print(String(data: data, encoding: .utf8)!)
     }
     
     task.resume()
     }
     
     func getPoiInADistanceRange(latitude: Double, longitude: Double, range: Float) {
     let url = URL(string: "https:api.openchargemap.io/v3/poi/?output=json&countrycode=IT&latitude=\(latitude)&longitude=\(longitude)&distance=\(range)&maxresults=30")!
     
     let task = URLSession.shared.dataTask(with: url) { data, _, _ in
     guard let data = data else { return }
     self.readJson(data: data)
     print(String(data: data, encoding: .utf8)!)
     }
     
     task.resume()
     }
     */
    
    func getPoiForAFilter(filters : [(filterName : String,  filterValues : [String])])
    {
        var stringa : String = ""
        var i : Int = 1
        for elem in filters
        {
            stringa += "&" + elem.filterName + "=" + elem.filterValues[0]
            i=1
            while(i<elem.filterValues.count)
            {
                stringa += "," + elem.filterValues[i]
                i+=1
            }
        }
        
        let url = URL(string: "https://api.openchargemap.io/v3/poi/?output=json&key=bb711b10-cc7d-4a83-919f-f8edeb10d2b8"+stringa)!
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            guard (error == nil) else { return }
            self!.readJson(data: data!){ (error) in
                guard error==nil else {
                    print(error!.localizedDescription)
                    return
                }
            }
            print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
    }
    
    func readJson(data: Data, completion: @escaping (Error?)->()) {
        var poiData1 = [PoiData]()
        do {
            let decoder: JSONDecoder = JSONDecoder()
            poiData1 = try decoder.decode([PoiData].self, from: data)
            if poiData == nil{
                poiData = poiData1
                print("era vuoto")
            }
            var i = 0
            if (poiData1.count) > 0{
                while (i < (poiData1.count)) {
                    //                    print(poiData?.count)
                    //                    print(poiData1.count)
                    //                    print(i)
                    if (i < poiData1.count){
                        group.enter()
                        if (!poiData!.contains(where: {$0.ID == poiData1[i].ID})){
                            self.insert(poi: poiData1[i]){ (result, error) in
                                guard error==nil else {
                                    return
                                }
                                let string = group.debugDescription
                                var differenza = 0
                                let needle: Character = "{"
                                if let idx = string.firstIndex(of: needle) {
                                    let pos = string.distance(from: string.startIndex, to: idx)
                                    differenza = pos - 41
                                }
                                let start = String.Index(utf16Offset: 53 + differenza, in: string)
                                let end = String.Index(utf16Offset: 60 + differenza, in: string)
                                let substring = String(string[start..<end])
                                if(substring == "ref = 2"){
                                    group.leave()
                                    i = i + 1
                                }
                            }
                            let string = group.debugDescription
                            var differenza = 0
                            let needle: Character = "{"
                            if let idx = string.firstIndex(of: needle) {
                                let pos = string.distance(from: string.startIndex, to: idx)
                                differenza = pos - 41
                            }
                            let start = String.Index(utf16Offset: 53 + differenza, in: string)
                            let end = String.Index(utf16Offset: 60 + differenza, in: string)
                            let substring = String(string[start..<end])
                            if(substring == "ref = 2"){
                                if group.wait(timeout: .now() + 0.7) == .timedOut{
                                    group.leave()
                                    i = i + 1
                                }
                            }
                        }
                        else{
                            let string = group.debugDescription
                            var differenza = 0
                            let needle: Character = "{"
                            if let idx = string.firstIndex(of: needle) {
                                let pos = string.distance(from: string.startIndex, to: idx)
                                differenza = pos - 41
                            }
                            let start = String.Index(utf16Offset: 53 + differenza, in: string)
                            let end = String.Index(utf16Offset: 60 + differenza, in: string)
                            let substring = String(string[start..<end])
                            if(substring == "ref = 2"){
                                group.leave()
                            }
                            i = i + 1
                        }
                    }
                    else {
                        i = i + 1
                    }
                }
            }
            do {
                try self.poiCache!.saveToDisk(withName: "poiCache")
            }
            catch{
                print(error)
            }
        }catch {
            print(error)
        }
        completion(nil)
    }
}
