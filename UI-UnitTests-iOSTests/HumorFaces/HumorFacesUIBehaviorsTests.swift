//
//  HumorFacesUIBehaviorsTests.swift
//  UIUnitTestsIOS
//
//  Created by Abderrahim BENMAKHLOUF on 04/03/2018.
//  Copyright © 2018 Abderrahim Benmakhlouf. All rights reserved.
//

import XCTest
import Quick
import Nimble
import UIKit

@testable import UIUnitTestsIOS

final class HumorFacesUIBehaviorsTests: QuickSpec {
    
    public var humorFacesViewControllerMock: HumorFacesViewControllerMock!
    var navigationController: UINavigationController?
    
    override func spec() {
        describe("GIVEN that I have no internet connection") {
            beforeEach {
                self.humorFacesViewControllerMock = HumorFacesViewControllerMock.fromStoryboard(named: "HumorFacesMock")
                self.navigationController = UINavigationController(rootViewController: self.humorFacesViewControllerMock)
                // The line bellow, allow us to have our viewcontroller on the window to be able to have access and test all the presented view controllers like UIAlertController and modal views.
                UIApplication.shared.keyWindow?.rootViewController = self.navigationController
                // The line bellow, allow us to mock the network state
                self.humorFacesViewControllerMock.updateNetworkState(.networkError)
            }
            context("WHEN I access the Humor Faces page") {
                var alertController: UIAlertController? = nil
                beforeEach {
                    // The layout subviews will call automatically the viewDidLoad function and create all the outlets to be able to test them
                    self.humorFacesViewControllerMock.view.layoutSubviews()
                    alertController = self.humorFacesViewControllerMock.presentedViewController as? UIAlertController
                }
                it("THEN it should display a popup") {
                    expect(alertController).toNotEventually(beNil())
                }
                it("AND the popup title must be 'Network Problem'") {
                    expect(alertController?.title).to(equal("Network Problem"))
                }
                it("AND the popup message must be 'It seems that you have no Internet connection.'") {
                    expect(alertController?.message).to(equal("It seems that you have no Internet connection."))
                }
                it("AND the popup confirmation title must be 'OK'") {
                    let okAction = alertController?.actions.last as? AlertActionMock
                    expect(okAction?._title).to(equal("OK"))
                    expect(okAction?._style).to(equal(UIAlertActionStyle.default))
                }
            }
        }
        describe("GIVEN that the server has internal error") {
            beforeEach {
                self.humorFacesViewControllerMock = HumorFacesViewControllerMock.fromStoryboard(named: "HumorFacesMock")
                self.navigationController = UINavigationController(rootViewController: self.humorFacesViewControllerMock)
                // The line bellow, allow us to have our viewcontroller on the window to be able to have access and test all the presented view controllers like UIAlertController and modal views.
                UIApplication.shared.keyWindow?.rootViewController = self.navigationController
                // The line bellow, allow us to mock the server error state
                self.humorFacesViewControllerMock.updateNetworkState(.serverError)
            }
            context("WHEN I access the Humor Faces page") {
                var alertController: UIAlertController? = nil
                beforeEach {
                    // The layout subviews will call automatically the viewDidLoad function and create all the outlets to be able to test them
                    self.humorFacesViewControllerMock.view.layoutSubviews()
                    alertController = self.humorFacesViewControllerMock.presentedViewController as? UIAlertController
                }
                it("THEN it should display a popup") {
                    expect(alertController).toNotEventually(beNil())
                }
                it("AND the popup title must be 'Oops! Something went wrong!'") {
                    expect(alertController?.title).to(equal("Oops! Something went wrong!"))
                }
                it("AND the popup message must be 'The application has encountered an unknown error.'") {
                    expect(alertController?.message).to(equal("The application has encountered an unknown error."))
                }
                it("AND the popup confirmation title must be 'OK'") {
                    let okAction = alertController?.actions.last as? AlertActionMock
                    expect(okAction?._title).to(equal("OK"))
                    expect(okAction?._style).to(equal(UIAlertActionStyle.default))
                }
            }
        }
        describe("GIVEN that the popup alert is displayed") {
            var alertController: UIAlertController? = nil
            beforeEach {
                self.humorFacesViewControllerMock = HumorFacesViewControllerMock.fromStoryboard(named: "HumorFacesMock")
                self.navigationController = UINavigationController(rootViewController: self.humorFacesViewControllerMock)
                // The line bellow, allow us to have our viewcontroller on the window to be able to have access and test all the presented view controllers like UIAlertController and modal views.
                UIApplication.shared.keyWindow?.rootViewController = self.navigationController
                // The line bellow, allow us to mock the network state
                self.humorFacesViewControllerMock.updateNetworkState(.networkError)
                self.humorFacesViewControllerMock.view.layoutSubviews()
                alertController = self.humorFacesViewControllerMock.presentedViewController as? UIAlertController
            }
            context("WHEN I click on the popup alert ok button") {
                beforeEach {
                    let okAction = alertController?.actions.last as? AlertActionMock
                    okAction?.handler?(okAction!)
                    alertController?.dismiss(animated: true, completion: nil)
                }
                it("THEN it should dismiss the popup alert") {
                    expect(self.humorFacesViewControllerMock.didDismissAlertViewController).toEventually(beTrue())
                    expect(self.humorFacesViewControllerMock.presentedViewController as? UIAlertController).toEventually(beNil())
                }
            }
        }
        describe("GIVEN that I am on the Humor Faces page") {
            var dashboardViewControllerMock: DashboardViewControllerMock!
            beforeEach {
                dashboardViewControllerMock = DashboardViewControllerMock.fromStoryboard(named: "DashboardMock")
                self.navigationController = UINavigationController(rootViewController: dashboardViewControllerMock)
                self.humorFacesViewControllerMock = HumorFacesViewControllerMock.fromStoryboard(named: "HumorFacesMock")
                // The line bellow, allow us to have our viewcontroller on the window to be able to have access and test all the presented view controllers like UIAlertController and modal views.
                dashboardViewControllerMock.performSegue(withIdentifier: "HumorFacesSegueIdentifier", sender: dashboardViewControllerMock)
                UIApplication.shared.keyWindow?.rootViewController = self.navigationController
            }
            context("WHEN I click on the back button") {
                beforeEach {
                    self.humorFacesViewControllerMock.navigationController?.popViewController(animated: true)
                }
                it("THEN The Humor Faces is closed AND I should go back to the dashboard page") {
                    let topViewController = (UIApplication.shared.keyWindow!.rootViewController! as! UINavigationController).viewControllers.last
                    expect(topViewController).toEventually(equal(dashboardViewControllerMock))
                }
            }
            context("WHEN I click on the refresh button AND the server responds with success") {
                beforeEach {
                    self.humorFacesViewControllerMock.updateHumorFaceType(.happy)
                    self.humorFacesViewControllerMock.updateNetworkState(.success)
                    self.humorFacesViewControllerMock.view.layoutSubviews()
                    self.humorFacesViewControllerMock.updateHumorFaceType(.surprised)
                    UIApplication.shared.sendAction(self.humorFacesViewControllerMock.navigationItem.rightBarButtonItem!.action!, to: self.humorFacesViewControllerMock.navigationItem.rightBarButtonItem?.target, from: self, for: nil)
                }
                it("THEN it should display the refreshed surprised humor description") {
                    expect(self.humorFacesViewControllerMock.humorDescriptionLabel?.text).toEventually(equal("Surprised Description"))
                }
                it("AND it should display the refreshed surprised humor image") {
                    expect(self.humorFacesViewControllerMock.humorFaceImageView?.image).toEventually(equal(UIImage(named: "surprised")))
                }
                it("AND it should display the refreshed surprised background color") {
                    expect(self.humorFacesViewControllerMock.view.backgroundColor).toEventually(equal(UIColor.surprisedFace))
                }
            }
            context("WHEN I click on the happy button") {
                beforeEach {
                    self.humorFacesViewControllerMock.updateHumorFaceType(.error)
                    self.humorFacesViewControllerMock.updateNetworkState(.success)
                    self.humorFacesViewControllerMock.view.layoutSubviews()
                    self.humorFacesViewControllerMock.happyFaceButton?.sendActions(for: .touchUpInside)
                }
                it("THEN it should display the happy humor description") {
                    expect(self.humorFacesViewControllerMock.humorDescriptionLabel?.text).toEventually(equal("Happy Description"))
                }
                it("AND it should display the happy humor image") {
                    expect(self.humorFacesViewControllerMock.humorFaceImageView?.image).toEventually(equal(UIImage(named: "happy")))
                }
                it("AND it should display the happy humor background color") {
                    expect(self.humorFacesViewControllerMock.view.backgroundColor).toEventually(equal(UIColor.happyFace))
                }
            }
            context("WHEN I click on the sad button") {
                beforeEach {
                    self.humorFacesViewControllerMock.updateHumorFaceType(.happy)
                    self.humorFacesViewControllerMock.updateNetworkState(.success)
                    self.humorFacesViewControllerMock.view.layoutSubviews()
                    self.humorFacesViewControllerMock.sadFaceButton?.sendActions(for: .touchUpInside)
                }
                it("THEN it should display the sad humor description") {
                    expect(self.humorFacesViewControllerMock.humorDescriptionLabel?.text).toEventually(equal("Sad Description"))
                }
                it("AND it should display the sad humor image") {
                    expect(self.humorFacesViewControllerMock.humorFaceImageView?.image).toEventually(equal(UIImage(named: "sad")))
                }
                it("AND it should display the sad humor background color") {
                    expect(self.humorFacesViewControllerMock.view.backgroundColor).toEventually(equal(UIColor.sadFace))
                }
            }
            context("WHEN I click on the angry button") {
                beforeEach {
                    self.humorFacesViewControllerMock.updateHumorFaceType(.sad)
                    self.humorFacesViewControllerMock.updateNetworkState(.success)
                    self.humorFacesViewControllerMock.view.layoutSubviews()
                    self.humorFacesViewControllerMock.angryFaceButton?.sendActions(for: .touchUpInside)
                }
                it("THEN it should display the angry humor description") {
                    expect(self.humorFacesViewControllerMock.humorDescriptionLabel?.text).toEventually(equal("Angry Description"))
                }
                it("AND it should display the angry humor image") {
                    expect(self.humorFacesViewControllerMock.humorFaceImageView?.image).toEventually(equal(UIImage(named: "angry")))
                }
                it("AND it should display the angry background color") {
                    expect(self.humorFacesViewControllerMock.view.backgroundColor).toEventually(equal(UIColor.angryFace))
                }
            }
            context("WHEN I click on the surprised button") {
                beforeEach {
                    self.humorFacesViewControllerMock.updateHumorFaceType(.angry)
                    self.humorFacesViewControllerMock.updateNetworkState(.success)
                    self.humorFacesViewControllerMock.view.layoutSubviews()
                    self.humorFacesViewControllerMock.surprisedFaceButton?.sendActions(for: .touchUpInside)
                }
                it("THEN it should display the surprised humor description") {
                    expect(self.humorFacesViewControllerMock.humorDescriptionLabel?.text).toEventually(equal("Surprised Description"))
                }
                it("AND it should display the surprised humor image") {
                    expect(self.humorFacesViewControllerMock.humorFaceImageView?.image).toEventually(equal(UIImage(named: "surprised")))
                }
                it("AND it should display the surprised background color") {
                    expect(self.humorFacesViewControllerMock.view.backgroundColor).toEventually(equal(UIColor.surprisedFace))
                }
            }
            context("WHEN I click on the curious button") {
                beforeEach {
                    self.humorFacesViewControllerMock.updateHumorFaceType(.surprised)
                    self.humorFacesViewControllerMock.updateNetworkState(.success)
                    self.humorFacesViewControllerMock.view.layoutSubviews()
                    self.humorFacesViewControllerMock.curiousFaceButton?.sendActions(for: .touchUpInside)
                }
                it("THEN it should display the no humor description") {
                    expect(self.humorFacesViewControllerMock.humorDescriptionLabel?.text).toEventually(equal("No Humor Found"))
                }
                it("AND it should display the no humor image") {
                    expect(self.humorFacesViewControllerMock.humorFaceImageView?.image).toEventually(equal(UIImage(named: "error_face")))
                }
                it("AND it should display the no background color") {
                    expect(self.humorFacesViewControllerMock.view.backgroundColor).toEventually(equal(.orange))
                }
            }
        }
        describe("GIVEN that the server responds with happy humor face type") {
            beforeEach {
                self.humorFacesViewControllerMock = HumorFacesViewControllerMock.fromStoryboard(named: "HumorFacesMock")
                self.navigationController = UINavigationController(rootViewController: self.humorFacesViewControllerMock)
                // The line bellow, allow us to have our viewcontroller on the window to be able to have access and test all the presented view controllers like UIAlertController and modal views.
                UIApplication.shared.keyWindow?.rootViewController = self.navigationController
                self.humorFacesViewControllerMock.updateNetworkState(.success)
                self.humorFacesViewControllerMock.updateHumorFaceType(.happy)
            }
            context("WHEN I access the Humor Faces page") {
                beforeEach {
                    // The layout subviews will call automatically the viewDidLoad function and create all the outlets to be able to test them
                    self.humorFacesViewControllerMock.view.layoutSubviews()
                }
                it("THEN it should display the happy humor description") {
                    expect(self.humorFacesViewControllerMock.humorDescriptionLabel?.text).toEventually(equal("Happy Description"))
                }
                it("AND it should display the happy humor image") {
                    expect(self.humorFacesViewControllerMock.humorFaceImageView?.image).toEventually(equal(UIImage(named: "happy")))
                }
                it("AND it should display the happy humor background color") {
                    expect(self.humorFacesViewControllerMock.view.backgroundColor).toEventually(equal(UIColor.happyFace))
                }
            }
        }
        describe("GIVEN that the server responds with sad humor face type") {
            beforeEach {
                self.humorFacesViewControllerMock = HumorFacesViewControllerMock.fromStoryboard(named: "HumorFacesMock")
                self.navigationController = UINavigationController(rootViewController: self.humorFacesViewControllerMock)
                // The line bellow, allow us to have our viewcontroller on the window to be able to have access and test all the presented view controllers like UIAlertController and modal views.
                UIApplication.shared.keyWindow?.rootViewController = self.navigationController
                self.humorFacesViewControllerMock.updateNetworkState(.success)
                self.humorFacesViewControllerMock.updateHumorFaceType(.sad)
            }
            context("WHEN I access the Humor Faces page") {
                beforeEach {
                    // The layout subviews will call automatically the viewDidLoad function and create all the outlets to be able to test them
                    self.humorFacesViewControllerMock.view.layoutSubviews()
                }
                it("THEN it should display the sad humor description") {
                    expect(self.humorFacesViewControllerMock.humorDescriptionLabel?.text).toEventually(equal("Sad Description"))
                }
                it("AND it should display the sad humor image") {
                    expect(self.humorFacesViewControllerMock.humorFaceImageView?.image).toEventually(equal(UIImage(named: "sad")))
                }
                it("AND it should display the sad humor background color") {
                    expect(self.humorFacesViewControllerMock.view.backgroundColor).toEventually(equal(UIColor.sadFace))
                }
            }
        }
        describe("GIVEN that the server responds with angry humor face type") {
            beforeEach {
                self.humorFacesViewControllerMock = HumorFacesViewControllerMock.fromStoryboard(named: "HumorFacesMock")
                self.navigationController = UINavigationController(rootViewController: self.humorFacesViewControllerMock)
                // The line bellow, allow us to have our viewcontroller on the window to be able to have access and test all the presented view controllers like UIAlertController and modal views.
                UIApplication.shared.keyWindow?.rootViewController = self.navigationController
                self.humorFacesViewControllerMock.updateNetworkState(.success)
                self.humorFacesViewControllerMock.updateHumorFaceType(.angry)
            }
            context("WHEN I access the Humor Faces page") {
                beforeEach {
                    // The layout subviews will call automatically the viewDidLoad function and create all the outlets to be able to test them
                    self.humorFacesViewControllerMock.view.layoutSubviews()
                }
                it("THEN it should display the angry humor description") {
                    expect(self.humorFacesViewControllerMock.humorDescriptionLabel?.text).toEventually(equal("Angry Description"))
                }
                it("AND it should display the angry humor image") {
                    expect(self.humorFacesViewControllerMock.humorFaceImageView?.image).toEventually(equal(UIImage(named: "angry")))
                }
                it("AND it should display the angry background color") {
                    expect(self.humorFacesViewControllerMock.view.backgroundColor).toEventually(equal(UIColor.angryFace))
                }
            }
        }
        describe("GIVEN that the server responds with surprised humor face type") {
            beforeEach {
                self.humorFacesViewControllerMock = HumorFacesViewControllerMock.fromStoryboard(named: "HumorFacesMock")
                self.navigationController = UINavigationController(rootViewController: self.humorFacesViewControllerMock)
                // The line bellow, allow us to have our viewcontroller on the window to be able to have access and test all the presented view controllers like UIAlertController and modal views.
                UIApplication.shared.keyWindow?.rootViewController = self.navigationController
                self.humorFacesViewControllerMock.updateNetworkState(.success)
                self.humorFacesViewControllerMock.updateHumorFaceType(.surprised)
            }
            context("WHEN I access the Humor Faces page") {
                beforeEach {
                    // The layout subviews will call automatically the viewDidLoad function and create all the outlets to be able to test them
                    self.humorFacesViewControllerMock.view.layoutSubviews()
                }
                it("THEN it should display the surprised humor description") {
                    expect(self.humorFacesViewControllerMock.humorDescriptionLabel?.text).toEventually(equal("Surprised Description"))
                }
                it("AND it should display the surprised humor image") {
                    expect(self.humorFacesViewControllerMock.humorFaceImageView?.image).toEventually(equal(UIImage(named: "surprised")))
                }
                it("AND it should display the surprised background color") {
                    expect(self.humorFacesViewControllerMock.view.backgroundColor).toEventually(equal(UIColor.surprisedFace))
                }
            }
        }
        describe("GIVEN that the server responds with no humor face type") {
            beforeEach {
                self.humorFacesViewControllerMock = HumorFacesViewControllerMock.fromStoryboard(named: "HumorFacesMock")
                self.navigationController = UINavigationController(rootViewController: self.humorFacesViewControllerMock)
                // The line bellow, allow us to have our viewcontroller on the window to be able to have access and test all the presented view controllers like UIAlertController and modal views.
                UIApplication.shared.keyWindow?.rootViewController = self.navigationController
                self.humorFacesViewControllerMock.updateNetworkState(.success)
                self.humorFacesViewControllerMock.updateHumorFaceType(.error)
            }
            context("WHEN I access the Humor Faces page") {
                beforeEach {
                    // The layout subviews will call automatically the viewDidLoad function and create all the outlets to be able to test them
                    self.humorFacesViewControllerMock.view.layoutSubviews()
                }
                it("THEN it should display the no humor description") {
                    expect(self.humorFacesViewControllerMock.humorDescriptionLabel?.text).toEventually(equal("No Humor Found"))
                }
                it("AND it should display the no humor image") {
                    expect(self.humorFacesViewControllerMock.humorFaceImageView?.image).toEventually(equal(UIImage(named: "error_face")))
                }
                it("AND it should display the no background color") {
                    expect(self.humorFacesViewControllerMock.view.backgroundColor).toEventually(equal(.orange))
                }
            }
        }
        describe("GIVEN that the server responds with no data") {
            beforeEach {
                self.humorFacesViewControllerMock = HumorFacesViewControllerMock.fromStoryboard(named: "HumorFacesMock")
                self.navigationController = UINavigationController(rootViewController: self.humorFacesViewControllerMock)
                // The line bellow, allow us to have our viewcontroller on the window to be able to have access and test all the presented view controllers like UIAlertController and modal views.
                UIApplication.shared.keyWindow?.rootViewController = self.navigationController
                self.humorFacesViewControllerMock.updateNetworkState(.successWithNoData)
            }
            context("WHEN I access the Humor Faces page") {
                beforeEach {
                    // The layout subviews will call automatically the viewDidLoad function and create all the outlets to be able to test them
                    self.humorFacesViewControllerMock.view.layoutSubviews()
                }
                it("THEN it should display the placeholder description") {
                    expect(self.humorFacesViewControllerMock.humorDescriptionLabel?.text).toEventually(equal("-"))
                }
                it("AND it should display the placeholder image") {
                    expect(self.humorFacesViewControllerMock.humorFaceImageView?.image).toEventually(equal(UIImage(named: "placeholder")))
                }
                it("AND it should display the placeholder background color") {
                    expect(self.humorFacesViewControllerMock.view.backgroundColor).toEventually(equal(.white))
                }
            }
        }
    }
}
