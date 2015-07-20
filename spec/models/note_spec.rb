require 'rails_helper'

RSpec.describe Note, :type => :model do
  let!(:note) do
    Note.create(user_id: 1,
                body: "This is the body of awesome note or great note. Something like that",
                title: "Greatest Note Ever")
  end

  it "is valid" do
    expect(note).to be_valid
  end

  it 'is invalid without a user_id' do
    note.user_id = nil
    expect(note).not_to be_valid

    note.user_id = ""
    expect(note).not_to be_valid
  end

end
