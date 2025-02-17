//
//  NetworkManagerTests.swift
//  GoMoneyAssessmentTests
//
//  Created by Danjuma Nasiru on 16/02/2025.
//

import XCTest
@testable import GoMoneyAssessment

final class NetworkManagerTests: XCTestCase {
    var networkManager: NetworkManager!
    var mockRequestHandler: RequestHandler!
    var mockResponseHandler: ResponseHandler!
    
    override func setUp() {
        super.setUp()
        mockRequestHandler = RequestHandlerMock()
        mockResponseHandler = ResponseHandlerMock()
        networkManager = NetworkManagerImpl(requestHandler: mockRequestHandler, responsehandler: mockResponseHandler)
    }
    
    override func tearDown() {
        networkManager = nil
        mockRequestHandler = nil
        mockResponseHandler = nil
        super.tearDown()
    }
    
    func testGet_SuccessfulResponse() async throws {
        let requestHandler = mockRequestHandler as! RequestHandlerMock
        let jsonString = """
            {
                "id": 1,
                "name": "Test"
            }
            """
        requestHandler.mockData = jsonString.data(using: .utf8)!
        requestHandler.mockStatusCode = 200
        
        struct TestModel: Codable {
            let id: Int
            let name: String
        }
        
        do {
            let result: TestModel = try await networkManager.get(urlString: "https://mockurl.com")
            XCTAssertEqual(result.id, 1)
            XCTAssertEqual(result.name, "Test")
        } catch {
            XCTFail("Unexpected failure: \(error)")
        }
    }
    
    func testGet_InvalidURL() async {
        do {
            let _: String = try await networkManager.get(urlString: "htp://invalid url ")
            XCTFail("Expected error but got success")
        } catch let error as AppError {
            XCTAssertEqual(error.message, "invalid url")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testNo_Internet() async {
        let requestHandler = mockRequestHandler as! RequestHandlerMock
        requestHandler.shouldThrowError = true
        
        do {
            let _: String = try await networkManager.get(urlString: "https://mockurl.com")
            XCTFail("Expected error but got success")
        } catch let error as URLError {
            XCTAssertEqual(error, URLError(.notConnectedToInternet))
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testGet_DecodingFailure() async {
        let requestHandler = mockRequestHandler as! RequestHandlerMock
        requestHandler.mockData = Data()
        requestHandler.mockStatusCode = 400
        
        struct TestModel: Codable {
            let id: Int
            let name: String
        }
        
        do {
            let _: TestModel = try await networkManager.get(urlString: "https://mockurl.com")
            XCTFail("Expected decoding failure but got success")
        } catch let error as AppError {
            XCTAssertEqual(error.message, "Mock decoding failed")
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testGet_ClientErrorResponse() async {
        let jsonString = """
            {
                "code" : 400,
                "message" : "Bad Request"
            }
        """
        let requestHandler = mockRequestHandler as! RequestHandlerMock
        requestHandler.mockData = jsonString.data(using: .utf8)
        requestHandler.mockStatusCode = 400
        
        struct TestErrorResponse: Codable {
            let code: Int
            let message: String
        }
        do {
            let _: TestErrorResponse = try await networkManager.get(urlString: "https://mockurl.com")
            XCTFail("Expected error but got success")
        } catch let error as AppError {
            XCTAssertEqual(error.code, 400)
            XCTAssertEqual(error.message, "Bad Request")
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testGet_ServerErrorResponse() async {
        let requestHandler = mockRequestHandler as! RequestHandlerMock
        requestHandler.mockData = Data()
        requestHandler.mockStatusCode = 500
        
        do {
            let _: String = try await networkManager.get(urlString: "https://mockurl.com")
            XCTFail("Expected error but got success")
        } catch let error as AppError {
            XCTAssertEqual(error.code, 500)
            XCTAssertEqual(error.message, "Server Unavailable")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
