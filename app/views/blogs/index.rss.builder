xml.instruct!

xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
  xml.channel do
    
    xml.title 'BT Blogs'
    xml.link blogs_url
    xml.description 'Aggregation of blogs by BT people'
    
    @entries.each do |e|
      xml.item do
        xml.title e.title
        xml.description e.content
      end
    end
  end
end