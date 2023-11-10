//
//  SearchViewController.swift
//  Eonic
//
//  Created by Yuri Spaziani on 02/03/2020.
//  Copyright © 2020 Antonio Ferraioli. All rights reserved.
//

import UIKit
import MapKit

protocol searchControllerDelegate{
    func animateSearchTransitionIfNeeded(state:CardState, duration:TimeInterval)
    func zoomOnRegion(cordinate: CLLocationCoordinate2D)
    var searchState: String { get }
    var searchCardVisible: Bool { get set }
    var nextSearchState:CardState { get }
    var mappaView:MKMapView! { get }
}

class HeadlineTableViewCell: UITableViewCell {
    @IBOutlet weak var headlineTextLabel: UILabel!
    @IBOutlet weak var headlineDetailLabel: UILabel!
}

class SearchViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var separatorLine: UIView!
    @IBOutlet weak var mysearchBar: UISearchBar!
    @IBOutlet var tableViewTotal: UITableView!
    @IBOutlet var viewtotal: UIView!
    
    var delegate:searchControllerDelegate!
    var matchingItems: [MKMapItem] = []
    
    override public func viewDidLoad() {
        mysearchBar.delegate = self
        aggiungiDoneKeyboard()
        if self.traitCollection.userInterfaceStyle == .dark{
            let blurEffect = UIBlurEffect(style: .prominent)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = view.bounds
            viewtotal.backgroundColor = .clear
            view.insertSubview(blurEffectView, at: 0)
        }
        else{
            viewtotal.backgroundColor = .white
        }
        super.viewDidLoad()
        separatorLine.layer.cornerRadius = 3
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if self.traitCollection.userInterfaceStyle == .dark{
            let blurEffect = UIBlurEffect(style: .prominent)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = view.bounds
            viewtotal.backgroundColor = .clear
            view.insertSubview(blurEffectView, at: 0)
        }
        else{
            //            tableViewTotal.backgroundView?.removeFromSuperview()
            viewtotal.backgroundColor = .white
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        cercaInMappa(searchBar: searchBar)
        doneButtonAction()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if delegate.searchState == "collapsed"{
            delegate.searchCardVisible = false
            delegate.animateSearchTransitionIfNeeded(state: delegate.nextSearchState, duration: 0.5)
        }
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        cercaInMappa(searchBar: searchBar)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        cercaInMappa(searchBar: searchBar)
    }
    
    func cercaInMappa(searchBar: UISearchBar){
        guard let mapView = delegate.mappaView,
            let searchBarText = searchBar.text else { return }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableViewTotal.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! HeadlineTableViewCell
        //        let headline = headlines[indexPath.row]
        //        cell.headlineTextLabel?.text = headline.id
        //        cell.headlineDetailLabel.text = headline.title
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.headlineTextLabel.text = selectedItem.name
        var address = String()
        if(selectedItem.thoroughfare != nil){
            address = "\(selectedItem.thoroughfare!), "
        }
        if(selectedItem.locality != nil){
            address = address + "\(selectedItem.locality!), "
        }
        if(selectedItem.administrativeArea != nil){
            address = address + "\(selectedItem.administrativeArea!), "
        }
        if(selectedItem.postalCode != nil){
            address = address + "\(selectedItem.postalCode!), "
        }
        if(selectedItem.country != nil){
            address = address + "\(selectedItem.country!)"
        }
        cell.headlineDetailLabel.text = address
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        mysearchBar.text = ""
        matchingItems.removeAll()
        self.tableViewTotal.reloadData()
        delegate.searchCardVisible = true
        doneButtonAction()
        delegate.animateSearchTransitionIfNeeded(state: delegate.nextSearchState, duration: 0.5)
        delegate.zoomOnRegion(cordinate: selectedItem.coordinate)
//        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func aggiungiDoneKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Done", comment: "Fatto"), style: .plain, target: self, action: #selector(self.doneButtonAction))
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        mysearchBar.inputAccessoryView = doneToolbar
    }
    
    @objc public func doneButtonAction() {
        self.view.endEditing(true)
    }
}
