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
//        var s3 = Programmers().solution3(["img12.png", "img10.png", "-img02.png", "img1.png", "IMG01.GIF", "img2.JPG"])
//        XCTAssertEqual(s3, ["img1.png", "IMG01.GIF", "-img02.png", "img2.JPG", "img10.png", "img12.png"])
        var s3 = Programmers().solution3b(["F-5 Freedom Fighter", "B-50 Superfortress", "A-10 Thunderbolt II", "F-14 Tomcat"])
        XCTAssertEqual(s3, ["A-10 Thunderbolt II", "B-50 Superfortress", "F-5 Freedom Fighter", "F-14 Tomcat"])
//
//        var s3 = Programmers().solution3(["abc0000123456.png", "abcde02.png", "img-12.png", "img12.png", "def01", "img1.png", "IMG01.GIF", "ABC02.JPG"])
//                XCTAssertEqual(s3, ["abc0000123456.png", "ABC02.JPG", "abcde02.png","def01","img1.png", "IMG01.GIF", "img-12.png", "img12.png"])
//
//        var s3 = Programmers().solution3(["muzi1.png1", "MUZI1.png2", "MUZI1.png3", "muzi1.png4"])
//                XCTAssertEqual(s3, ["muzi1.png1", "MUZI1.png2", "MUZI1.png3", "muzi1.png4"])
//        var s3 = Programmers().solution3(["foo9.txt", "foo010bar020.zip", "F-15", "MUZI01", "muzi1", "MuZi00001", "O49qcGPHuRLR5FEfoO00321"])
//                XCTAssertEqual(s3, ["O49qcGPHuRLR5FEfoO00321", "F-15", "foo9.txt", "foo010bar020.zip", "MUZI01","muzi1", "MuZi00001"])
        
//        var s3 = Programmers().solution3b(["A5", "a0001", "a...0202", "a- .03", "BB2", "AAAA4"])
//        XCTAssertEqual(s3, ["a0001", "a- .03", "AAAA4", "A5", "a...0202", "BB2",])
    }
    
    func testSolution4() throws{
        var s4 = Programmers().solution4("{{2},{2,1},{2,1,3},{2,1,3,4}}")
        XCTAssertEqual(s4, [2, 1, 3, 4])
//        var s4 = Programmers().solution4("{{20,111},{111}}")
//        XCTAssertEqual(s4, [111, 20])
    }
    
    func testSolution5() throws{
//        var s5 = Programmers().solution5(["frodo", "fradi", "crodo", "abc123", "frodoc"], ["fr*d*", "abc1**"])
//        var s5 = Programmers().solution5(["frodo", "fradi", "crodo", "abc123", "frodoc"], ["*rodo", "*rodo", "******"])
        var s5 = Programmers().solution5(["frodo", "fradi", "crodo", "abc123", "frodoc"], ["fr*d*", "*rodo", "******", "******"])
        XCTAssertEqual(s5, 2)
//        var s4 = Programmers().solution4("{{20,111},{111}}")
//        XCTAssertEqual(s4, [111, 20])
    }
    
    func testSolution6() throws{
//        var s6 = Programmers().solution6(5, [2,1,1,1,0,0,0,0,0,0,0])
//        XCTAssertEqual(s6, [0,2,2,0,1,0,0,0,0,0,0])
        
        var s6 = Programmers().solution6(1, [1,0,0,0,0,0,0,0,0,0,0])
        XCTAssertEqual(s6, [-1])
        
    }
    
    func testSolution7() throws{
//        var s7 = Programmers().solution7("ULURRDLLU")
//        XCTAssertEqual(s7, 7)
        
//        var s7 = Programmers().solution7("LULLLLLLU")
//        XCTAssertEqual(s7, 7)
        
//        var s7 = Programmers().solution7("UDU")
//        XCTAssertEqual(s7, 1)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
