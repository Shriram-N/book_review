json.extract! book, :id, :Title, :Summary, :Rating, :Author, :Ranking, :Awards, :Recommended_by, :Amazon, :Audiobook, :Animated_Review, :created_at, :updated_at
json.url book_url(book, format: :json)