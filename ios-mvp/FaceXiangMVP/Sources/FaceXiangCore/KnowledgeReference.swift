import Foundation

public enum KnowledgeReference {
    public static let fiveOfficials: [(name: String, alias: String)] = [
        ("耳", "采听官"),
        ("眉", "保寿官"),
        ("眼", "监察官"),
        ("鼻", "审辨官"),
        ("口", "出纳官")
    ]

    public static let threeZones: [(name: String, meaning: String)] = [
        ("上停", "主初运、思维与先天基础"),
        ("中停", "主中年执行力与财禄"),
        ("下停", "主晚运、福泽与承载力")
    ]

    public static let keyPalaces: [(name: String, mappedDomain: LifeDomain)] = [
        ("命宫", .vitality),
        ("财帛宫", .wealth),
        ("夫妻宫", .relationship),
        ("官禄宫", .career),
        ("福德宫", .social),
        ("疾厄宫", .vitality)
    ]
}
