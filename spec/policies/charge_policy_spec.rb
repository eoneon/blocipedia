require 'rails_helper'

RSpec.describe ChargePolicy do
  describe '#create?' do
    context 'when the user is already premium' do
      let(:user) { User.create!(email: 'a@a.com', password: '12345678', role: :premium) }
      
      it "is not allowed" do
        expect(ChargePolicy.new(user, nil).create?).to eq(false)
      end
    end

    context "when the user is standard" do
      let(:user) {  User.create!(email: 'a@a.com', password: '12345678', role: :standard) }

      it "is allowed" do
        expect(ChargePolicy.new(user, nil).create?).to eq(true)
      end
    end
  end
end
