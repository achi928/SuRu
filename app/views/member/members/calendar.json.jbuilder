json.array!(@posts) do |post|
  json.id post.id
  json.title post.content
  json.start post.created_at
  json.description post.created_at.in_time_zone('Tokyo').strftime('%p %I:%M') + '<br>' + post.content
end