json.array!(@posts) do |schedule|
  json.id schedule.id
  json.title schedule.content
  json.start schedule.created_at.in_time_zone('Tokyo')
end