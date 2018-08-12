module Cran
  class Parser
    def self.parse(*args)
      new(*args).parse
    end

    def initialize(text)
      @text = text
    end

    def parse
      paragraphs.map do |paragraph|
        paragraph = normalize_values(paragraph)
        paragraph_attributes(paragraph)
      end
    end

    private

    def rcf822_parser(value)
      rcf822_entries(value).map do |contact|
        captures = rcf822_captures(contact)
        next unless captures

        {
          name: rcf822_sanatize(captures[0]),
          email: rcf822_sanatize(captures[1])
        }
      end.compact
    end

    def rcf822_entries(str)
      str.split(/\sand\s|,/)
    end

    def rcf822_captures(str)
      results = str.strip.match(/([\w\s]+)(\<[\w@.]+\>)/)
      return unless results

      results.captures
    end

    def rcf822_sanatize(str)
      str.to_s.strip.gsub(/[<>]/, '')
    end

    def paragraphs
      @text.split(/^\n+/)
    end

    def normalize_values(paragraph_text)
      paragraph_text.gsub(/((.*\n){1})^[^\n]\s+(.+)/) do |key_value|
        key_value.lines.map(&:strip).join(' ')
      end
    end

    def attribute(line)
      entries = line.split(/:\s/)
      key = entries[0].to_s.underscore.tr('/', '_').to_sym
      value = entries[1].to_s.chomp

      # Ignores the "Authors@R:"" metadata
      # http://r-pkgs.had.co.nz/description.html
      value = rcf822_parser(value) if %i[author maintainer].include?(key)

      [key, value]
    end

    def paragraph_attributes(paragraph)
      {}.tap do |h|
        paragraph.lines.each do |line|
          kv = attribute(line)
          h[kv[0]] = kv[1]
        end
      end
    end
  end
end
