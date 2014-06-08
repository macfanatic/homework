require 'spec_helper'

describe ParseLineIntoHash do
  let(:input) { "$4.99 TXT MESSAGING - 250 09/29 - 10/28 4.99" }

  def results
    ParseLineIntoHash.call input
  end

  it "returns a Hash" do
    expect(results).to be_a(Hash)
  end

  it "extracted the price" do
    expect(results[:price]).to eq "4.99"
  end

  it "extracted the date range" do
    expect(results[:date_range]).to eq "09/29 - 10/28"
  end

  it "extracted the description" do
    expect(results[:feature]).to eq "TXT MESSAGING"
  end
end
