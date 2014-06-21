json.array!(@chapters) do |chapter|
  json.extract! chapter, :id, :title, :introtext, :fulltext, :active, :death, :ending, :beginning, :book_id
  json.url chapter_url(chapter, format: :json)
end
