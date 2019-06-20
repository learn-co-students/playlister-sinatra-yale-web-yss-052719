module ApplicationRecord

    def slug
        words = self.name.split(" ")
        low_case_words = words.map do |word|
            word.downcase
        end

        low_case_words.join("-")
    end
end