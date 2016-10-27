require 'rails_helper'

RSpec.describe CollaborationPolicy do
  describe '#create?' do
    it 'for a user who does not own a wiki but is premium should not succeed' do
      user = User.create!(email: 'a@a.com', password: '12345678', role: :premium)
      other_user = User.create!(email: 'b@a.com', password: '12345678', role: :premium)
      wiki = Wiki.create!(user: other_user)
      expect(CollaborationPolicy.new(user, Collaboration.new(wiki: wiki, user: user)).create?).to_not eq(true)
    end
  end
end
