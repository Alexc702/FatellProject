import Foundation

public struct FaceProfile: Codable, Equatable {
    public var faceID: String
    public var quality: FaceQuality
    public var features: FaceFeatures
    public var palaceSignals: [PalaceSignal]
    public var confidence: Double

    public init(
        faceID: String,
        quality: FaceQuality,
        features: FaceFeatures,
        palaceSignals: [PalaceSignal],
        confidence: Double
    ) {
        self.faceID = faceID
        self.quality = quality
        self.features = features
        self.palaceSignals = palaceSignals
        self.confidence = confidence
    }

    enum CodingKeys: String, CodingKey {
        case faceID = "face_id"
        case quality
        case features
        case palaceSignals = "palace_signals"
        case confidence
    }
}

public struct FaceQuality: Codable, Equatable {
    public var singleFace: Bool
    public var frontalScore: Double
    public var clarityScore: Double
    public var lighting: Lighting
    public var occlusion: OcclusionLevel

    public init(
        singleFace: Bool,
        frontalScore: Double,
        clarityScore: Double,
        lighting: Lighting,
        occlusion: OcclusionLevel
    ) {
        self.singleFace = singleFace
        self.frontalScore = frontalScore
        self.clarityScore = clarityScore
        self.lighting = lighting
        self.occlusion = occlusion
    }

    enum CodingKeys: String, CodingKey {
        case singleFace = "single_face"
        case frontalScore = "frontal_score"
        case clarityScore = "clarity_score"
        case lighting
        case occlusion
    }
}

public enum Lighting: String, Codable, CaseIterable {
    case bright
    case balanced
    case dim
    case backlit
}

public enum OcclusionLevel: String, Codable, CaseIterable {
    case none
    case low
    case medium
    case high
}

public struct FaceFeatures: Codable, Equatable {
    public var forehead: ForeheadType
    public var eyebrows: EyebrowType
    public var eyes: EyeType
    public var nose: NoseType
    public var mouth: MouthType
    public var ears: EarType
    public var chin: ChinType
    public var complexion: ComplexionType

    public init(
        forehead: ForeheadType,
        eyebrows: EyebrowType,
        eyes: EyeType,
        nose: NoseType,
        mouth: MouthType,
        ears: EarType,
        chin: ChinType,
        complexion: ComplexionType
    ) {
        self.forehead = forehead
        self.eyebrows = eyebrows
        self.eyes = eyes
        self.nose = nose
        self.mouth = mouth
        self.ears = ears
        self.chin = chin
        self.complexion = complexion
    }
}

public enum ForeheadType: String, Codable, CaseIterable {
    case broad
    case balanced
    case narrow
    case high
    case low
}

public enum EyebrowType: String, Codable, CaseIterable {
    case longRising
    case crescent
    case straight
    case thickDense
    case sparse
    case shortBroken
}

public enum EyeType: String, Codable, CaseIterable {
    case clearBright
    case peachBlossom
    case triangle
    case threeWhite
    case fishLike
    case deepSet
}

public enum NoseType: String, Codable, CaseIterable {
    case fullRound
    case straightBridge
    case broadWing
    case thinPointed
    case hooked
    case flatWeak
}

public enum MouthType: String, Codable, CaseIterable {
    case balanced
    case upturned
    case downturned
    case thick
    case thin
    case blurryEdges
}

public enum EarType: String, Codable, CaseIterable {
    case highSet
    case lowSet
    case thickLobe
    case smallThin
    case protruding
    case closeFit
}

public enum ChinType: String, Codable, CaseIterable {
    case roundFull
    case squareFirm
    case pointed
    case receding
    case long
}

public enum ComplexionType: String, Codable, CaseIterable {
    case bright
    case yellowish
    case pale
    case dark
    case mixed
}

public struct PalaceSignal: Codable, Equatable {
    public var palace: PalaceName
    public var status: PalaceStatus

    public init(palace: PalaceName, status: PalaceStatus) {
        self.palace = palace
        self.status = status
    }
}

public enum PalaceName: String, Codable, CaseIterable {
    case life
    case wealth
    case career
    case relationship
    case health
    case travel
    case support
}

public enum PalaceStatus: String, Codable, CaseIterable {
    case strong
    case stable
    case weak
    case blocked
}

public enum LifeDomain: String, CaseIterable, Codable {
    case career
    case wealth
    case relationship
    case vitality
    case social

    public var title: String {
        switch self {
        case .career:
            return "事业"
        case .wealth:
            return "财务"
        case .relationship:
            return "感情"
        case .vitality:
            return "状态"
        case .social:
            return "人际"
        }
    }
}

public struct AnalysisReport: Codable, Equatable {
    public var overallSummary: String
    public var keySignals: [String]
    public var caution: String
    public var domainScores: [LifeDomain: Int]

    public init(
        overallSummary: String,
        keySignals: [String],
        caution: String,
        domainScores: [LifeDomain: Int]
    ) {
        self.overallSummary = overallSummary
        self.keySignals = keySignals
        self.caution = caution
        self.domainScores = domainScores
    }

    public func score(for domain: LifeDomain) -> Int {
        domainScores[domain] ?? 50
    }

    public var orderedScoreItems: [(LifeDomain, Int)] {
        domainScores.sorted { $0.value > $1.value }
    }
}

public struct WorkflowResult: Equatable {
    public var profile: FaceProfile
    public var report: AnalysisReport
    public var answer: String

    public init(profile: FaceProfile, report: AnalysisReport, answer: String) {
        self.profile = profile
        self.report = report
        self.answer = answer
    }
}
