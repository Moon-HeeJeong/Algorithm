//
//  AlgorithmClass1.swift
//  Algorithm
//
//  Created by LittleFoxiOSDeveloper on 2023/08/07.
//

import Foundation

class AlgorithmClass1{
    
    //완전 탐색 <최소직사각형>
    func solutionA(_ sizes:[[Int]]) -> Int {//완전 탐색 <최소직사각형>
        
        var bigArr: [Int] = []
        var smallArr: [Int] = []
        
        for size in sizes {
            
            let currentW = size.first!
            let currentH = size.last!
            
            bigArr.append(currentW > currentH ? currentW : currentH)
            smallArr.append(currentW > currentH ? currentH : currentW)
        }
        
        return bigArr.max()!*smallArr.max()!
    }
    
//    print(solutionA([[60, 50], [30, 70], [60, 30], [80, 40]]))
    
    
    //탐욕법 <체육복>
    func solutionB(_ n:Int, _ lost:[Int], _ reserve:[Int]) -> Int {
        
        let reserve: Set<Int> = Set(reserve)
        let lost: Set<Int> = Set(lost)
        
        //차집합을 이용하여 여분을 가지고 있는 사람이 잃어버렸을 경우 제외
        var reserveSubOwn = reserve.subtracting(lost).sorted(by: <)
        let lostSubOwn = lost.subtracting(reserve).sorted(by: <)
        var attendStudentCnt = n - lostSubOwn.count
        
        for lose in lostSubOwn{
            if let idx = reserveSubOwn.firstIndex(of: lose-1){
                reserveSubOwn.remove(at: idx)
                attendStudentCnt += 1
            }else if let idx = reserveSubOwn.firstIndex(of: lose+1){
                reserveSubOwn.remove(at: idx)
                    attendStudentCnt += 1
            }
        }
        return attendStudentCnt
    }
    //print(solutionB​(5, [2, 4], [1, 3, 5]))
    //print(solutionB​(5, [4, 2], [3, 5]))
    //print(solutionB​(5, [2, 4], [2, 5]))
    //print(solutionB​(5, [4,5], [3,4]))
//    print(solutionB​(4, [1,3], [2,4]))
}
