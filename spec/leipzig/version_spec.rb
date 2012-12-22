require 'leipzig/version'

describe 'Version' do
  it 'returns version string' do
    Leipzig::VERSION.should match(/\d\.\d\.\d/)
  end
end
