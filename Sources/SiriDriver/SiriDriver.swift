import Cocoa
import AVFoundation

// REMARK!!!
// Making this class a subclass AVSpeechSynthesizer instead of using it
// causes the synthesizer to work only once!

@available(OSX 10.14, *)
public class SiriDriver{
    
    var syntheSizer:AVSpeechSynthesizer!
    let voice:AVSpeechSynthesisVoice!
    let speedRate:Float
    
    public init(language:SiriLanguage, speed speedAsPercentage:Float = 50.0){
        self.voice = AVSpeechSynthesisVoice(language: language.rawValue)
        
        let speedRateAsPercentage = min(max(speedAsPercentage, 0.0), 100.0)
        speedRate = (AVSpeechUtteranceMaximumSpeechRate-AVSpeechUtteranceMinimumSpeechRate)*(speedRateAsPercentage/100.0)
    }
    
    public func speak(text: String){
        
        let textToSpeak = AVSpeechUtterance(string: text)
        textToSpeak.voice = self.voice
        
        textToSpeak.rate = self.speedRate
        
        syntheSizer = AVSpeechSynthesizer()
        syntheSizer.pauseSpeaking(at: .word)
        syntheSizer.speak(textToSpeak)
    }
    
}

public enum SiriLanguage:String{
    case flemish = "nl-be"
    case american = "en-us"
}
