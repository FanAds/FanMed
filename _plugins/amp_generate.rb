module Jekyll
  # Defines the base class of AMP posts
  class AmpPost < Page
    def initialize(site, base, dir, post)
      dirStructure = dir.split('/')
      @site = site
      @base = base
      @dir = dirStructure.slice(0,4).join('/')
      @name = dirStructure[4] + '.html'
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'amp.html')
      self.content               = post.content
      self.data['body']          = (Liquid::Template.parse post.content).render site.site_payload
      self.data['title']         = post.data['title']
      self.data['date']          = post.data['date']
      self.data['author']        = post.data['author']
      self.data['category']      = post.data['category']
      self.data['canonical_url'] = post.url
      self.data['page_id']       = post.data['page_id']
      self.data['article_id']    = post.data['article_id']
    end
  end
  # Generates a new AMP post for each existing post
  class AmpGenerator < Generator
    priority :low
    def generate(site)
      dir = site.config['ampdir'] || 'amp'
      site.posts.docs.each do |post|
        next if post.data['skip_amp'] == true
        site.pages << AmpPost.new(site, site.source, File.join(dir, post.id), post)
      end
    end
  end
end
