require "net/https"
require "json"

module DeepL
    Url = "https://api-free.deepl.com/v2/translate"

    def request(text)    
        data = {
            "auth_key": ENV["DEEPL_TOKEN"],
            "text": text,
            "target_lang": "JA"
        }
        res = Net::HTTP.post_form(URI.parse(Url), data)
        h = JSON.parse(res.body)
        translations = h["translations"]
        translated = translations[0]["text"] if translations
        translated
    end

    module_function :request
end
