xml.instruct!
xml << render(partial: "kittens/kitten", formats: :xml, locals: { kitten: @kitten })
