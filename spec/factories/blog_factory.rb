Factory.define :blog do |b|
  b.owner_name 'Joe Bloggs'
  b.owner_email 'joe.bloggs@bt.com'
  b.html_uri 'http://joebloggs.com'
  b.feed_uri 'http://joebloggs.com/feed'
end

Factory.define :confirmed_blog, :parent => :blog do |b|
  b.confirmed true
end
