require 'rails_helper'

RSpec.describe TodoItem, type: :model do
  it 'is valid when required attributes are present' do
    expect(FactoryGirl.build(:todo_item)).to be_valid
  end

  context 'is invalid' do
    specify 'when title is blank' do
      expect(FactoryGirl.build(:todo_item, title: '')).not_to be_valid
    end
  end
end
