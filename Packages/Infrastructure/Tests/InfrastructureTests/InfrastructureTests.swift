import XCTest
@testable import Infrastructure

class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) -> (HTTPURLResponse?, Data?, Error?))?
    
    override class func canInit(with request: URLRequest) -> Bool { return true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { return request }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            XCTFail("Handler atanmadı.")
            return
        }
        
        let (response, data, error) = handler(request)
        if let response = response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        if let data = data {
            client?.urlProtocol(self, didLoad: data)
        }
        
        if let error = error {
            client?.urlProtocol(self, didFailWithError: error)
        } else {
            client?.urlProtocolDidFinishLoading(self)
        }
    }
    
    override func stopLoading() {}
}

// MARK: -
final class NetworkManagerTests: XCTestCase {
    
    var networkManager: NetworkManager!
    
    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        networkManager = NetworkManager(configuration: configuration)
    }
    
    func testFetchCharactersSuccess() async throws {
        let mockJSON = """
        {
            "results": [
                { "id": 67, "name": "Rick Sanchez", "status": "Alive", "species": "Human", "gender": "Male", "image": "url" }
            ]
        }
        """.data(using: .utf8)!
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, mockJSON, nil)
        }
        
        struct TestEndpoint: Endpoint {
            var baseURL: String { "https://test.com" }
            var path: String { "/test" }
            var method: RequestMethod { .get }
            var headers: [String : String]? { nil }
            var task: NetworkTask { .requestPlain }
        }
        
        struct TestResponse: Decodable {
            let results: [TestCharacter]
        }
        struct TestCharacter: Decodable {
            let name: String
        }
        
        let result = try await networkManager.request(TestEndpoint(), type: TestResponse.self)
        XCTAssertEqual(result.results.first?.name, "Rick Sanchez")
    }
}
