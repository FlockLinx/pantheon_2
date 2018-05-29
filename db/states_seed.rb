class StatesSeed
  def self.states
    file_path = File.join Rails.root,'db','states.json'
    JSON.parse File.open(file_path).read
  end

  def self.run
    states.each do |state|
      state_obj = State.new(:acronym => state['acronym'],
                            :name => state['name'],
                            :region => state['region'])
      state_obj.save
    end
  end
end
