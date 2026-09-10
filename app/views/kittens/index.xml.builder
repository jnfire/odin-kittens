xml.instruct!
xml.kittens do
  @kittens.each do |kitten|
    xml << render(partial: "kittens/kitten", formats: :xml, locals: { kitten: kitten })
  end
end
