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
        
        print("head sort \(files)")
        
        //num sort
        files = files.sorted(by: { first, second in
            if filesDict[first]!.fixedHead.lowercased() == filesDict[second]!.fixedHead.lowercased(){
                if Int(filesDict[first]!.number)! < Int(filesDict[second]!.number)!{
                    return true
                }else{
                    return false
                }
            }else{
                
//                return false
                
                if filesDict[first]!.head.lowercased() < filesDict[second]!.head.lowercased(){
                    return true
                }else{
                    return false
                }
                
            }
        })
        print("num sort \(files)")
        
        return files
    }
    
    //: 🌱solution3B(100.0)
    //블로그참고
    func solution3b(_ files:[String]) -> [String] {
        
        var newFiles = splitFiles(files)
//        var sortedFile: [String] = []
        let sortedFile = newFiles.sorted(by: { first, second in
            if first[0].lowercased() != second[0].lowercased(){
                return first[0].lowercased() < second[0].lowercased()
            }else{
                if let n1 = Int(first[1]), let n2 = Int(second[1]), n1 != n2{
                    return n1 < n2
                }
            }
            return false
        })
        
        
        print("sorted \(sortedFile)")
        
        return sortedFile.map({$0.joined()})
    }
    func splitFiles(_ files:[String]) -> [[String]]{
        let symbol = [".", "-", " "]
        
        var splitFiles = [[String]]()
        
        for f in files{
            var head = ""
            var num = ""
            var tail = ""
            var isTail = false
            
            for char in f {
                if (char.isLetter && isTail) || (isTail && symbol.contains(String(char))) || (!tail.isEmpty && char.isNumber && isTail){ //tail
                    
                    tail += String(char)
                    
                } else if char.isNumber && tail.isEmpty{ //number
                    
                    num += String(char)
                    isTail = true
                    
                }else if (!isTail && char.isLetter) || (!isTail && symbol.contains(String(char))){ //head
                    
                    head += String(char)
                }
            }
            
            print("head \(head) num \(num) tail \(tail)")
            
            splitFiles.append([head, num, tail])

        }
        return splitFiles
        
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
        
    //:> 2019 카카오 개발자 겨울 인턴십 불량 사용자
    /*:>
     Lv.2
     */
    func solution5(_ user_id:[String], _ banned_id:[String]) -> Int {
        
        let userId = user_id
        let bannedId = banned_id
//        var filtedId: [String] = []
        
        var properCnt: [Int] = []
        
        
        for i in 0..<bannedId.count{
            var filterdUserId = userId.filter({$0.count == bannedId[i].count})
            
            
            print("⛔️bannedId \(bannedId[i]) filterdUserId \(filterdUserId)")
            for j in stride(from: filterdUserId.count-1, to: 0, by: -1){
                
                let userStr = filterdUserId[j].enumerated()
                
                print("compare \(bannedId[i]) with \(filterdUserId[j])")
                
                for (offset, banStr) in bannedId[i].enumerated(){
                    print("banStr \(banStr)")
                    if banStr == "*"{
//                        print("pass *")
                        //패스
                    }else if banStr != userStr.filter({$0.offset == offset}).first?.element{
                        print("not same with \(userStr.filter({$0.offset == offset}).first?.element)")
                        
                        filterdUserId.remove(at: j)
                        break
                        //해당 userStr 삭제
                    }else{
                        
                        //유지
                    }
                    
                    
                }
                
            }
            print("filterd \(filterdUserId)")
            properCnt.append(filterdUserId.count)
        }
        //조합을 시켜야하는디....
        return properCnt.reduce(1, *)
    }
    
    
    //:> 2022 KAKAO BLIND RECRUITMENT 양궁대회
    /*:>
     Lv.2
     */
    func solution6(_ n:Int, _ info:[Int]) -> [Int] {
        
        //점수 0..10
        //어피치 N  -> 라이언 N
        //n: 화살갯수
        //info: 어피치가 맞힌 과녁의 점수
        //답: 라이언이 가장 큰 점수 차이로 우승하기 위해 어떤 과녁 점수에 맞혀야 하는지(무조건 지거나 비기는 경우 [-1])
        
        
        struct ScoreDiffrentData{
            let gap:Int
            let isRyanWin: Bool
        }
        
        func getScoreDifferent(score:[String])->ScoreDiffrentData{
          
            var appeachScore = 0
            var ryanScore = 0
            
            for i in 0..<score.count{
                if score[i] == "ryan"{
                    ryanScore += (10-i)
                }else if score[i] == "appeach"{
                    appeachScore += (10-i)
                }
            }
            print("점수차이 \(ryanScore - appeachScore)")
            return ScoreDiffrentData(gap: ryanScore - appeachScore, isRyanWin: ryanScore > appeachScore ? true : false)
        }
        
        
        
        var ryanInfo:[Int] = Array(repeating: 0, count: 11)
        var isCanWin = false
//        var scoreDifference = 0
//        let appeachTotalValue = caculateScore(score: info)
        
        var winlooseScore = Array(repeating: "", count: 11)
        
        for maximumScore in stride(from: info.count, to: 0, by: -1){
            print("maximum score \(maximumScore)")
            
            var shootArrowCnt = 0
            var tempRyanInfo:[Int] = Array(repeating: 0, count: 11)
            var tempWinlooseScore = Array(repeating: "", count: 11)
            
            for i in 0..<info.count{
                
                print("\((11-maximumScore)) 값 부터 탐색")
                
//                guard shootArrowCnt < n else{
//                    break
//                }
                
                let score = 10-i //과녁 점수
                let arrowCnt = info[i] //어피치가 맞힌 화살 갯수
                
                if i >= (11-maximumScore){
                   
                    
                    if shootArrowCnt > n && arrowCnt > 0{
                        tempWinlooseScore[i] = "appeach"
                    }
                    
                    var canShootArrow = arrowCnt + 1
                    if  shootArrowCnt + canShootArrow > n {//화살 n개 안넘는지 확인
                        
                        canShootArrow = n-shootArrowCnt//abs(canShootArrow - shootArrowCnt)
                        
                        if canShootArrow > arrowCnt { //어피치한테 이길 수 있는지 확인
                            //이긴다
                            shootArrowCnt += canShootArrow
                            tempRyanInfo[i] = canShootArrow
                            
                            tempWinlooseScore[i] = "ryan"
                        }else{
                            //진다
                            if arrowCnt > 0{
                                tempWinlooseScore[i] = "appeach"
                            }
                            //비긴다
                        }
                    }else{
                        shootArrowCnt += canShootArrow
                        tempRyanInfo[i] = canShootArrow
                        
                        tempWinlooseScore[i] = "ryan"
                    }
                    
                }else{
                    if arrowCnt > 0{
                        tempWinlooseScore[i] = "appeach"
                    }
                }
            }
            
            print("tempRyanInfo ::: \(tempRyanInfo)")
//            print("caculateScore ryanInfo \(caculateScore(score: ryanInfo)) ScoreDifferent \(getScoreDifferent(score: winlooseScore)) tempRyanInfo \(caculateScore(score: tempRyanInfo)) ScoreDifferent \(getScoreDifferent(score: tempWinlooseScore))")
            
//            ryanInfo = caculateScore(score: ryanInfo) - appeachTotalValue > caculateScore(score: tempRyanInfo) - appeachTotalValue ? ryanInfo : tempRyanInfo
            
            if maximumScore == info.count{
//                let newScore = getScoreDifferent(score: tempWinlooseScore)
                
                ryanInfo = tempRyanInfo
                winlooseScore = tempWinlooseScore
            }else{
                let beforeScore = getScoreDifferent(score: winlooseScore)
                let newScore = getScoreDifferent(score: tempWinlooseScore)
                
                if beforeScore.gap < newScore.gap{
                    ryanInfo = tempRyanInfo
                    winlooseScore = tempWinlooseScore
                }
                
                if newScore.isRyanWin || beforeScore.isRyanWin{
                    isCanWin = true
                }
            }
            
//            ryanInfo = getScoreDifferent(score: winlooseScore) > getScoreDifferent(score: tempWinlooseScore) ? ryanInfo : tempRyanInfo
            
            print("apeach ::: \(info) ryan ::: \(ryanInfo)")
            
        }
        return isCanWin ? ryanInfo : [-1]
    }
    
    //:> Summer/Winter Coding(~2018) 방문 길이
    /*:>
     Lv.2
     */
    
    //: 🌱solution7 (35% -> 100%)
    //8 ~ 20 실패 -> 같은 경로를 쓰는 경우 체크해주기 UDU 의 경우
    func solution7(_ dirs:String) -> Int {
        
        enum MovingType: String{
            case up = "U"
            case down = "D"
            case right = "R"
            case left = "L"
            
            var move: [Int] {
                switch self {
                case .up:
                    return [0,1]
                case .down:
                    return [0,-1]
                case .right:
                    return [1,0]
                case .left:
                    return [-1,0]
                }
            }
            
            var reverseDir: MovingType{
                switch self {
                case .up:
                    return .down
                case .down:
                    return .up
                case .right:
                    return .left
                case .left:
                    return .right
                }
            }
        }
        
        struct CoodinateType: Hashable{
            var xPos: Int
            var yPos: Int
            var dir: MovingType
        }
        
        var directions: [MovingType] = []
        var currentPos: [Int] = [0,0]
        var coordinate: [CoodinateType:Bool] = [:]
        
        var maxRange = 5
        
        var movingDistance = 0
        
        for i in 0..<maxRange*2+1{
            for j in 0..<maxRange*2+1{
                var xValue = i > maxRange ? maxRange-i : i
                var yValue = j > maxRange ? maxRange-j : j
                
                coordinate[CoodinateType(xPos: xValue, yPos: yValue, dir: .up)] = false
                coordinate[CoodinateType(xPos: xValue, yPos: yValue, dir: .down)] = false
                coordinate[CoodinateType(xPos: xValue, yPos: yValue, dir: .left)] = false
                coordinate[CoodinateType(xPos: xValue, yPos: yValue, dir: .right)] = false
            }
        }
        
        for str in dirs.enumerated(){
            directions.append(MovingType(rawValue: str.element.description)!)
        }
        for i in 0..<directions.count{
            let dir = directions[i]
            
            //if 범위 넘어가면 무시 //이미 지나간 곳은 cnt no
            
            var destinationX = currentPos[0] + dir.move.first!
            var destinationY = currentPos[1] + dir.move.last!
            
            
            if abs(destinationX) <= 5 && abs(destinationY) <= 5{ //좌표 범위 넘어가지 않는 내에서
                
                if !coordinate[CoodinateType(xPos: currentPos[0], yPos: currentPos[1], dir: dir)]!{
                    coordinate[CoodinateType(xPos: currentPos[0], yPos: currentPos[1], dir: dir)] = true
                    
                    movingDistance += 1
                    
                    print("\(i+1). 지나간적 없는 길 x \(destinationX) y \(destinationY) dir \(dir)")
                    
                    //같은 경로를 쓰는 경우 체크
                    coordinate[CoodinateType(xPos: destinationX, yPos: destinationY, dir: dir.reverseDir)] = true
                    
                }else{
                    print("\(i+1). 😈 지나간적 있음! x \(destinationX) y \(destinationY) dir \(directions[i])")
                }
                
                currentPos[0] = destinationX
                currentPos[1] = destinationY
            }
            
            print("current pos \(currentPos)")
        }
        
        return movingDistance
    }
    
    //2018 KAKAO BLIND RECRUITMENT [3차] 압축
    //: 🌱solution8 (100%)
    func solution8(_ msg:String) -> [Int] {
        
        var wordDictionary = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        var searchNums: [Int] = []
        var beforeStr: String = ""
    
        for msgStr in msg.enumerated(){
            let msgElement = msgStr.element.description
            let newStr = beforeStr + msgElement
            
            if let dictStr = wordDictionary.firstIndex(of: newStr){  //값이 있으면 그 다음을 더한 값까지 있는지 확인하기 위해 계속 값 더하기
                beforeStr = newStr
            }else{ //값이 없으면 그 이전까지의 값을 찾음
                 
                if let otherDictStr = wordDictionary.firstIndex(of: beforeStr.count > 0 ? beforeStr : msgElement){
                    searchNums.append(otherDictStr+1)
                }
                
                wordDictionary.append(newStr)
                beforeStr = msgElement
            }
            
            //마지막 값이면 현재 나온 값까지 색인 값 구하기
            if msgStr.offset == msg.count-1{
                if let lastStr = wordDictionary.firstIndex(of: beforeStr){
                    searchNums.append(lastStr+1)
                }
            }
        }
        print("searchNum \(searchNums)")
        return searchNums
    }
    
    //2021 카카오 채용연계형 인턴십 거리두기 확인하기
    //: 🌱solution9
    func solution9(_ places:[[String]]) -> [Int] {
        
        var result: [Int] = []
        
        struct PosType{
            let row: Int
            let column: Int
            
            var printValue: String{
                "\(row), \(column)"
            }
        }
        
        
        for i in 0..<places.count{ //5번 돌고
            var personPos: [PosType] = []
            var partitionPos: [PosType] = []
            print("i\(i) places \(places[i])")
            for j in 0..<places[i].count{
                let thisRowSeat = places[i][j].enumerated()
                
                let pOffsets = thisRowSeat.filter({$0.element == "P"}).map({$0.offset}) //index(of: "P")
//                print("i\(i)j\(j) \(places[i][j]) 에서 P가 있는 OFFSET \(pOffsets)")
                
                let xOffsets = thisRowSeat.filter({$0.element == "X"}).map({$0.offset})
                
                
                for offset in pOffsets { //최대 5번
                    personPos.append(PosType(row: j, column: offset))
                }
                
                for offset in xOffsets { //최대 5번
                    partitionPos.append(PosType(row: j, column: offset))
                }
            }
            
//            print("i\(i)_person pos \(personPos.map({$0.printValue}))")
        
           
            var isDistanceOK = true
            if personPos.count > 2{
                for j in 0..<personPos.count-2{
                    let first = personPos[j]
                    let second = personPos[j+1]
                    if checkDistanceOK(twoPos: [first,second]){
                        
                    }else{
                        //거리에 따른 거리두기가 false라면 파티션이 있는지 확인
                        print("\(first) 와 \(second) 의 거리두기가 실패했다... 파티션 체크하자")
                        if first.row == second.row{
                            if partitionPos.filter({$0.row == first.row && $0.column == first.column+1}).count == 0{
                                
                                isDistanceOK = false
                                break
                            }else{
                                print("\(first.row), \(first.column+1)에 파티션 있음")
                            }
                        }else if first.column == second.column{
                            if partitionPos.filter({$0.column == first.column && $0.row == first.row+1}).count == 0{
                                
                                isDistanceOK = false
                                break
                            }else{
                                print("\(first.column), \(first.row+1)에 파티션 있음")
                            }
                        }else{
                            
                            
                            print("실패")
                            isDistanceOK = false
                            break
                        }
                        
                    }
                }
            }
            print("\(i)번째 방 거리두기 \(isDistanceOK)")
            result.append(isDistanceOK ? 1:0)
        }
        
        
        func checkDistanceOK(twoPos:[PosType])->Bool{
            let first = twoPos.first
            let second = twoPos.last
            
            //거리 2이하 거리두기 false
            if abs(first!.column - second!.column) <= 2 && abs(first!.row - second!.row) <= 2{
                return false
            }
            return true
        }
        
        
        return result
    }
    
    
    //월간 코드 챌린지 시즌2 괄호 회전하기
    //: 🌱solution10
    //21.4% ㅠ (11~13 빼고 1~14 실패) -> 반례 {{{} , 0 -> 92.9% (14 실패) -> 반례 {(}) , 0 -> solution10ver2
    func checkRight(rotated : [SignKind])->Bool{
        
        var isBigStart: [Bool] = []
        var isMidStart: [Bool] = []
        var isSmallStart: [Bool] = []
        
        
        
        for i in 0..<rotated.count{
            
            let parenthesis = rotated[i]
            print("current \(parenthesis)")
            if parenthesis.isStart{
                switch parenthesis{
                case .bigStart, .bigEnd:
                    isBigStart.append(true)
                    break
                case .midStart, .midEnd:
                    isMidStart.append(true)
                    break
                case .smallStart, .smallEnd:
                    isSmallStart.append(true)
                    break
                }
            }else{
                if parenthesis == .bigStart || parenthesis == .bigEnd{
                    
                    let startIdx = isBigStart.firstIndex(of: true)
                    if let idx = startIdx{
                        isBigStart[idx] = false
                    }else{ //시작하지않았는데 끝난 경우
                        return false
                    }
                }else if parenthesis == .midStart || parenthesis == .midEnd{
                    let startIdx = isMidStart.firstIndex(of: true)
                    if let idx = startIdx{
                        isMidStart[idx] = false
                    }else{
                        return false
                    }
                }else{
                    let startIdx = isSmallStart.firstIndex(of: true)
                    if let idx = startIdx{
                        isSmallStart[idx] = false
                    }else{
                        return false
                    }
                }
            }
        }
        
        //괄호 안닫힌게 있으면 false 리턴
        return isBigStart.filter({$0 == true}).count > 0 || isMidStart.filter({$0 == true}).count > 0 || isSmallStart.filter({$0 == true}).count > 0 ? false : true
    }
    enum SignKind: String{
        case bigStart = "["
        case bigEnd = "]"
        case midStart = "{"
        case midEnd = "}"
        case smallStart = "("
        case smallEnd = ")"
        
        var isStart: Bool{
            switch self {
            case .bigStart, .midStart, .smallStart:
                return true
            default:
                return false
            }
        }
    }
    
    func solution10(_ s:String) -> Int {
        
        var rotated : [SignKind] = []
        var rightCnt = 0
        
        for str in s.enumerated(){
            rotated.append(SignKind(rawValue: String(str.element))!)
        }
        
        for i in 0..<rotated.count{
            
            rotated.append(rotated.first!)
            rotated.removeFirst()
            
            
            
            rightCnt += checkRight(rotated: rotated) == true ? 1:0
            
            print("is Right \(checkRight(rotated: rotated))")
        }
        
        return rightCnt
    }
    
    //: 🌱solution10ver2 (100%)
    func solution10ver2(_ s:String) -> Int {
        
        var rotated : String = ""
        var rightCnt = 0
        
        for str in s.enumerated(){
            rotated.append(String(str.element))
        }
        
        for i in 0..<rotated.count{
            
            rotated += rotated.first!.description
            rotated.removeFirst()
            print(":::::rotated \(rotated)")
            rightCnt += checkRightVer2(rotated: rotated) == true ? 1:0
            
            print("is Right \(checkRightVer2(rotated: rotated))")
        }
        
        return rightCnt
    }
    enum SignVer2Kind: String{
        case big = "[]"
        case mid = "{}"
        case small = "()"
    }
    
    func checkRightVer2(rotated : String)->Bool{
        
        
        var tempStr = ""//rotated
        var popStr = rotated
        
        while tempStr != popStr{
            print("tempStr \(tempStr) popStr \(popStr)")
            
            tempStr = popStr
            
            popStr = popStr.replacingOccurrences(of: SignVer2Kind.big.rawValue, with: "")
            popStr = popStr.replacingOccurrences(of: SignVer2Kind.mid.rawValue, with: "")
            popStr = popStr.replacingOccurrences(of: SignVer2Kind.small.rawValue, with: "")
            
            
            print("result popStr \(popStr)")
        }
        
        return tempStr.count > 0 ? false : true
    }
        
}
