//
//  CarPlaySceneDelegate.swift
//  Eonic
//
//  Created by Antonio Ferraioli on 02/02/21.
//  Copyright © 2021 Antonio Ferraioli. All rights reserved.
//

import CarPlay

@available(iOS 14.0, *)
var poi = [CPPointOfInterest(
    location: MKMapItem(placemark: MKPlacemark(coordinate: MKMapView().centerCoordinate)),
    title: "Sample Location",
    subtitle: "Subtitle",
    summary: "Summary",
    detailTitle: "Detail Title",
    detailSubtitle: "Detail subtitle",
    detailSummary: "Detail Summary",
    pinImage: UIImage()
)]

@available(iOS 14.0, *)
class CarPlaySceneDelegate: CPPointOfInterestTemplate, CPTemplateApplicationSceneDelegate, CPPointOfInterestTemplateDelegate {
    
    func pointOfInterestTemplate(_ pointOfInterestTemplate: CPPointOfInterestTemplate, didChangeMapRegion region: MKCoordinateRegion) {
        
        poiManager.getCarPlayPoi(latitude: region.center.latitude, longitude: region.center.longitude){ (error) in
            guard error==nil else {
                print(error!.localizedDescription)
                return
            }
            let mappaview = CPPointOfInterestTemplate(title: "Test", pointsOfInterest: poi, selectedIndex: 0)
            for i in 0...(poi.count - 1){
                poi[i].primaryButton = CPTextButton(
                    title: "GO",
                    textStyle: .normal
        //            handler: { _ in item.openInMaps()}
                )
            }
            self.interfaceController?.setRootTemplate(mappaview, animated: true)
        }
    }
    
    var interfaceController: CPInterfaceController?
    
    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didConnect interfaceController: CPInterfaceController) {
        self.interfaceController = interfaceController
        
//        let mapItem = MKMapItem(placemark: ...)

        poi[0].primaryButton = CPTextButton(
            title: "GO",
            textStyle: .normal
//            handler: { _ in item.openInMaps()}
        )
        
        let mappaview = CPPointOfInterestTemplate(title: "Test", pointsOfInterest: poi, selectedIndex: 0)
        mappaview.pointOfInterestDelegate = self
//        mappaview.showPanningInterface(animated: true)

        self.interfaceController?.setRootTemplate(mappaview, animated: true)
    }
    
    
}
