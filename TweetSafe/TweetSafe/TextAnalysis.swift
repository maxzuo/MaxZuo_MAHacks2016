//
//  TextAnalysis.swift
//  TweetSafe
//
//  Created by Max Zuo on 12/3/16.
//  Copyright © 2016 liZUOrd. All rights reserved.
//

import Foundation

class TextAnalysis {
    
    static let positiveWords = ["adorable", "accepted", "acclaimed", "accomplish", "accomplishment", "achievement", "action", "active", "admire", "adventure", "affirmative", "affluent", "agree", "agreeable", "amazing", "angelic", "appealing", "approve", "aptitude", "attractive", "awesome", "beaming", "beautiful", "believe", "beneficial", "bliss", "bountiful", "bounty", "brave", "bravo", "brilliant", "celebrated", "certain", "champ", "champion", "charming", "cheery", "commend", "composed", "congratulation", "constant", "cool", "courageous", "creative", "cute", "dazzling", "delight", "delightful", "distinguished", "divine", "earnest", "easy", "ecstatic", "effective", "effervescent", "efficient", "effortless", "electrifying", "elegant", "enchanting", "encouraging", "endorsed", "energetic", "hope", "energized", "engaging", "enthusiastic", "essential", "esteemed", "ethical", "excellent", "exciting", "exquisite", "fabulous", "fair", "familiar", "famous", "fantastic", "favorable", "fetching", "fine", "fitting", "flourishing", "fortunate", "friendly", "fun", "funny", "generous", "genius", "genuine", "giving", "glamorous", "glowing", "good", "gorgeous", "graceful", "great", "green", "grin", "growing", "handsome", "happy", "harmonious", "healing", "healthy", "hearty", "heavenly", "honest", "honorable", "honored", "hug", "idea", "ideal", "imaginative", "imagine", "impressive", "independent", "innovate", "innovative", "instant", "instantaneous", "instinctive", "intuitive", "intellectual", "intelligent", "inventive", "jovial", "joy", "jubilant", "keen", "kind", "knowing", "knowledgeable", "laugh", "legendary", "learned", "lively", "lovely", "lucid", "lucky", "luminous", "marvelous", "masterful", "meaningful", "merit", "meritorious", "miraculous", "motivating", "moving", "natural", "nice", "nurturing", "optimistic", "paradise", "perfect", "phenomenal", "pleasurable", "plentiful", "pleasant", "poised", "polished", "popular", "positive", "powerful", "prepared", "pretty", "principled", "productive", "progress", "protected", "proud", "reassuring", "refined", "refreshing", "rejoice", "reliable", "remarkable", "resounding", "respected", "restored", "reward", "rewarding", "right", "robust", "safe", "satisfactory", "secure", "seemly", "simple", "skilled", "skillful", "smile", "soulful", "sparkling", "special", "spirited", "spiritual", "stirring", "stupendous", "success", "successful", "sunny", "super", "superb", "supporting", "surprising", "terrific", "thorough", "thrilling", "thriving", "tranquil", "transforming", "transformative", "trusting", "truthful", "unwavering", "upbeat", "upright", "upstanding", "valued", "vibrant", "victorious", "victory", "vigorous", "virtuous", "vital", "vivacious", "wealthy", "welcome", "well", "whole", "wholesome", "willing", "wonderful", "wondrous", "worthy", "hello", "helping"]
    
    static let negativeWords = ["abandoned", "abused", "accused", "addicted", "afraid", "aggravated", "aggressive", "alone", "angry", "anguish", "annoyed", "anxious", "apprehensive", "argumentative", "artificial", "ashamed", "assaulted", "atrocious", "attacked", "avoided", "awful", "awkward", "bad", "badgered", "baffled", "banned", "barren", "beat", "beatendown", "belittled", "berated", "betrayed", "bitter", "bizarre", "blacklisted", "blackmailed", "blamed", "bleak", "blur", "bored", "boring", "bossed-around", "bothered", "bothersome", "bounded", "boxed-in", "broken", "bruised", "brushed-off", "bugged", "bullied", "bummed", "burdened", "burdensome", "burned", "burned-out", "careless", "chaotic", "chased", "cheated", "chicken", "claustrophobic", "clingy", "closed", "clueless", "clumsy", "coaxed", "codependent", "coerced", "cold", "cold-hearted", "combative", "commanded", "compared", "competitive", "compulsive", "conceited", "concerned", "confined", "conflicted", "confronted", "confused", "conned", "consumed", "contemplative", "contempt", "contentious", "controlled", "convicted", "cornered", "corralled", "cowardly", "crabby", "cramped", "cranky", "crap", "crappy", "crazy", "creepy", "critical", "criticized", "cross", "crowded", "cruddy", "crummy", "crushed", "cut-down", "cut-off", "cynical", "damaged", "damned", "dangerous", "dark", "dazed", "dead", "deceived", "deep", "defamed", "defeated", "defective", "defenseless", "defensive", "defiant", "deficient", "deflated", "degraded", "dehumanized", "dejected", "delicate", "deluded", "demanding", "demeaned", "demented", "demoralized", "demotivated", "dependent", "depleted", "depraved", "depressed", "deprived", "deserted", "desolate", "despair", "despairing", "desperate", "despicable", "despised", "destroyed", "destructive", "detached", "detest", "detestable", "detested", "devalued", "devastated", "deviant", "devoid", "diagnosed", "dictated", "different", "difficult", "directionless", "dirty", "disabled", "disagreeable", "disappointed", "disappointing", "disapproved", "disbelieved", "discardable", "discarded", "disconnected", "discontent", "discouraged", "discriminated", "disdain", "disdainful", "disempowered", "disenchanted", "disgraced", "disgruntled", "disgust", "disgusted", "disheartened", "dishonest", "dishonorable", "disillusioned", "dislike", "disliked", "dismal", "dismayed", "disorganized", "disoriented", "disowned", "displeased", "disposable", "disregarded", "disrespected", "dissatisfied", "distant", "distracted", "distraught", "distressed", "disturbed", "dizzy", "dominated", "doomed", "double-crossed", "doubt", "down", "drained", "dramatic", "dread", "dreadful", "dreary", "dropped", "drunk", "dry", "dumb", "dumped", "duped", "edgy", "egocentric", "egotistic", "egotistical", "elusive", "emancipated", "emasculated", "embarrassed", "emotional", "emotionless", "empty", "encumbered", "endangered", "enraged", "enslaved", "entangled", "evaded", "evasive", "evicted", "excessive", "excluded", "exhausted", "exploited", "exposed", "fake", "false", "fear", "fearful", "flawed", "forced", "forgetful", "forgettable", "forgotten", "fragile", "frightened", "frigid", "frustrated", "furious", "gloomy", "glum", "gothic", "grey", "grief", "grim", "gross", "grossed-out", "grotesque", "grouchy", "grounded", "grumpy", "guilt-tripped", "guilty", "harassed", "hard", "hard-hearted", "harmed", "hassled", "hate", "hateful", "hatred", "haunted", "heartbroken", "heartless", "heavy-hearted", "helpless", "hesitant", "hideous", "hindered", "hopeless", "horrible", "horrified", "horror", "hostile", "hot-tempered", "humiliated", "hungover", "hurried", "hurt", "hysterical", "idiotic", "ignorant", "ignored", "ill", "ill-tempered", "imbalanced", "imposed-upon", "impotent", "imprisoned", "impulsive", "inactive", "inadequate", "incapable", "incommunicative", "incompetent", "incompatible", "incomplete", "incorrect", "indecisive", "indifferent", "indoctrinated", "inebriated", "ineffective", "inefficient", "inferior", "infuriated", "inhibited", "inhumane", "injured", "injustice", "insane", "insecure", "insignificant", "insincere", "insufficient", "insulted", "intense", "interrogated", "interrupted", "intimidated", "intoxicated", "invalidated", "invisible", "irrational", "irritable", "irritated", "isolated", "jaded", "jealous", "jerk", "joyless", "judged", "keptaway", "labeled", "laughable", "lazy", "letdown", "lied", "limited", "little", "lonely", "lonesome", "longing", "lost", "lousy", "loveless", "low", "mad", "manhandled", "manipulated", "masochistic", "messy", "miffed", "miserable", "misled", "mistaken", "mistreated", "mistrusted", "misunderstood", "mixed-up", "mocked", "molested", "moody", "nagged", "needy", "negative", "nervous", "neurotic", "nonconforming", "numb", "nuts", "nutty", "objectified", "obligated", "obsessed", "obsessive", "obstructed", "odd", "offended", "opposed", "oppressed", "over-controlled", "over-protected", "overwhelmed", "pain", "panic", "paranoid", "passive", "pathetic", "pessimistic", "petrified", "phony", "pissed", "plain", "playedwith", "pooped", "poor", "powerless", "pre-judged", "preoccupied", "prejudiced", "pressured", "prosecuted", "provoked", "psychopathic", "psychotic", "punished", "pushed", "putdown", "puzzled", "quarrelsome", "queer", "questioned", "quiet", "rage", "raped", "rattled", "regret", "rejected", "resented", "resentful", "responsible", "retarded", "revengeful", "ridiculed", "ridiculous", "robbed", "rotten", "sad", "sadistic", "sarcastic", "scared", "scarred", "screwed", "self-centered", "self-conscious", "self-destructive", "self-hatred", "selfish", "singled-out", "slow", "small", "smothered", "spiteful", "stereotyped", "strange", "stressed", "stretched", "stuck", "stupid", "submissive", "suffering", "suffocated", "suicidal", "superficial", "suppressed", "suspicious", "pussy", "fuck", "nigger", "cunt", "shit", "hell", "devil", "slut", "negro", "gook", "whore", "harlot", "cock", "chink", "dick", "petty", "terrible", "taint", "depression", "died", "kill", "arrest", "death", "tragic", "storm", "tornado", "fire", "alarm", "anger", "racism", "racist", "sexist", "firing", "viciously", "vicious", "fight", "suck", "fucking", "ass", "asshole", "bitch", "flames"]
    
    static let punctuationMarks = [",", ".", "!", "\"", "?", "(", ")", "{", "}"]
    
    class func analyzeSentiment(text: String) -> Float {
        
        var sentiment: Float = 0.0
        
        let words = text.components(separatedBy: " ")
        var wordCount = 0
        var editedWord = ""
        for word in words {
            
            //REMOVE PUNCTUATION MARKS (BUT NOT ' BECAUSE IT COULD BE "DON'T" FOR EXAMPLE)
            for mark in punctuationMarks {
                for char in word.components(separatedBy: "") {
                    if char != mark {
                        editedWord += char
                    }
                }
            }
            var additionToSentiment: Float = 0.0
            
            //CHECKS IF THERE ARE POSITIVE WORDS
            for positiveWord in positiveWords {
                if editedWord.lowercased() == positiveWord {
                    additionToSentiment += 1
                }
                else if editedWord.lowercased().contains(positiveWord) {
                    additionToSentiment += 0.5
                }
            }
            //CHECKS IF THERE ARE NEGATIVE WORDS
            for negativeWord in negativeWords {
                if word.lowercased() == negativeWord {
                    additionToSentiment -= 1
                }
                else if editedWord.lowercased().contains(negativeWord) {
                    additionToSentiment -= 0.5
                }
            }
            
            //SEE IF THERE IS A "NOT" IN FRONT OF WORD, THIS WOULD FLIP VALUE OF CURRENT WORD
            if wordCount != 0 {
                if words[wordCount - 1].lowercased().contains("n't") || words[wordCount - 1].lowercased() == "not" {
                    additionToSentiment *= -1
                }
            }
            wordCount += 1
            sentiment += additionToSentiment
        }
        
        //DIVIDE TO FIND VALUE FOR WHOLE TWEET
        return (sentiment/(Float(words.count)))
    }
    
}
