import Foundation

public enum OpenRouterError: LocalizedError {
    case invalidResponse
    case missingContent
    case decodingFailed(String)

    public var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "OpenRouter 返回无效响应。"
        case .missingContent:
            return "OpenRouter 未返回可解析内容。"
        case .decodingFailed(let raw):
            return "识别结果解析失败: \(raw)"
        }
    }
}

public final class OpenRouterFaceRecognizer: FaceRecognizer {
    private let apiKey: String
    private let model: String
    private let endpoint: URL
    private let session: URLSession

    public init(
        apiKey: String,
        model: String = "openai/gpt-4.1-mini",
        endpoint: URL = URL(string: "https://openrouter.ai/api/v1/chat/completions")!,
        session: URLSession = .shared
    ) {
        self.apiKey = apiKey
        self.model = model
        self.endpoint = endpoint
        self.session = session
    }

    public func recognize(imageData: Data) async throws -> FaceProfile {
        let imageBase64 = imageData.base64EncodedString()
        let prompt = Self.promptTemplate
        let dataURL = "data:image/jpeg;base64,\(imageBase64)"

        let payload: [String: Any] = [
            "model": model,
            "temperature": 0.1,
            "messages": [
                [
                    "role": "system",
                    "content": "You are a strict visual extractor. Return valid JSON only."
                ],
                [
                    "role": "user",
                    "content": [
                        [
                            "type": "text",
                            "text": prompt
                        ],
                        [
                            "type": "image_url",
                            "image_url": [
                                "url": dataURL
                            ]
                        ]
                    ]
                ]
            ]
        ]

        let body = try JSONSerialization.data(withJSONObject: payload, options: [])
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("FaceXiangMVP/1.0", forHTTPHeaderField: "X-Title")

        let (responseData, response) = try await session.data(for: request)
        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw OpenRouterError.invalidResponse
        }

        let content = try extractContent(from: responseData)
        let jsonText = extractJSONObject(from: content)
        guard let jsonData = jsonText.data(using: .utf8) else {
            throw OpenRouterError.missingContent
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(FaceProfile.self, from: jsonData)
        } catch {
            throw OpenRouterError.decodingFailed(jsonText)
        }
    }

    private func extractContent(from data: Data) throws -> String {
        let raw = try JSONSerialization.jsonObject(with: data, options: [])
        guard
            let dict = raw as? [String: Any],
            let choices = dict["choices"] as? [[String: Any]],
            let first = choices.first,
            let message = first["message"] as? [String: Any]
        else {
            throw OpenRouterError.invalidResponse
        }

        if let text = message["content"] as? String {
            return text
        }

        if let contentArray = message["content"] as? [[String: Any]] {
            let text = contentArray.compactMap { $0["text"] as? String }.joined(separator: "\n")
            if !text.isEmpty {
                return text
            }
        }

        throw OpenRouterError.missingContent
    }

    private func extractJSONObject(from text: String) -> String {
        let trimmed = text
            .replacingOccurrences(of: "```json", with: "")
            .replacingOccurrences(of: "```", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard
            let start = trimmed.firstIndex(of: "{"),
            let end = trimmed.lastIndex(of: "}")
        else {
            return trimmed
        }
        return String(trimmed[start...end])
    }

    private static let promptTemplate = """
    Analyze the face in this image and output a JSON object only.
    Use this exact schema and values:
    {
      "face_id": "string",
      "quality": {
        "single_face": true,
        "frontal_score": 0.0,
        "clarity_score": 0.0,
        "lighting": "bright|balanced|dim|backlit",
        "occlusion": "none|low|medium|high"
      },
      "features": {
        "forehead": "broad|balanced|narrow|high|low",
        "eyebrows": "longRising|crescent|straight|thickDense|sparse|shortBroken",
        "eyes": "clearBright|peachBlossom|triangle|threeWhite|fishLike|deepSet",
        "nose": "fullRound|straightBridge|broadWing|thinPointed|hooked|flatWeak",
        "mouth": "balanced|upturned|downturned|thick|thin|blurryEdges",
        "ears": "highSet|lowSet|thickLobe|smallThin|protruding|closeFit",
        "chin": "roundFull|squareFirm|pointed|receding|long",
        "complexion": "bright|yellowish|pale|dark|mixed"
      },
      "palace_signals": [
        {
          "palace": "life|wealth|career|relationship|health|travel|support",
          "status": "strong|stable|weak|blocked"
        }
      ],
      "confidence": 0.0
    }
    Rules:
    - Keep numeric values in [0,1].
    - Always include exactly 7 palace_signals, one per palace.
    - Do not include extra fields.
    - Output JSON only, no markdown.
    """
}

public final class MockFaceRecognizer: FaceRecognizer {
    public init() {}

    public func recognize(imageData: Data) async throws -> FaceProfile {
        let seed = imageData.reduce(0) { ($0 + Int($1)) % 10_000 }
        let faceID = "mock-\(seed)"

        let forehead = ForeheadType.allCases[seed % ForeheadType.allCases.count]
        let eyebrows = EyebrowType.allCases[seed % EyebrowType.allCases.count]
        let eyes = EyeType.allCases[(seed / 2) % EyeType.allCases.count]
        let nose = NoseType.allCases[(seed / 3) % NoseType.allCases.count]
        let mouth = MouthType.allCases[(seed / 4) % MouthType.allCases.count]
        let ears = EarType.allCases[(seed / 5) % EarType.allCases.count]
        let chin = ChinType.allCases[(seed / 6) % ChinType.allCases.count]
        let complexion = ComplexionType.allCases[(seed / 7) % ComplexionType.allCases.count]

        let palaceStatuses = PalaceName.allCases.enumerated().map { index, palace in
            let status = PalaceStatus.allCases[(seed + index) % PalaceStatus.allCases.count]
            return PalaceSignal(palace: palace, status: status)
        }

        return FaceProfile(
            faceID: faceID,
            quality: FaceQuality(
                singleFace: true,
                frontalScore: 0.76,
                clarityScore: 0.81,
                lighting: .balanced,
                occlusion: .low
            ),
            features: FaceFeatures(
                forehead: forehead,
                eyebrows: eyebrows,
                eyes: eyes,
                nose: nose,
                mouth: mouth,
                ears: ears,
                chin: chin,
                complexion: complexion
            ),
            palaceSignals: palaceStatuses,
            confidence: 0.72
        )
    }
}
