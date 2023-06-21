//
//  AlgorithmTests.swift
//  AlgorithmTests
//
//  Created by LittleFoxiOSDeveloper on 2023/06/16.
//

import XCTest

final class AlgorithmTests: XCTestCase {
    

    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
    }
    
    func testSolution1() throws{
        var s1 = Programmers().solution1(["java backend junior pizza 150","python frontend senior chicken 210","python frontend senior chicken 150","cpp backend senior pizza 260","java backend junior chicken 80","python backend senior chicken 50"], ["java and backend and junior and pizza 100","python and frontend and senior and chicken 200","cpp and - and senior and pizza 250","- and backend and senior and - 150","- and - and - and chicken 100","- and - and - and - 150"])
        XCTAssertEqual(s1, [1,1,1,1,2,4])
    }
    
    func testSolution2() throws{
        var s2 = Programmers().solution2(["Enter uid1234 Muzi", "Enter uid4567 Prodo","Leave uid1234","Enter uid1234 Prodo","Change uid4567 Ryan"])
        XCTAssertEqual(s2, ["Prodo님이 들어왔습니다.", "Ryan님이 들어왔습니다.", "Prodo님이 나갔습니다.", "Prodo님이 들어왔습니다."])
    }
    
    func testSolution3() throws{
//        var s3 = Programmers().solution3(["img12.png", "img10.png", "img02.png", "img1.png", "IMG01.GIF", "img2.JPG"])
//        XCTAssertEqual(s3, ["img1.png", "IMG01.GIF", "img02.png", "img2.JPG", "img10.png", "img12.png"])
//        var s3 = Programmers().solution3(["F-5 Freedom Fighter", "B-50 Superfortress", "A-10 Thunderbolt II", "F-14 Tomcat"])
//        XCTAssertEqual(s3, ["A-10 Thunderbolt II", "B-50 Superfortress", "F-5 Freedom Fighter", "F-14 Tomcat"])
        
        var s3 = Programmers().solution3(["abc0000123456.png", "abcde02.png", "img-12.png", "img12.png", "def01", "img1.png", "IMG01.GIF", "ABC02.JPG"])
                XCTAssertEqual(s3, ["abc0000123456.png", "ABC02.JPG", "abcde02.png","def01","img1.png", "IMG01.GIF", "img-12.png", "img12.png"])
//        var s3 = Programmers().solution3(["foo9.txt", "foo010bar020.zip", "F-15", "MUZI01", "muzi1", "MuZi00001", "O49qcGPHuRLR5FEfoO00321"])
//                XCTAssertEqual(s3, ["O49qcGPHuRLR5FEfoO00321", "F-15", "foo9.txt", "foo010bar020.zip", "MUZI01","muzi1", "MuZi00001"])
    }
    
    func testSolution4() throws{
        var s4 = Programmers().solution4("{{2},{2,1},{2,1,3},{2,1,3,4}}")
        XCTAssertEqual(s4, [2, 1, 3, 4])
//        var s4 = Programmers().solution4("{{20,111},{111}}")
//        XCTAssertEqual(s4, [111, 20])
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
