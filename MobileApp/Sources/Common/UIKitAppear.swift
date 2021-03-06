//
//  UIKitAppear.swift
//  MobileApp
//
//  Created by Mariusz Sut on 05/03/2021.
//  Copyright © 2021 MSut. All rights reserved.
//

import UIKit
import SwiftUI

/*
 Workaround for a bug with SwiftUI.View.onAppear {} and SwiftUI.View.onDisappear {}
 https://developer.apple.com/forums/thread/655338
 */
struct UIKitAppear: UIViewControllerRepresentable {
    let viewDidAppear: () -> Void
    let viewDidDisappear: () -> Void
    
    func makeUIViewController(context: Context) -> UIAppearViewController {
        let vc = UIAppearViewController()
        vc.viewDidAppear = viewDidAppear
        vc.viewDidDisappear = viewDidDisappear
        return vc
    }
    func updateUIViewController(_ controller: UIAppearViewController, context: Context) { /*nop*/ }
}

final class UIAppearViewController: UIViewController {
    var viewDidAppear: () -> Void = {}
    var viewDidDisappear: () -> Void = {}
    
    override func viewDidLoad() {
        view.addSubview(UILabel())
    }
    override func viewDidAppear(_ animated: Bool) {
        viewDidAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        viewDidDisappear()
    }
}

public extension View {
    func uiKitOnAppear(_ perform: @escaping () -> Void) -> some View {
        background(UIKitAppear(viewDidAppear: perform, viewDidDisappear: {/*nop*/}))
    }
    
    func uiKitOnDisappear(_ perform: @escaping () -> Void) -> some View {
        background(UIKitAppear(viewDidAppear: {/*nop*/}, viewDidDisappear: perform))
    }
}
