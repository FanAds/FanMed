module Jekyll
  module TruncateLettersFilter
    def truncateletters(input)
      if input.length > 70
      	return input[0..70] + "..."
      else
      	return input
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::TruncateLettersFilter)
