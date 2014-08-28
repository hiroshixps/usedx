require 'rubygems'
require 'bundler/setup'
Bundler.require

options = {
  :user_agent => "AnemoneCrawler/0.0.1",
  :storage => Anemone::Storage.MongoDB,
  :delay => 1,
  :depth_limit => 1,
}
@url ='http://kakaku.com/item/K0000041681/'
Anemone.crawl(@url, options) do |anemone|

  anemone.focus_crawl do |page|
    page.links.keep_if { |link|
      link.to_s.match(/test/)
    }
  end

  anemone.on_every_page do |page|
    if page.doc
      p page.url.to_s
      p page.doc.xpath('//h2').inner_text
      p page.doc.xpath('//li[@class = "makerLabel"]/a').inner_text
      p page.doc.xpath('//li[@class = "seriesLabel"]/a').inner_text
      p page.doc.xpath('//div[@class = "path btmPath"]/*[2]').inner_text
      p page.doc.xpath('//div[@class = "path btmPath"]/*[3]').inner_text
      p page.doc.xpath('//span[@id = "minPrice"]/a').inner_text

    end
  end

end

@url2 = @url + "spec/#tab"
Anemone.crawl(@url2, options) do |anemone|

  anemone.focus_crawl do |page|
    page.links.keep_if { |link|
      link.to_s.match(/test/)
    }
  end

  anemone.on_every_page do |page|
    if page.doc
      p page.url.to_s
      p page.doc.xpath('//table').inner_html

    end
  end

end
