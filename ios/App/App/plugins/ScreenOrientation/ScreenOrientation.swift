//
//  ScreenOrientation.swift
//  App
//
//  Created by Shiva Prasad on 26/05/2024.
//

import Foundation
import UIKit

public class ScreenOrientation: NSObject {

    public func getCurrentOrientationType() -> String {
        let currentOrientation: UIDeviceOrientation = UIDevice.current.orientation
        return fromDeviceOrientationToOrientationType(currentOrientation)
    }
    
    public func lock(_ orientationType: String, completion: @escaping (UIInterfaceOrientationMask) -> Void) {
        DispatchQueue.main.async {
            let mask = self.fromOrientationTypeToMask(orientationType)
            let orientation = self.fromOrientationTypeToInt(orientationType)
            UIDevice.current.setValue(orientation, forKey: "orientation")
            UINavigationController.attemptRotationToDeviceOrientation()
            completion(mask)
        }
    }
    
    public func unlock(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            let unknownOrientation = UIInterfaceOrientation.unknown.rawValue
            UIDevice.current.setValue(unknownOrientation, forKey: "orientation")
            UINavigationController.attemptRotationToDeviceOrientation()
            completion()
        }
    }

    private func fromDeviceOrientationToOrientationType(_ orientation: UIDeviceOrientation) -> String {
        switch orientation {
            case .landscapeLeft:
                return "landscape-primary"
            case .landscapeRight:
                return "landscape-secondary"
            case .portraitUpsideDown:
                return "portrait-secondary"
            default:
                // Case: portrait
                return "portrait-primary"
        }
    }
    
    private func fromOrientationTypeToMask(_ orientationType: String) -> UIInterfaceOrientationMask {
        switch orientationType {
            case "landscape-primary":
                return UIInterfaceOrientationMask.landscapeLeft
            case "landscape-secondary":
                return UIInterfaceOrientationMask.landscapeRight
            case "portrait-secondary":
                return UIInterfaceOrientationMask.portraitUpsideDown
            default:
                // Case: portrait-primary
                return UIInterfaceOrientationMask.portrait
        }
    }
    
    private func fromOrientationTypeToInt(_ orientationType: String) -> Int {
        switch orientationType {
            case "landscape-primary":
                return UIInterfaceOrientation.landscapeLeft.rawValue
            case "landscape-secondary":
                return UIInterfaceOrientation.landscapeRight.rawValue
            case "portrait-secondary":
                return UIInterfaceOrientation.portraitUpsideDown.rawValue
            default:
                // Case: portrait-primary
                return UIInterfaceOrientation.portrait.rawValue
        }
    }

}
