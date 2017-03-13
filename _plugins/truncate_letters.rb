module Jekyll
  module TruncateLettersFilter
    def truncateletters(input)
      if input.length > 35
      	return input[0..35] + "..."
      else
      	return input
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::TruncateLettersFilter)
