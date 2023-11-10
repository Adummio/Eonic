//
//  ModalExtension.swift
//  Eonic
//
//  Created by Antonio Ferraioli on 15/03/2020.
//  Copyright © 2020 Antonio Ferraioli. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

extension MapViewController{
    // Enum for card states
    // Variable determines the next state of the card expressing that the card starts and collapased
    public var nextDetailState:CardState {
        return detailCardVisible ? .collapsed : .expanded
    }
    public var nextDetailState2:CardState {
        return detailCardVisible ? .dismissed : .collapsed
    }
    public var nextSearchState:CardState {
        return searchCardVisible ? .collapsed : .expanded
    }
    public var nextSearchState2:CardState {
        return searchCardVisible ? .collapsed : .expanded
    }
    
    func checkNotifications() -> Bool{
        var stato = false
        
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if(settings.authorizationStatus == .authorized){
                stato = true
            }
        }
        return stato
    }
    
    func setupDetailCard(completion: @escaping (Error?)->()) {
        
        // Setup starting and ending card height
        endCardHeight = self.view.frame.height * 0.8
        startCardHeight = self.view.frame.height * 0.4
        
        // Add CardViewController xib to the bottom of the screen, clipping bounds so that the corners can be rounded
        
        cardViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CardViewController") as? CardViewController
        self.view.insertSubview(cardViewController.view, at: 4)
//        self.view.addSubview(cardViewController.view)
        cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.bounds.width, height: endCardHeight)
        detailState = "dismissed"
        cardViewController.view.clipsToBounds = true
        cardViewController.view.layer.cornerRadius = 10
        
        // Add pan recognizers
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(MapViewController.handleCardPan(recognizer:)))
        cardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
        completion(nil)
    }
    
    func setupSearchCard(completion: @escaping (Error?)->()){
        endCardHeight = self.view.frame.height * 0.8
        searchCardHeight = self.view.frame.height * 0.13
        
        searchViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        self.view.insertSubview(searchViewController.view, at: 4)
//        self.view.addSubview(searchViewController.view)
        searchViewController.view.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.bounds.width, height: endCardHeight)
        searchState = "collapsed"
        searchViewController.view.clipsToBounds = true
        searchViewController.view.layer.cornerRadius = 10
        
        // Add tap and pan recognizers
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(MapViewController.handleSearchCardPan(recognizer:)))
        searchViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
        completion(nil)
    }
    
    // Handle pan gesture recognizer
    @objc
    func handleCardPan (recognizer:UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            // Start animation if pan begins
            let translation = recognizer.velocity(in: self.cardViewController.handleArea)
            if (translation.y > 0 && detailState == "expanded"){
                detailCardVisible = true
                self.startInteractiveTransition(state: nextDetailState, duration: 0.9)
            }
            else if (translation.y < 0 && detailState == "dismissed"){
                detailCardVisible = false
                self.startInteractiveTransition(state: nextDetailState2, duration: 0.9)
            }
            else if (translation.y < 0 && detailState == "collapsed"){
                detailCardVisible = false
                self.startInteractiveTransition(state: nextDetailState, duration: 0.9)
                searchCardVisible = true
                self.startSearchInteractiveTransition(state: nextSearchState2, duration: 0.9)
            }
            else if (translation.y > 0 && detailState == "collapsed"){
                detailCardVisible = true
                self.startInteractiveTransition(state: nextDetailState2, duration: 0.9)
                searchCardVisible = false
                self.startInteractiveTransition(state: nextSearchState2, duration: 0.9)
            }
            
        case .changed:
            // Update the translation according to the percentage completed
            let translation = recognizer.translation(in: self.cardViewController.handleArea)
            var fractionComplete = translation.y / endCardHeight
            fractionComplete = detailCardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            // End animation when pan ends
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    // Handle pan gesture recognizer
    @objc
    func handleSearchCardPan (recognizer:UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            // Start animation if pan begins
            let translation = recognizer.velocity(in: self.searchViewController.handleArea)
            if (translation.y > 0 && searchState == "expanded"){
                searchCardVisible = true
                searchViewController.doneButtonAction()
                self.startSearchInteractiveTransition(state: nextSearchState, duration: 0.9)
            }
            else if (translation.y < 0 && searchState == "collapsed"){
                searchCardVisible = false
                self.startSearchInteractiveTransition(state: nextSearchState, duration: 0.9)
            }
            
        case .changed:
            // Update the translation according to the percentage completed
            let translation = recognizer.translation(in: self.searchViewController.handleArea)
            var fractionComplete = translation.y / endCardHeight
            fractionComplete = searchCardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            // End animation when pan ends
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    func animateOnSearchButton(duration: TimeInterval){
        if runningAnimations.isEmpty{
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1){
                self.detailState = "dismissed"
                self.detailCardVisible = false
                self.searchCardVisible = true
                self.searchState = "expanded"
                self.searchViewController.view.frame.origin.y = self.view.frame.height - self.endCardHeight
                self.cardViewController.view.frame.origin.y = self.view.frame.height
                self.searchButton.setImage(UIImage(named: "SearchButtonSelected"), for: UIControl.State.normal)
            }
            
            frameAnimator.addCompletion { _ in
                self.runningAnimations.removeAll()
            }
            // Start animation
            frameAnimator.startAnimation()
            // Append animation to running animations
            runningAnimations.append(frameAnimator)
        }
    }
    
    // Animate transistion function
    func animateTransitionIfNeeded(state:CardState, duration:TimeInterval) {
        // Check if frame animator is empty
        if runningAnimations.isEmpty {
            // Create a UIViewPropertyAnimator depending on the state of the popover view
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    // If expanding set popover y to the ending height and blur background
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.endCardHeight
                    self.detailState = "expanded"
                    
                case .collapsed:
                    // If collapsed set popover y to the starting height and remove background blur
                    self.searchViewController.view.frame.origin.y = self.view.frame.height
                    self.searchState = "dismissed"
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.startCardHeight
                    self.detailState = "collapsed"
                    
                case .dismissed:
                    self.searchViewController.view.frame.origin.y = self.view.frame.height - self.searchCardHeight
                    self.searchState = "collapsed"
                    self.cardViewController.view.frame.origin.y = self.view.frame.height
                    self.detailState = "dismissed"
                }
            }
            
            // Complete animation frame
            frameAnimator.addCompletion { _ in
                self.runningAnimations.removeAll()
                if state == .dismissed{
                }
            }
            // Start animation
            frameAnimator.startAnimation()
            // Append animation to running animations
            runningAnimations.append(frameAnimator)
        }
    }
    
    // Animate transistion function
    public func animateSearchTransitionIfNeeded(state:CardState, duration:TimeInterval) {
        // Check if frame animator is empty
        if runningAnimations.isEmpty {
            // Create a UIViewPropertyAnimator depending on the state of the popover view
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    // If expanding set popover y to the ending height and blur background
                    self.searchViewController.view.frame.origin.y = self.view.frame.height - self.endCardHeight
                    self.searchState = "expanded"
                    self.searchButton.setImage(UIImage(named: "SearchButtonSelected"), for: UIControl.State.normal)
                    
                case .collapsed:
                    // If collapsed set popover y to the starting height and remove background blur
                    self.searchViewController.view.frame.origin.y = self.view.frame.height - self.searchCardHeight
                    self.searchState = "collapsed"
                    self.searchButton.setImage(UIImage(named: "SearchButtonUnselected"), for: UIControl.State.normal)
                    
                    
                case .dismissed:
                    self.searchViewController.view.frame.origin.y = self.view.frame.height - self.searchCardHeight
                    self.searchState = "collapsed"
                    self.searchButton.setImage(UIImage(named: "SearchButtonUnselected"), for: UIControl.State.normal)
                }
            }
            
            // Complete animation frame
            frameAnimator.addCompletion { _ in
                self.runningAnimations.removeAll()
            }
            // Start animation
            frameAnimator.startAnimation()
            // Append animation to running animations
            runningAnimations.append(frameAnimator)
        }
    }
    
    // Function to start interactive animations when view is dragged
    func startInteractiveTransition(state:CardState, duration:TimeInterval) {
        
        // If animation is empty start new animation
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        // For each animation in runningAnimations
        for animator in runningAnimations {
            // Pause animation and update the progress to the fraction complete percentage
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    func startSearchInteractiveTransition(state:CardState, duration:TimeInterval) {
        
        // If animation is empty start new animation
        if runningAnimations.isEmpty {
            animateSearchTransitionIfNeeded(state: state, duration: duration)
        }
        // For each animation in runningAnimations
        for animator in runningAnimations {
            // Pause animation and update the progress to the fraction complete percentage
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    // Funtion to update transition when view is dragged
    func updateInteractiveTransition(fractionCompleted:CGFloat) {
        // For each animation in runningAnimations
        for animator in runningAnimations {
            // Update the fraction complete value to the current progress
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    // Function to continue an interactive transisiton
    func continueInteractiveTransition(){
        // For each animation in runningAnimations
        for animator in runningAnimations {
            // Continue the animation forwards or backwards
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
}

