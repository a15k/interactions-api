require 'rails_helper'
require 'byebug'

RSpec.describe Api::V1::Bindings::Flag do

  it 'list invalid enum property' do
    expect{described_class.new(type: "Booyah")}.to raise_error(ArgumentError)
  end

end
