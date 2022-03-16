import XCTest

class DiplomaIOSAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false


    }

    override func tearDownWithError() throws {

    }

    func testMainView() throws {

        let app = XCUIApplication()
        app.launch()

        app/*@START_MENU_TOKEN@*/.buttons["Ваши льготы"]/*[[".segmentedControls.buttons[\"Ваши льготы\"]",".buttons[\"Ваши льготы\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Доступные льготы"]/*[[".segmentedControls.buttons[\"Доступные льготы\"]",".buttons[\"Доступные льготы\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()


    }
    func testLoginView() throws {

        let app = XCUIApplication()
        app.launch()

        app.buttons["Выйти"].tap()
        app.textFields["Email"].tap()
        let secureTextField = app.secureTextFields["Пароль"]
        secureTextField.tap()
        secureTextField.tap()
        app.buttons["Войти"].tap()

    }

    func testRegistrationView() throws {

        let app = XCUIApplication()
        app.launch()
        //app.buttons["Выйти"].tap()
        app.buttons["Зарегистрироваться"].tap()
        app.textFields["Имя"].tap()
        app.textFields["Фамилия"].tap()
        app.textFields["Отчество"].tap()
        app.textFields["E-mail"].tap()
        app.textFields["Номер телефона"].tap()
        app.textFields["Номер договора"].tap()
        app.buttons["Регистрация"].staticTexts["Регистрация"].tap()
        app.alerts["Ошибка"].scrollViews.otherElements.buttons["OK"].tap()

    }

    func testUsBenefitsTableView() throws {

        let app = XCUIApplication()
        app.launch()

        app/*@START_MENU_TOKEN@*/.buttons["Ваши льготы"]/*[[".segmentedControls.buttons[\"Ваши льготы\"]",".buttons[\"Ваши льготы\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Абонемент в спортзал 2021 описание"]/*[[".cells.staticTexts[\"Абонемент в спортзал 2021 описание\"]",".staticTexts[\"Абонемент в спортзал 2021 описание\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.staticTexts["2.0"]/*@START_MENU_TOKEN@*/.swipeRight()/*[[".swipeDown()",".swipeRight()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/

    }
    func testUsTransactionsTableView() throws {


        let app = XCUIApplication()
        app.launch()
        app.buttons["info"].tap()
        app.staticTexts["Транзакции"]/*@START_MENU_TOKEN@*/.swipeRight()/*[[".swipeDown()",".swipeRight()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/


    }
    func testAvBenefitsTableView() throws {

        let app = XCUIApplication()
        app.launch()

        app/*@START_MENU_TOKEN@*/.buttons["Ваши льготы"]/*[[".segmentedControls.buttons[\"Ваши льготы\"]",".buttons[\"Ваши льготы\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Доступные льготы"]/*[[".segmentedControls.buttons[\"Доступные льготы\"]",".buttons[\"Доступные льготы\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["ДМС на одного человека 2021"]/*[[".cells.staticTexts[\"ДМС на одного человека 2021\"]",".staticTexts[\"ДМС на одного человека 2021\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()


    }

    func testBuyBenefitView() throws {

        let app = XCUIApplication()
        app.launch()
        app/*@START_MENU_TOKEN@*/.buttons["Ваши льготы"]/*[[".segmentedControls.buttons[\"Ваши льготы\"]",".buttons[\"Ваши льготы\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Доступные льготы"]/*[[".segmentedControls.buttons[\"Доступные льготы\"]",".buttons[\"Доступные льготы\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Абонемент в гольфклуб 2021"]/*[[".cells.staticTexts[\"Абонемент в гольфклуб 2021\"]",".staticTexts[\"Абонемент в гольфклуб 2021\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Оформить"]/*[[".buttons[\"Оформить\"].staticTexts[\"Оформить\"]",".staticTexts[\"Оформить\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

    }



    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
