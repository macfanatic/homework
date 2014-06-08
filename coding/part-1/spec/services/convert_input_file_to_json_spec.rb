require 'spec_helper'

describe ConvertInputFileToJSON do
  let(:path) { "./input.txt" }

  def results
    ConvertInputFileToJSON.call path
  end

  it "calls service correctly" do
    expect(ParseLineIntoHash).to receive(:call).with(kind_of(String)).exactly(3).times

    results
  end

  it "returns a string" do
    expect(results).to be_a String
  end

  it "returns a JSON encoded array" do
    decoded = JSON.parse results
    expect(decoded).to be_a Array
  end
end
