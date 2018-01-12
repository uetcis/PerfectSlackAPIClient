import XCTest
import PerfectAPIClient
@testable import PerfectSlackAPIClient

class PerfectSlackAPIClientTests: XCTestCase {
    
    static var allTests = [
        ("testSendSlackMessage", testSendSlackMessage)
    ]
    
    override func setUp() {
        super.setUp()
        self.continueAfterFailure = false
        PerfectSlackAPIClient.Configuration.webhookURL = "THE_WEBHOOK_URL"
    }
    
    func testSendSlackMessage() {
        var slackMessage = SlackMessage()
        slackMessage.text = "Hello World :)".toMarkdown(format: .code)
        let expectation = self.expectation(description: #function)
        PerfectSlackAPIClient.send(message: slackMessage).request { (result) in
            result.analysis(success: { (response: APIClientResponse) in
                XCTAssertNotNil(response.payload)
                expectation.fulfill()
            }, failure: { (error: APIClientError) in
                XCTFail(error.localizedDescription)
            })
        }
        self.wait(for: [expectation], timeout: 15)
    }

}
