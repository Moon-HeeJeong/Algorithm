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
    //print(solution1(["java backend junior pizza 150","python frontend senior chicken 210","python frontend senior chicken 150","cpp backend senior pizza 260","java backend junior chicken 80","python backend senior chicken 50"], ["java and backend and junior and pizza 100","python and frontend and senior and chicken 200","cpp and - and senior and pizza 250","- and backend and senior and - 150","- and - and - and chicken 100","- and - and - and - 150"]))
    
    
    
    
    //:> 2019 KAKAO BLIND RECRUITMENT 오픈채팅방
    /*:>
     Lv.2
     */
    
    //: 🌱solution2(100%)
    func solution2(_ record:[String]) -> [String] {
        
        var usersName: [String:String] = [:]
        var messageArr: [String] = []
        
        for r in record{
            var splitR = r.split(separator: " ")
            let status = splitR[0].description
            let userId = splitR[1].description
            
            if status == "Enter"{
                usersName[userId] = splitR[2].description
                messageArr.append("\(userId)님이 들어왔습니다.")
            }else if status == "Leave"{
                messageArr.append("\(userId)님이 나갔습니다.")
            }else{ //닉네임 변경
                usersName[userId] = splitR[2].description
            }
        }
        
        print("usersName \(usersName)\nmessageArr \(messageArr)")
        
        //messageArr에 닉네임이 아닌 유저 아이디를 넣고 마지막에 대치
        for i in 0..<messageArr.count{
            let id = messageArr[i].split(separator: "님").first!.description
            messageArr[i] = messageArr[i].replacingOccurrences(of: id, with: usersName[id]!)
        }
        
        return messageArr
    }
    
    //:> 2018 KAKAO BLIND RECRUITMENT [3차] 파일명 정렬
    /*:>
     Lv.2
     */
    
    //: 🌱solution3(65.0)
    //3,4,5,6,7,19,20 답 실패
    //숫자 5개까지만 가능 조건 넣었는데 똑같... 2 런타임 에러가 추가됨...
    //공백제거 3,4,5,6(공백 문제),7,8,9(7,8,9 - 문제),19,20 (55.0%)
    // head 다른경우에도 lowercased 로 비교 -> 6,7,8,9 오답 (80%)
    func solution3(_ files:[String]) -> [String] {
        
        struct FileComponent{
            var head: String
            var number: String
            var tail: String?
            
            
            var fixedHead: String{
                var str = ""
                str = self.head.replacingOccurrences(of: ".", with: "")
                str = str.replacingOccurrences(of: "-", with: "")
                return str
            }
        }
        
        var files = files
        var filesDict: [String:FileComponent] = [:]
        
        for str in files{
            var firstNumIdx: Int?
            var lastNumIdx: Int?
            
            let file = str.replacingOccurrences(of: " ", with: "") //공백제거
            
            for str in file.enumerated(){
                
                if str.element.isNumber{
                    lastNumIdx = str.offset
                    
                    if firstNumIdx == nil{
                        firstNumIdx = str.offset
                    }
                }else{
                    if let idx = lastNumIdx{
//                        print(":::: num start \(firstNumIdx) lastNumIdx \(lastNumIdx)")
                        break
                    }
                }
            }
            
            
            if (lastNumIdx! - firstNumIdx!) >= 4{
                lastNumIdx = firstNumIdx!+4
            }
            
            
            let numStartIdx = String.Index(encodedOffset: firstNumIdx!)
            let numLastIdx = String.Index(encodedOffset: (lastNumIdx!+1))
            
            let head = file[file.startIndex..<numStartIdx]
            let num = file[numStartIdx..<numLastIdx]
            let tail = file[numLastIdx..<file.endIndex]
            
            print(":::: head \(head) num \(num) tail \(tail)")
            
            filesDict[str] = FileComponent(head: String(head), number: String(num), tail: String(tail))
        }
        
        print("before sort \(files)")
        

        files = files.sorted(by: {filesDict[$0]!.fixedHead.lowercased() < filesDict[$1]!.fixedHead.lowercased()})
        
        //num sort
        files = files.sorted(by: { first, second in
            if filesDict[first]!.fixedHead.lowercased() == filesDict[second]!.fixedHead.lowercased(){
                if Int(filesDict[first]!.number)! < Int(filesDict[second]!.number)!{
                    return true
                }else{
                    return false
                }
            }else{
                return false
                
                
                
//                if filesDict[first]!.head.lowercased() < filesDict[second]!.head.lowercased(){
//                    return true
//                }else{
//                    return false
//                }
                
            }
        })
        print("num sort \(files)")
        
        return files
    }
    
    
    //:> 2019 카카오 개발자 겨울 인턴십 튜플
    /*:>
     Lv.2
     */
    
    //: 🌱solution4(100%)
    func solution4(_ s:String) -> [Int] {
        var tempS = removeSign(str: s)
        var result: [Int] = []
        
        var splitedStrs = removeSign(str: tempS).components(separatedBy: "},{")
//        print("splitedStrs \(splitedStrs)")
        
        splitedStrs.sort { first, second in
            return first.count < second.count ? true : false
        }
        
        for i in 0..<splitedStrs.count{
            
            var splitedInt = splitedStrs[i].components(separatedBy: ",")
            
            for str in splitedInt{
                
                print("str \(str)")
                let value = Int(str)!
                if !result.contains(value) {
                    result.append(value)
                }
            }
        }
        
        func removeSign(str: String) -> String{
            var str = str
            str.removeLast()
            str.removeFirst()
            return str
        }
        
        return result
    }
        
}
