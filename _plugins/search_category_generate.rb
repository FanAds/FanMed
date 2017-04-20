module Jekyll
	require 'json'
	class SearchCategoryGenerator < Generator
		safe true
    	priority :low
		
		def generate(site)
			dir = 'search'
			file_name = 'category_index.json'
			category_index = Hash.new
			path = "search"

			site.posts.docs.each do |post|
				item = { :url => site.config['url'] + post.url, :title => post.data['title'], :date => post.data['date'].to_i }
				if post.data.has_key? 'cover' and not post.data['category'].nil? and not post.data['cover'].empty?
					item[:cover] = post.data['cover']
				end
				category = post.data['category']
				if category_index.has_key?(category)
					category_index[category] << item
				else
					category_index[category] = Array.new
					category_index[category] << item
				end
			end

			category_index.each do |key, value|
				value.sort_by { |hsh| hsh[:date] }
			end

			FileUtils.mkpath(path) unless File.exists?(path)

			f = File.new("#{path}/#{file_name}", "w+")
        	f.puts JSON.generate(category_index)

        	site.static_files << Jekyll::StaticFile.new(site, site.source, path, file_name)
		end
	end

end
