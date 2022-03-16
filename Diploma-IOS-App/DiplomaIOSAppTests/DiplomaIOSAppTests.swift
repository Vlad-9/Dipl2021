import XCTest
import Alamofire
import UIKit
@testable import DiplomaIOSApp

class DiplomaIOSAppTests: XCTestCase, UITableViewDelegate {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)


    override func setUpWithError() throws { // Test Account
        let e = expectation(description: "Alamofire")
        let username = "swebus999@gmail.com"
        let password = "Desired"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()

        authModule.loginWithAPI(userString: base64LoginString){
            (user) in
            authModule.saveToken(token: user!["token"] as! String)
            e.fulfill()
        }
        waitForExpectations(timeout: 15.0, handler: nil)
    }

    override func tearDownWithError() throws {

    }

    func testLogin() throws {

        let e = expectation(description: "Alamofire")
        let username = "swebus999@gmail.com"
        let password = "Desired"
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        let username1 = "swebus999@gmail.com"
        let password1 = "Desired9"
        let loginString1 = String(format: "%@:%@", username1, password1)
        let loginData1 = loginString1.data(using: String.Encoding.utf8)!
        let base64LoginString1 = loginData1.base64EncodedString()

        authModule.loginWithAPI(userString: base64LoginString){
            (user) in
            authModule.saveToken(token: user!["token"] as! String)
            XCTAssertEqual(user?.count, 3, "Failed to login with valid data")
        }
        let token = defaults.string(forKey: "Token") ?? "0"
        print (token)
        authModule.loginWithAPI(userString: base64LoginString1){
            (user) in
            XCTAssertEqual(user?.count, 2, "Failed to not login with invalid data")
            e.fulfill()
        }

        waitForExpectations(timeout: 15.0, handler: nil)
    }

    func testMyBenefitTable() {

        let sut = storyboard.instantiateViewController(identifier: "BenVC") as! BenViewController
        sut.loadView()
        XCTAssertNotNil(sut.tableView)
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))

        XCTAssertNotNil(sut.performSegue(withIdentifier: "showMyBenefit", sender: cell))

    }

    func testRegistation() throws {

        let sut = storyboard.instantiateViewController(identifier: "RegVC") as! RegistrationViewController
        sut.loadView()

        sut.email.text = "email@mokl.com"
        sut.password.text = "password"
        sut.lastName.text = "lastName"
        sut.name.text = "firstName"
        sut.secondName.text = "secondname"
        sut.phone.text = "89001231223"
        sut.contract.text = "12345"

        sut.registrationButton.sendActions(for: .touchUpInside)

        XCTAssertEqual(sut.email.text, sut.params["email"] as? String)
        XCTAssertEqual(sut.password.text, sut.params["password"] as? String)
        XCTAssertEqual(sut.lastName.text, sut.params["lastname"] as? String)
        XCTAssertEqual(sut.secondName.text, sut.params["secondname"] as? String)
        XCTAssertEqual(sut.name.text, sut.params["name"] as? String)
        XCTAssertEqual(sut.phone.text, sut.params["phone"] as? String)
        XCTAssertEqual(sut.contract.text, sut.params["contract"] as? String)

    }

    func testLoadUserInfo() throws {
        let e = expectation(description: "Alamofire")
        serverModule.loadUserInfoFromAPI {
            (user) in
            var b = (user![0]["name"] as? String)!
            e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)

    }

    func testLoadTransactions() throws {
        let e = expectation(description: "A")
        var b:Float = 0.0

        serverModule.loadTransactionInfoFromAPI {
            (transaction) in
            print (transaction)
            b = (transaction![0]["sum"] as? Float)!
            e.fulfill()
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        XCTAssertNotEqual(b, 0.0, "Failed")
    }

    func testLoadAvBenefits() throws {
        var price:Float = 0.0
        let e = expectation(description: "A")

        serverModule.loadAvBenInfoFromAPI() {
            (benefit) in
            price = (benefit![0]["price"] as? Float)!
            e.fulfill()
        }
        waitForExpectations(timeout: 25.0, handler: nil)
        XCTAssertNotEqual(price, 0.0, "Failed")
    }

    func testLoadUsBenefits() throws {
        var status:String = ""
        let e = expectation(description: "A")

        serverModule.loadUsBenInfoFromAPI() {
            (benefit) in
            status = (benefit![0]["status"] as? String)!
            e.fulfill()
        }
        waitForExpectations(timeout: 25.0, handler: nil)
        XCTAssertNotEqual(status,"", "Failed")
    }

    func testLoadBenInfo() throws {
        var status:String = ""
        let e = expectation(description: "A")

        serverModule.loadBenefitInfoFromAPI(benefitId: 1) {
            (benefit) in
            status = (benefit!["status"] as? String)!
            e.fulfill()
        }
        waitForExpectations(timeout: 25.0, handler: nil)
        XCTAssertNotEqual(status,"", "Failed")

    }
    func testBuyBeneft() throws {
        
        let sut = storyboard.instantiateViewController(identifier: "BuyVC") as! BuyBenefitViewController

        XCTAssertNotNil(sut)

    }

    func testRating() throws {
        let sut = storyboard.instantiateViewController(identifier: "MyVC") as! MyBenefitViewController
        sut.loadView()
        let test = ["rating": -1.0]

        sut.params = test
        sut.userBenifitDictArray = ["benefitId": 1]

        sut.getBenefitInfoFromServerModule()

        sut.rateB.sendActions(for: .touchUpInside)

        XCTAssertNotEqual(test,sut.params, "Failed")
    }
    func testAvBenefitTable() throws {

        let sut = storyboard.instantiateViewController(identifier: "AvVC") as! AvBenViewController
        sut.loadView()
        XCTAssertNotNil(sut.tableView1)
        let cell = sut.tableView1.dequeueReusableCell(withIdentifier: "avCell") as! AvBenTableViewCell
        XCTAssertNotNil(cell)
        XCTAssertNotNil(sut.performSegue(withIdentifier: "buyBenefit", sender: cell))

    }

    func testUserTransactionsTable() throws {

        let sut = storyboard.instantiateViewController(identifier: "TransVC") as! TransactionViewController
        sut.loadView()
        XCTAssertNotNil(sut.tableView)
        let cell = sut.tableView.dequeueReusableCell(withIdentifier: "transCell") as! TransactionTableViewCell
        XCTAssertNotNil(cell)

    }
    func testUserLogout() throws {

        let sut = storyboard.instantiateViewController(identifier: "MainVC") as! MainViewController

        sut.loadView()

        let user = defaults.object(forKey: "Token") as? String
        sut.logoutB.sendActions(for: .touchUpInside)
        let user1 = defaults.object(forKey: "Token") as? String

        XCTAssertNotEqual(user, "0")
        XCTAssertEqual(user1, "0")

    }

    func testSwitch() throws {
        let sut = storyboard.instantiateViewController(identifier: "BuyVC") as! BuyBenefitViewController
        sut.loadView()

        sut.sw.isOn = false
        sut.switch(sut.sw)
        XCTAssertEqual(sut.isOn, false)

        sut.sw.isOn = true
        sut.switch(sut.sw)
        XCTAssertEqual(sut.isOn, true)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
