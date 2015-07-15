require 'rails_helper'

RSpec.describe User, :type => :model do
  let!(:user) do
    User.create(name: "Jim",
                uid: "234987234",
                provider: "twitter")
  end

  it "is valid" do
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user.name = nil
    expect(user).not_to be_valid

    user.name = ""
    expect(user).not_to be_valid
  end

  it 'cannot create a user with the same name' do
    user1 = User.create(name: "Jim")
    user2 = User.create(name: "Jim")

    expect(user2).not_to be_valid
  end

  it 'cannot create a user with the same uid' do
    user1 = User.create(name: "Jim",
                        uid: 123456)
    user2 = User.create(name: "Jim",
                        uid: 123456)

    expect(user2).not_to be_valid
  end
end
