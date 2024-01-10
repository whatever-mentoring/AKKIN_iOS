//
//  StringLiteral.swift
//  AKKIN
//
//  Created by 박지윤 on 2023/09/26.
//

import Foundation

public enum AkkinString {
    // Onboarding
    public static let startAkkin = "아낀거지 시작하기"

    // Main
    public static let todayAkkin = "오늘 얼마 아낀거지?"
    public static let emptyAkkin = """
        만들어진 카드가 없어요.
        우측 상단의 + 버튼을 통해
        아낀 내역을 추가해보세요.
        """

    // Category
    public static let total = "전체"
    public static let dining = "식비"
    public static let traffic = "교통"
    public static let shopping = "쇼핑"
    public static let etc = "기타"

    public static let DINING = "DINING"
    public static let TRAFFIC = "TRAFFIC"
    public static let SHOPPING = "SHOPPING"
    public static let ETC = "ETC"

    // Card Input
    public static let imageInputGuide = "위 카드를 선택하거나\n추가하기를 선택해\n아낀 카드를 만들어보세요!"
    public static let userImageInput = "사진을 넣어 나만의\n아낀 카드를 만들어보세요!"
    public static let category = "카테고리"
    public static let categoryGuide = "(1개의 소비 카테고리를 선택해주세요.)"
    public static let date = "날짜"
    public static let datePlaceholder = "YYYY / MM / DD"
    public static let content = "소비내용"
    public static let contentPlaceholder = "어떤 소비를 했는지 적어보세요."
    public static let how = "아낀방법"
    public static let howPlaceholder = "어떻게 아끼셨나요? ex. 편의점 물 대신 빗물 마시기"
    public static let expect = "예상 비용"
    public static let expectPlaceholder = "100,000,000"
    public static let real = "실제 비용"
    public static let realPlaceholder = "100,000,000"
    public static let makeGulbis = "카드 만들기"
    public static let postGulbis = "기록하기"

    // Card Made
    public static let completeAkkin = "오늘의 소비 카드가 \n완성됐어요."
    public static let saveImage = "이미지 저장하기"
    public static let shareImage = "이미지 공유하기"
    public static let saveSuccessToast = " 이미지가 성공적으로 저장되었습니다. "

    // Card Detail
    public static let cardDetail = "카드 상세 내용"
    public static let patchGulbis = "수정"
    public static let deleteGulbis = "삭제"
    public static let cancel = "닫기"
    public static let cardDeleteTitle = "카드를 정말 삭제할까요?"
    public static let cardDeleteMessage = "이 동작은 취소할 수 없어요."

    // Card Patch
    public static let patchGulbisTitle = "카드 내용 수정"
    public static let confirm = "완료"
}
