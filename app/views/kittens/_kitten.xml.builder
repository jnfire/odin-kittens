xml.instruct!
xml.kitten do
  xml.id kitten.id
  xml.name kitten.name
  xml.age kitten.age
  xml.cuteness kitten.cuteness
  xml.softness kitten.softness
  xml.created_at kitten.created_at
  xml.updated_at kitten.updated_at
  xml.url kitten_url(kitten, format: :xml)
end
