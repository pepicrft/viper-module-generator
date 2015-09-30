//
//  TwitterLoginView.swift
//  TwitterLoginGenDemo
//
//  Created by AUTHOR on 24/10/14.
//  Copyright (c) 2014 AUTHOR. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

class TwitterLoginView: TWViewController, TwitterLoginViewProtocol
{
    // MARK: - Styles
    private struct Styles {
        static private let LOGIN_BUTTON_HEITHT: CGFloat = 50
        static private let LOGIN_BUTTON_COLOR: UIColor = Stylesheet.COLOR_BLUE_LIGHT
        static private let FLOATING_CORNER_RADIUS: CGFloat = 10
        static private let FLOATING_HEIGHT_PERCENTAGE: CGFloat = 0.3
        static private let FLOATING_WIDTH_PERCENTAGE: CGFloat = 0.8
        static private let LOGO_SIZE: CGFloat = 80
        static private let MARGIN_20: CGFloat = 20
    }
    
    
    // MARK: - Attributes
    
    var presenter: TwitterLoginPresenterProtocol?
    lazy var backgroundVideoPlayer: MPMoviePlayerController = {
        var moviePlayer = MPMoviePlayerController(contentURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("video", ofType: "mp4")!))
        moviePlayer.controlStyle = MPMovieControlStyle.None
        moviePlayer.repeatMode = MPMovieRepeatMode.One
        moviePlayer.scalingMode = MPMovieScalingMode.AspectFill
        return moviePlayer
    }()
    lazy var logoImageView: UIImageView = UIImageView()
    lazy var loginButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = Styles.LOGIN_BUTTON_COLOR
        return button
    }()
    
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        self.setupSubviews()
        self.setupConstraints()
        self.setNeedsStatusBarAppearanceUpdate()
        self.presenter?.viewDidLoad()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.backgroundVideoPlayer.stop()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.backgroundVideoPlayer.play()
    }
    
    // MARK: - Subviews
    
    /**
     Setup subviews and add them to the main View
     */
    private func setupSubviews()
    {
        self.backgroundVideoPlayer.play()
        self.view.addSubview(self.backgroundVideoPlayer.view)
        self.view.addSubview(self.loginButton)
        self.loginButton.addTarget(self, action: Selector("userDidSelectLogin:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.logoImageView)
    }
    
    /**
    Add Autolayouts constraints to subviews
    */
    private func setupConstraints()
    {
        self.backgroundVideoPlayer.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.backgroundVideoPlayer.view.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero)
        self.loginButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.loginButton.autoMatchDimension(ALDimension.Width, toDimension: ALDimension.Width, ofView: self.view, withMultiplier: 0.8)
        self.loginButton.autoSetDimension(ALDimension.Height, toSize: Styles.LOGIN_BUTTON_HEITHT)
        self.loginButton.autoCenterInSuperview()
        self.logoImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.logoImageView.autoSetDimension(ALDimension.Height, toSize: Styles.LOGO_SIZE)
        self.logoImageView.autoSetDimension(ALDimension.Width, toSize: Styles.LOGO_SIZE)
        self.logoImageView.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: self.loginButton)
        self.logoImageView.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Top, ofView: self.loginButton, withOffset: -Styles.MARGIN_20)
    }
    
    
    // MARK: - TwitterLoginViewProtocol
    
    func setLoginTitle(let title: String)
    {
        self.loginButton.setTitle(title, forState: UIControlState.Normal)
    }
    
    func setLogo(let image: UIImage)
    {
        self.logoImageView.image = image
        self.logoImageView.tintColor = UIColor.whiteColor()
    }
    
    func showError(let errorMessage: String)
    {
        ProgressHUD.showError(errorMessage)
    }
    
    func showLoading()
    {
        ProgressHUD.show("")
    }
    
    func hideLoading()
    {
        ProgressHUD.dismiss()
    }
    
    
    // MARK: Actions
    
    /**
    Notifies the selector about the user's action
    */
    func userDidSelectLogin(sender: AnyObject)
    {
        self.presenter?.userDidSelectLogin()
    }
    
    
    // MARK: - Status Bar
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}