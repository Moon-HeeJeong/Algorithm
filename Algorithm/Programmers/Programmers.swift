//
//  Programmers.swift
//  Algorithm
//
//  Created by LittleFoxiOSDeveloper on 2023/06/16.
//

import Foundation


class Programmers {
    
    //:> 2021 KAKAO BLIND RECRUITMENT 순위검색
    /*:>
     Lv.2
     */
    
    //: 🌱solution1 (정확성 테스트 100% / 효율성 테스트 0%(시간초과))
    func solution1(_ info:[String], _ query:[String]) -> [Int] {
        //info : 지원자 정보
        //개발언어 직군 경력 소울푸드 점수
        //cpp, java, python
        //backend, frontend
        //junior, senior
        //chicken, pizza
        
        struct InfoData{
            let lang: String
            let workCategory: String
            let career: String
            let food: String
            let grade: Int
            
            func getIsExist(idx: Int, value: String) -> Bool{
                switch idx{
                case  0:
                    return self.lang == value ? true : false
                case  1:
                    return self.workCategory == value ? true : false
                case  2:
                    return self.career == value ? true : false
                case  3:
                    return self.food == value ? true : false
                case  4:
                    return self.grade >= Int(value)! ? true : false
                default:
                    return false
                }
            }
        }
        
        var infoArr: [InfoData] = []
        var filteredCnt: [Int] = []
        
        for i in 0..<info.count{
            var splitInfo = info[i].split(separator: " ")
            
            infoArr.append(InfoData(lang: String(splitInfo[0]), workCategory: String(splitInfo[1]), career: String(splitInfo[2]), food: String(splitInfo[3]), grade: Int(splitInfo[4])!))
        }
        
        for q in query{
            var splitQuery = q.replacingOccurrences(of: " and ", with: " ").components(separatedBy: " ")
            var filteredData = infoArr
            
            for i in 0..<splitQuery.count{
                let f = filteredData.filter { data in
                    let findValue = String(splitQuery[i])
                    print("findValue \(findValue)")
                    if findValue == "-"{
                        return true
                    }else{
                        return data.getIsExist(idx: i, value: findValue)
                    }
                }
                filteredData = []
                filteredData = f
                
                print("f :::: \(f)")
            }
            filteredCnt.append(filteredData.count)
        }
        return filteredCnt
    }
    //print("aaa")
    //print(solution(["java backend junior pizza 150","python frontend senior chicken 210","python frontend senior chicken 150","cpp backend senior pizza 260","java backend junior chicken 80","python backend senior chicken 50"], ["java and backend and junior and pizza 100","python and frontend and senior and chicken 200","cpp and - and senior and pizza 250","- and backend and senior and - 150","- and - and - and chicken 100","- and - and - and - 150"]))
}
