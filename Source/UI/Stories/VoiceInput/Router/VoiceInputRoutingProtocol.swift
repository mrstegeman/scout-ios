//
//  VoiceInputRoutingProtocol.swift
//  Scout
//
//  Created by Shurupov Alex on 5/20/18.
//

import Foundation
import UIKit

protocol VoiceInputRoutingProtocol {
    var linkIsFound: ((ScoutArticle, Bool) -> Void)? { get set }
    func show(from viewController: UIViewController, animated: Bool, userID: String)
}
