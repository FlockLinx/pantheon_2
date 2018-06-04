class StarRankingSerializer < ActiveModel::Serializer
  attributes :ranking

  def ranking
    object.map do |rank|
      {
        name: User.find(rank.first).name,
        stars: rank.last
      }
    end
  end
end
